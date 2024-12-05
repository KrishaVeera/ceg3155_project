LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY debuggableTrafficLightController IS
	PORT (
		GClock, GReset, SSCS, RxD, simClock : IN STD_LOGIC;
		SW1, SW2 : IN STD_LOGIC_VECTOR(3 downto 0);
		TxD : OUT STD_LOGIC;
		SEL : IN STD_LOGIC_VECTOR(2 downto 0);
		MSTL, SSTL : OUT STD_LOGIC_VECTOR(2 downto 0);
		SegmentOut : OUT STD_LOGIC_VECTOR(13 downto 0)
	);
END debuggableTrafficLightController;
	
ARCHITECTURE basic OF debuggableTrafficLightController IS

	COMPONENT trafficLightTopLevel
		PORT (
			GClock, GReset, SSCS, ProceedNextState : IN STD_LOGIC;
			MSC, SSC : IN STD_LOGIC_VECTOR(3 downto 0);
			MSTL, SSTL : OUT STD_LOGIC_VECTOR(2 downto 0);
			SegmentOut : OUT STD_LOGIC_VECTOR(13 downto 0)
		);
	END COMPONENT;
	
	COMPONENT clk_div 
		PORT (
			clock_25Mhz				: IN	STD_LOGIC;
			clock_1MHz				: OUT	STD_LOGIC;
			clock_100KHz				: OUT	STD_LOGIC;
			clock_10KHz				: OUT	STD_LOGIC;
			clock_1KHz				: OUT	STD_LOGIC;
			clock_100Hz				: OUT	STD_LOGIC;
			clock_10Hz				: OUT	STD_LOGIC;
			clock_1Hz				: OUT	STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT debouncer
		PORT (
			i_reset		: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_raw			: IN	STD_LOGIC;
			o_clean			: OUT	STD_LOGIC
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
	
	COMPONENT UART_top
		PORT (
			RxD, Load, GReset, GClock : IN STD_LOGIC;
			SEL : IN STD_LOGIC_VECTOR(2 downto 0);
			State_Information : IN STD_LOGIC_VECTOR(5 downto 0);
			TxD, CanProceedState : OUT STD_LOGIC
		);
	END COMPONENT;
	
	signal ProceedNextState, dividedClock, transitoryClock, debouncedSSCS : STD_LOGIC;
	SIGNAL State_Information : STD_LOGIC_VECTOR(5 downto 0);
	signal transitorySW1, transitorySW2 : STD_LOGIC_VECTOR(3 downto 0);
	signal transitoryMSTL, transitorySSTL : STD_LOGIC_VECTOR(2 downto 0);
begin

	-- hit the little debounce
	debouncer_SCSS : debouncer
		PORT MAP (
			i_reset => GReset,
			i_clock => GClock,
			i_raw => SSCS,
			o_clean => debouncedSSCS
		);	
		
	debouncer_sw10 : debouncer
		PORT MAP (
			i_reset => GReset,
			i_clock => GClock,
			i_raw => SW1(0),
			o_clean => transitorySW1(0)
		);	
		
	debouncer_sw11 : debouncer
		PORT MAP (
			i_reset => GReset,
			i_clock => GClock,
			i_raw => SW1(1),
			o_clean => transitorySW1(1)
		);	
		
	debouncer_sw12 : debouncer
		PORT MAP (
			i_reset => GReset,
			i_clock => GClock,
			i_raw => SW1(2),
			o_clean => transitorySW1(2)
		);	
		
	debouncer_sw13 : debouncer
		PORT MAP (
			i_reset => GReset,
			i_clock => GClock,
			i_raw => SW1(3),
			o_clean => transitorySW1(3)
		);	
		
	debouncer_sw20 : debouncer
		PORT MAP (
			i_reset => GReset,
			i_clock => GClock,
			i_raw => SW2(0),
			o_clean => transitorySW2(0)
		);	
		
	debouncer_sw21 : debouncer
		PORT MAP (
			i_reset => GReset,
			i_clock => GClock,
			i_raw => SW2(1),
			o_clean => transitorySW2(1)
		);	
		
	debouncer_sw22 : debouncer
		PORT MAP (
			i_reset => GReset,
			i_clock => GClock,
			i_raw => SW2(2),
			o_clean => transitorySW2(2)
		);	
		
	debouncer_sw23 : debouncer
		PORT MAP (
			i_reset => GReset,
			i_clock => GClock,
			i_raw => SW2(3),
			o_clean => transitorySW2(3)
		);	
		

	clk_div_inst : clk_div
		PORT MAP (
			clock_25Mhz => GClock,
			clock_1MHz => open,
			clock_100KHz => open,
			clock_10KHz	=> open,
			clock_1KHz => open,
			clock_100Hz => open,
			clock_10Hz => open,
			clock_1Hz => dividedClock
		);
		
	
	--set to 1 when simulating 
	mux_2to1_1bit_chooseClock : mux2to1_1bit
		PORT MAP (
			d0 => dividedClock,
			d1 => GClock,
			sel => simClock,
			d_out => transitoryClock
		);
		
	trafficLighttopLevel_inst : trafficLightTopLevel
		PORT MAP (
			GClock => transitoryClock,
			GReset => GReset,
			SSCS => debouncedSSCS,
			ProceedNextState => ProceedNextState,
			MSC => transitorySW1,
			SSC => transitorySW2,
			MSTL => transitoryMSTL,
			SSTL => transitorySSTL,
			SegmentOut => SegmentOut
		);
	
		
	State_Information(5 downto 3) <= transitoryMSTL;
	State_Information(2 downto 0) <= transitorySSTL;
	
	MSTL <= transitoryMSTL;
	SSTL <= transitorySSTL;
	
	UART_inst : UART_top
		PORT MAP (
			RxD => RxD,
			Load =>'1',
			GReset => GReset,
			GClock => transitoryClock,
			SEL => SEL,
			State_Information => State_Information,
			TxD => TxD,
			CanProceedState => ProceedNextState
		);
		
	
end basic;