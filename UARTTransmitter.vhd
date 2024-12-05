LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY UARTTransmitter IS
	PORT (
		loadTDR, GReset, GClock, BaudRate, shiftLoad : IN STD_LOGIC;
		D_In : IN STD_LOGIC_VECTOR(6 downto 0);
		TxD, TDRE, countEqualTenOut : OUT STD_LOGIC
	);
END UARTTransmitter;

ARCHITECTURE basic of UARTTransmitter IS

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
	
	COMPONENT ParallelInSerialOut_8Bit
		PORT (
			i_d		: IN	STD_LOGIC_VECTOR(9 downto 0);
			i_reset	: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_shift  : IN  STD_LOGIC;
			i_shift_Load	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			s_out	: OUT	STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT parityGen
		PORT (
			i_d	: IN	STD_LOGIC_VECTOR(6 downto 0);
			p_out	: OUT	STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT mux2to1_1bit
		PORT (
			d0 : IN STD_LOGIC;
			d1 : IN STD_LOGIC;
			sel : IN STD_LOGIC;
			d_out : OUT STD_LOGIC
		);
	END COMPONENT;
	
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
	
	signal transitoryI_D : STD_LOGIC_VECTOR(9 downto 0);
	signal d_indff, d_indffLatched : STD_LOGIC_VECTOR(7 downto 0);
	signal transitorySerialOut, enableCount, countEqualTen : STD_LOGIC;
	signal countValue : STD_LOGIC_VECTOR(3 downto 0);
begin


	transitoryI_D(9) <= '1';
	transitoryI_D(0) <= '0';
	
	d_indff(6 downto 0) <= D_In;
	d_indff(7) <= '0';
	
	dFF_8bitID : dFF_8bit
		PORT MAP (
			i_d => d_indff,
			i_en => loadTDR,
			i_reset => GReset,
			i_clock => GClock,
			o_q => d_indffLatched,
			o_qBar => open
		);
		
	transitoryI_D(7 downto 1) <= d_indffLatched(6 downto 0);
		
	parityGen_check : parityGen
		PORT MAP (
			i_d => transitoryI_D(7 downto 1),
			p_out => transitoryI_D(8)
		);
		
	ParallelInSerialOut_8BitTXD : ParallelInSerialOut_8Bit
		PORT MAP (
			i_d => transitoryI_D,
			i_reset => GReset,
			i_enable => '1',
			i_shift => '1',
			i_shift_Load => shiftLoad,
			i_clock => BaudRate,
			s_out => transitorySerialOut
		);
	
	
	mux2to1_1bit_selout : mux2to1_1bit
		PORT MAP (
			d0 => transitorySerialOut,
			d1 => '1',
			sel => shiftLoad,
			d_out => TxD
		);
	
	enableCount <= not countEqualTen;
	
	counter_4bit_count_10 : counter_4bit
		PORT MAP (
			CLK => BaudRate,
			i_enable => enableCount,
			i_hold => '0',
			i_reset => GReset,
			COUNT => countValue
		);
	
	equality_Comparator_4bit_donesend : equality_Comparator_4bit
		PORT MAP (
			A => countValue,
			B => "1010",
			isEqual => countEqualTen
		);
	countEqualTenOut <= countEqualTen;
	TDRE <= countEqualTen OR 
	(NOT (countValue(3) XOR '0') AND 
	             NOT (countValue(2) XOR '0') AND 
	             NOT (countValue(1) XOR '0') AND 
	             NOT (countValue(0) XOR '0'));
	
end basic;