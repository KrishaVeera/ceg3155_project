LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY debouncer IS
	PORT(
		i_reset		: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_raw			: IN	STD_LOGIC;
		o_clean			: OUT	STD_LOGIC);
END debouncer;

ARCHITECTURE rtl OF debouncer IS
	SIGNAL con_vcc : STD_LOGIC;
	SIGNAL int_notQ1Output, int_q1Output, int_notD1Input, int_d1Input :STD_LOGIC;
	SIGNAL int_q2Output, int_notQ2Output, int_d2Input, int_debouncedRaw, int_feedback : STD_LOGIC;

	COMPONENT d_FF
		PORT(
			i_d, i_en, i_reset			: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			o_q, o_qBar		: OUT	STD_LOGIC);
	END COMPONENT;
BEGIN
	con_vcc <= '1';
first: d_FF
	PORT MAP (i_reset => i_reset,
			  i_d => int_notD1Input, 
			  i_en => con_vcc,
			  i_clock => i_clock,
			  o_q => int_q1Output,
	          o_qBar => int_notQ1Output);

second: d_FF
	PORT MAP (i_reset => i_reset,
			  i_d => int_d2Input, 
			  i_en => con_vcc,
			  i_clock => i_clock,
			  o_q => int_q2Output,
	          o_qBar => int_notQ2Output);

	-- Internal concurrent signal assignment
	int_notD1Input <= not(int_d1Input);
	int_d1Input <= i_raw nand int_feedback;
	int_feedback <= int_q2Output or int_debouncedRaw;
	int_d2Input <= int_notQ1Output and int_notQ2Output and i_raw;
	int_debouncedRaw <= int_q2Output nor int_notQ1Output;

	--  Output Concurrent Signal Assignment
	o_clean <= int_debouncedRaw;

END rtl;