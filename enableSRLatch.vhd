
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY enabledSRLatch IS
	PORT(
		i_set, i_reset	: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
END enabledSRLatch;

ARCHITECTURE rtl OF enabledSRLatch IS
	SIGNAL int_q, int_qBar : STD_LOGIC;
	SIGNAL int_sSignal, int_rSignal : STD_LOGIC;
BEGIN

	--  Concurrent Signal Assignment

	int_sSignal	<=	i_set nand i_enable;
	int_rSignal	<=	i_enable nand i_reset;
	int_q		<=	int_sSignal nand int_qBar;
	int_qBar	<=	int_q nand int_rSignal;

	--  Output Driver

	o_q		<=	int_q;
	o_qBar		<=	int_qBar;

END rtl;
