LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ParallelInSerialOut_8Bit IS
	PORT(
		i_d		: IN	STD_LOGIC_VECTOR(9 downto 0);
		i_reset	: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_shift  : IN  STD_LOGIC;
		i_shift_Load	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		s_out	: OUT	STD_LOGIC);
END ParallelInSerialOut_8Bit;

ARCHITECTURE rtl OF ParallelInSerialOut_8Bit IS
	SIGNAL d_sigs : STD_LOGIC_VECTOR(9 downto 0);
	SIGNAL q_outs : STD_LOGIC_VECTOR(9 downto 0);

	COMPONENT d_FF IS
	PORT(
		i_d, i_en, i_reset			: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_q, o_qBar		: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN --                             LOADING                        SHIFTING
	d_sigs(0) <= ((i_d(0) AND i_shift_Load) OR (q_outs(1) AND not i_shift_Load));
	d_sigs(1) <= ((i_d(1) AND i_shift_Load) OR (q_outs(2) AND not i_shift_Load));
	d_sigs(2) <= ((i_d(2) AND i_shift_Load) OR (q_outs(3) AND not i_shift_Load));
	d_sigs(3) <= ((i_d(3) AND i_shift_Load) OR (q_outs(4) AND not i_shift_Load));
	d_sigs(4) <= ((i_d(4) AND i_shift_Load) OR (q_outs(5) AND not i_shift_Load));
	d_sigs(5) <= ((i_d(5) AND i_shift_Load) OR (q_outs(6) AND not i_shift_Load));
	d_sigs(6) <= ((i_d(6) AND i_shift_Load) OR (q_outs(7) AND not i_shift_Load));
	d_sigs(7) <= ((i_d(7) AND i_shift_Load) OR (q_outs(8) AND not i_shift_Load));
	d_sigs(8) <= ((i_d(8) AND i_shift_Load) OR (q_outs(9) AND not i_shift_Load));
	d_sigs(9) <= ((i_d(9) AND i_shift_Load) OR (i_shift   AND not i_shift_Load));
	
bit0: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => d_sigs(0),
		i_clock => i_clock,
		o_q => q_outs(0)
	);
	
bit1: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => d_sigs(1),
		i_clock => i_clock,
		o_q => q_outs(1)
	);
	
bit2: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => d_sigs(2),
		i_clock => i_clock,
		o_q => q_outs(2)
	);
	
bit3: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => d_sigs(3),
		i_clock => i_clock,
		o_q => q_outs(3)
	);
	
bit4: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => d_sigs(4),
		i_clock => i_clock,
		o_q => q_outs(4)
	);
	
bit5: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => d_sigs(5),
		i_clock => i_clock,
		o_q => q_outs(5)
	);
	
bit6: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => d_sigs(6),
		i_clock => i_clock,
		o_q => q_outs(6)
	);
	
bit7: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => d_sigs(7),
		i_clock => i_clock,
		o_q => q_outs(7)
	);
	
bit8: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => d_sigs(8),
		i_clock => i_clock,
		o_q => q_outs(8)
	);
	
bit9: d_FF
	Port map(
		i_reset => i_reset,
		i_en => i_enable,
		i_d => d_sigs(9),
		i_clock => i_clock,
		o_q => q_outs(9)
	);
--  Output Driver
	s_out		<=	q_outs(0);

END rtl;