LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY UARTReciever IS
	PORT (
		RxD, GReset, BClkx8, GClock : IN STD_LOGIC;
		RecieveOut : OUT STD_LOGIC_VECTOR(7 downto 0);
		RDRF : OUT STD_LOGIC
	);
END UARTReciever;

ARCHITECTURE basic of UARTReciever IS
	
	COMPONENT counter_4bit
		PORT (
			CLK   : in STD_LOGIC;
         i_enable   : in STD_LOGIC;
		   i_hold : IN STD_LOGIC;
		   i_reset : IN STD_LOGIC;
         COUNT : out STD_LOGIC_VECTOR (3 downto 0)
		);	
	END COMPONENT;
	
	COMPONENT equality_Comparator_4bit
		PORT (
			A, B : IN STD_LOGIC_VECTOR(3 downto 0);
			isEqual : OUT STD_LOGIC		
		);
	END COMPONENT;
	
	COMPONENT SerialInParallelOut_8Bit
		PORT (
			i_reset	: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_shift  : IN  STD_LOGIC;
			i_clock	: IN	STD_LOGIC;
			s_out	: OUT	STD_LOGIC_VECTOR(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT dFF_8bit
		PORT (
			i_d         : IN  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit input data
			i_en		  : IN STD_LOGIC;
			i_reset	  : IN STD_LOGIC;
			i_clock     : IN  STD_LOGIC;                      -- Clock input
			o_q         : OUT STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit output data
			o_qBar      : OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT d_FF
        PORT(
            i_d, i_en, i_reset       : IN  STD_LOGIC;
            i_clock   : IN  STD_LOGIC;
            o_q       : OUT STD_LOGIC;
            o_qBar    : OUT STD_LOGIC
        );
    END COMPONENT;
	
	SIGNAL countFourVal, countEightVal, numBitsCollected : STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL transitoryPRecieve : STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL isInMiddle, isAtEight, startSample, isStartBit, Latch8, Latch4, captureBit, finishedCapture, finishedCaptureLatch, resetbitCounter : STD_LOGIC;
begin
	counter_4bit_countmiddle : counter_4bit
		PORT MAP (
			CLK => BClkx8,
			i_enable => isInMiddle,
			i_hold => '0',
			i_reset => GReset,
			COUNT => countFourVal
		);
	counter_4bit_counteight : counter_4bit
		PORT MAP (
			CLK => BClkx8,
			i_enable => Latch8,
			i_hold => '0',
			i_reset => GReset,
			COUNT => countEightVal
		);
	
	isInMiddle <= NOT isStartBit AND NOT startSample AND NOT (NOT (countFourVal(3) XOR '0') 
	AND NOT (countFourVal(2) XOR '0') AND NOT (countFourVal(1) XOR '1') AND NOT (countFourVal(0) XOR '1'));
	isAtEight <= (NOT isInMiddle AND isStartBit) OR (startSample AND NOT (NOT (countEightVal(3) XOR '0') 
	AND NOT (countEightVal(2) XOR '1') AND NOT (countEightVal(1) XOR '1') AND NOT (countEightVal(0) XOR '0')));
	d_FF_latch8 : d_FF
		PORT MAP (
			i_d => isAtEight,
			i_en => '1',
			i_reset => GReset,
			i_clock => BClkx8,
			o_q => Latch8,
			o_qBar => open
		);
	d_FF_latch4 : d_FF
		PORT MAP (
			i_d => isInMiddle,
			i_en => '1',
			i_reset => GReset,
			i_clock => BClkx8,
			o_q => Latch4,
			o_qBar => open
		);
	isStartBit <= NOT RxD AND NOT Latch4 AND NOT (numBitsCollected(3) XOR '0') AND NOT (numBitsCollected(2) XOR '0') AND NOT (numBitsCollected(1) XOR '0') AND NOT (numBitsCollected(0) XOR '0');
	equality_Comparator_4bit_startsmpl : equality_Comparator_4bit
		PORT MAP (
			A => numBitsCollected,
			B => "0001",
			isEqual => startSample
		);
	
	equality_Comparator_4bit_finishsmpl : equality_Comparator_4bit
		PORT MAP (
			A => numBitsCollected,
			B => "1001",
			isEqual => finishedCapture
		);
	d_FF_finishedCap : d_FF
		PORT MAP (
			i_d => finishedCapture,
			i_en => '1',
			i_reset => GReset,
			i_clock => BClkx8,
			o_q => finishedCaptureLatch,
			o_qBar => open
		);
	resetbitCounter <= finishedCaptureLatch OR GReset;
	captureBit <= (NOT Latch4 AND Latch8);
	counter_4bit_countRecieved : counter_4bit
		PORT MAP (
			CLK => captureBit,
			i_enable => '1',
			i_hold => '0',
			i_reset => resetbitCounter,
			COUNT => numBitsCollected
		);
	
	SerialInParallelOut_8Bitinst : SerialInParallelOut_8Bit
		PORT MAP (
			i_reset => GReset,
			i_enable => '1',
			i_shift => RxD,
			i_clock => Latch8,
			s_out => transitoryPRecieve
		);
		
	dFF_8bit_RDR : dFF_8bit
		PORT MAP (
			i_d => transitoryPRecieve,
			i_en => '1',
			i_reset => GReset,
			i_clock => BClkx8,
			o_q => RecieveOut,
			o_qBar => open
		);
	
	RDRF <= finishedCapture;
	
		
end basic;