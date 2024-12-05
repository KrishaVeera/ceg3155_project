
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity trafficLightTopLevel IS
	PORT (
		GClock, GReset, SSCS, ProceedNextState : IN STD_LOGIC;
		MSC, SSC : IN STD_LOGIC_VECTOR(3 downto 0);
		MSTL, SSTL : OUT STD_LOGIC_VECTOR(2 downto 0);
		SegmentOut : OUT STD_LOGIC_VECTOR(13 downto 0)
	);
END trafficLightTopLevel;

architecture basic of trafficLightTopLevel IS
	
	COMPONENT BCD_to_7Segment 
		PORT (
			A_in : IN  STD_LOGIC_VECTOR(3 downto 0); 
			seg : OUT STD_LOGIC_VECTOR(13 downto 0)  
		);
	END COMPONENT;
	
	COMPONENT equality_Comparator_4bit
		PORT (
			A, B : IN STD_LOGIC_VECTOR(3 downto 0);
			isEqual : OUT STD_LOGIC		
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
	
	COMPONENT mux2to1_1bit
		PORT (
			d0 : IN STD_LOGIC;
         d1 : IN STD_LOGIC;
         sel : IN STD_LOGIC;
         d_out : OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT mux2to1_2bit
		PORT (
			sel     : IN  STD_LOGIC;                             -- Select input
         d_in1   : IN  STD_LOGIC_VECTOR(1 downto 0);        -- 8-bit Data input 1
         d_in2   : IN  STD_LOGIC_VECTOR(1 downto 0);        -- 8-bit Data input 2                         -- Reset input
         d_out   : OUT STD_LOGIC_VECTOR(1 downto 0) 
		);
	END COMPONENT;
	
	COMPONENT mux4to1_1bit
		PORT (
			d_in : IN STD_LOGIC_VECTOR(3 downto 0);
			sel : IN STD_LOGIC_VECTOR(1 downto 0);
			en : IN STD_LOGIC;
			d_out : OUT STD_LOGIC
		);
	END COMPONENT;
	
	component d_FF
       Port (
				i_d, i_en, i_reset			: IN	STD_LOGIC;
				i_clock			: IN	STD_LOGIC;
				o_q, o_qBar		: OUT	STD_LOGIC
       );
    end component;
	 
	COMPONENT clk_div
		PORT (
			clock_25Mhz				: IN	STD_LOGIC;
			clock_1MHz				: OUT	STD_LOGIC;
			clock_100KHz			: OUT	STD_LOGIC;
			clock_10KHz				: OUT	STD_LOGIC;
			clock_1KHz				: OUT	STD_LOGIC;
			clock_100Hz				: OUT	STD_LOGIC;
			clock_10Hz				: OUT	STD_LOGIC;
			clock_1Hz				: OUT	STD_LOGIC
		);
	END COMPONENT;
	
	signal TransitorySegmentOut : STD_LOGIC_VECTOR(13 downto 0);
	signal MT, SST : STD_LOGIC_VECTOR(3 downto 0);
	signal transitoryMSLT, transitoryMTTT, transitorySSLT, transitorySSTT, displayOnBCD, displayOnBCD2 : STD_LOGIC_VECTOR(3 downto 0);
	signal MSTLIsGreen, MSTLIsYellow, MSTLIsRed : STD_LOGIC;
	signal SSTLIsGreen, SSTLIsYellow : STD_LOGIC;
	signal STDtransitoryMSTL, STDtransitorySSTL, STDtransitoryMSTLDecider, STDtransitorySSTLDecider : STD_LOGIC_VECTOR(1 downto 0);
	signal BrakeNextState, MSLTHoldCond, MSTLReachedEnd, MTTTHoldCond, SSTLHoldCond, SSTHoldCond : STD_LOGIC;
	signal SSTLReachedEnd : STD_LOGIC;
	signal SSTReachedEnd : STD_LOGIC;
	signal MTReachedEnd : STD_LOGIC;
begin
	MT <= "1100";
	SST <= "1000"; 
	
	
	STDtransitoryMSTL <= STDtransitoryMSTLDecider;
	STDtransitorySSTL <= STDtransitorySSTLDecider;
	MSLTHoldCond <= (NOT (ProceedNextState AND SSCS)) AND MSTLReachedEnd;
	MTTTHoldCond <= NOT ProceedNextState AND MTReachedEnd;
	SSTLHoldCond <= NOT ProceedNextState AND SSTLReachedEnd;
	SSTHoldCond <= NOT ProceedNextState AND SSTReachedEnd;
		
	counter_4bit_MSLTimer : counter_4bit
		PORT MAP (
			CLK => GClock,
			i_enable => STDtransitoryMSTL(1),
			i_hold => MSLTHoldCond,
			i_reset => GReset,
			COUNT => transitoryMSLT
		);
	
	equality_Comparator_4bit_MSLT_MSC : equality_Comparator_4bit
		PORT MAP (
			A => transitoryMSLT,
			B => MSC,
			isEqual => MSTLReachedEnd
		);
		
	counter_4bit_MTT : counter_4bit
		PORT MAP (
			CLK => GClock,
			i_enable => STDtransitoryMSTL(0),
			i_hold => MTTTHoldCond,
			i_reset => GReset,
			COUNT => transitoryMTTT
		);
	
	equality_Comparator_4bit_MTTTT_MT : equality_Comparator_4bit
		PORT MAP (
			A => transitoryMTTT,
			B => MT,
			isEqual => MTReachedEnd
		);
		
	counter_4bit_SSLTimer : counter_4bit
		PORT MAP (
			CLK => GClock,
			i_enable => STDtransitorySSTL(1),
			i_hold => SSTLHoldCond,
			i_reset => GReset,
			COUNT => transitorySSLT
		);
	
	equality_Comparator_4bit_SSLT_SSC : equality_Comparator_4bit
		PORT MAP (
			A => transitorySSLT,
			B => SSC,
			isEqual => SSTLReachedEnd
		);
		
	counter_4bit_SST : counter_4bit
		PORT MAP (
			CLK => GClock,
			i_enable => STDtransitorySSTL(0),
			i_hold => SSTHoldCond,
			i_reset => GReset,
			COUNT => transitorySSTT
		);
	
	equality_Comparator_4bit_SSTT_SST : equality_Comparator_4bit
		PORT MAP (
			A => transitorySSTT,
			B => SST,
			isEqual => SSTReachedEnd
		);
		
	MSTLIsGreen <= (((NOT SSCS OR NOT MSTLReachedEnd) AND (STDtransitoryMSTL(1) AND NOT STDtransitoryMSTL(0))) OR 
	(SSTReachedEnd OR (NOT STDtransitoryMSTL(1) OR NOT STDtransitoryMSTL(0)))) 
	AND NOT (MSTLIsYellow OR STDtransitorySSTL(1) OR STDtransitorySSTL(0)) AND NOT SSTLIsGreen;
	
	MSTLIsYellow <= (((SSCS AND MSTLReachedEnd) AND (STDtransitoryMSTL(1) AND NOT STDtransitoryMSTL(0))) OR 
	(NOT MTReachedEnd AND (NOT STDtransitoryMSTL(1) AND STDtransitoryMSTL(0))));
	
	MSTLIsRed <= (MTReachedEnd AND (NOT STDtransitoryMSTL(1) AND STDtransitoryMSTL(0))) OR 
	((NOT SSTReachedEnd OR NOT SSTLReachedEnd) AND (NOT STDtransitoryMSTL(1) AND NOT STDtransitoryMSTL(0)));
	
	BrakeNextState <= GClock AND (ProceedNextState OR ((NOT STDtransitorySSTLDecider(1) AND NOT STDtransitorySSTLDecider(0)) 
	AND (NOT STDtransitoryMSTLDecider(1) AND NOT STDtransitoryMSTLDecider(0))));
	d_FF_MSTL_High : d_FF
		PORT MAP (
			i_d => MSTLIsGreen, 
			i_en => '1',
			i_reset => GReset,
			i_clock => BrakeNextState, 
			o_q => STDtransitoryMSTLDecider(1), 
			o_qBar => open
		);
		
	d_FF_MSTL_Low : d_FF
		PORT MAP (
			i_d => MSTLIsYellow, 
			i_en => '1',
			i_reset => GReset,
			i_clock => BrakeNextState, 
			o_q => STDtransitoryMSTLDecider(0), 
			o_qBar => open
		);
	
	SSTLIsGreen <= (MTReachedEnd AND (NOT STDtransitorySSTL(1) AND NOT STDtransitorySSTL(0))) OR 
	(NOT SSTLReachedEnd AND (STDtransitorySSTL(1) AND NOT STDtransitorySSTL(0)));
	
	SSTLIsYellow <= (SSTLReachedEnd AND (STDtransitorySSTL(1) AND NOT STDtransitorySSTL(0))) OR 
	(NOT SSTReachedEnd AND (NOT STDtransitorySSTL(1) AND STDtransitorySSTL(0)));	
	
	
	d_FF_SSTL_High : d_FF
		PORT MAP (
			i_d => SSTLIsGreen, 
			i_en => '1',
			i_reset => GReset,
			i_clock => BrakeNextState, 
			o_q => STDtransitorySSTLDecider(1), 
			o_qBar => open
		);
		
	d_FF_SSTL_Low : d_FF
		PORT MAP (
			i_d => SSTLIsYellow, 
			i_en => '1',
			i_reset => GReset,
			i_clock => BrakeNextState, 
			o_q => STDtransitorySSTLDecider(0), 
			o_qBar => open
		);
	
	SSTL(0) <= NOT STDtransitorySSTLDecider(1) AND NOT STDtransitorySSTLDecider(0);
	SSTL(1) <= STDtransitorySSTLDecider(0);
	SSTL(2) <= STDtransitorySSTLDecider(1);
	MSTL(0) <= NOT STDtransitoryMSTLDecider(1) AND NOT STDtransitoryMSTLDecider(0);
	MSTL(1) <= STDtransitoryMSTLDecider(0);
	MSTL(2) <= STDtransitoryMSTLDecider(1);
	
	displayOnBCD <= transitoryMSLT OR transitoryMTTT OR transitorySSLT OR transitorySSTT;
	
	BCD_to_7Segment_inst : BCD_to_7Segment
		PORT MAP (
			A_in => displayOnBCD,
			seg => TransitorySegmentOut
		);
	SegmentOut <= NOT TransitorySegmentOut;
	
end basic;
