LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SerialInParallelOut_8Bit IS
	PORT(
		i_reset	: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_shift  : IN  STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		s_out	: OUT	STD_LOGIC_VECTOR(7 downto 0));
END SerialInParallelOut_8Bit;

ARCHITECTURE rtl OF SerialInParallelOut_8Bit IS
	SIGNAL d_sigs : STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL q_outs : STD_LOGIC_VECTOR(7 downto 0);

	COMPONENT d_FF IS
	PORT(
		i_d, i_en, i_reset			: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_q, o_qBar		: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN
	
bit0: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => q_outs(1),
		i_clock => i_clock,
		o_q => q_outs(0)
	);
	
bit1: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => q_outs(2),
		i_clock => i_clock,
		o_q => q_outs(1)
	);
	
bit2: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => q_outs(3),
		i_clock => i_clock,
		o_q => q_outs(2)
	);
	
bit3: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => q_outs(4),
		i_clock => i_clock,
		o_q => q_outs(3)
	);
	
bit4: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => q_outs(5),
		i_clock => i_clock,
		o_q => q_outs(4)
	);
	
bit5: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => q_outs(6),
		i_clock => i_clock,
		o_q => q_outs(5)
	);
	
bit6: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => q_outs(7),
		i_clock => i_clock,
		o_q => q_outs(6)
	);
	
bit7: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => i_shift,
		i_clock => i_clock,
		o_q => q_outs(7)
	);
--  Output Driver
	s_out		<=	q_outs;

END rtl;