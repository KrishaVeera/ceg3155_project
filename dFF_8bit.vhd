LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY dFF_8bit IS
    PORT(
        i_d         : IN  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit input data
		  i_en		  : IN STD_LOGIC;
		  i_reset	  : IN STD_LOGIC;
        i_clock     : IN  STD_LOGIC;                      -- Clock input
        o_q         : OUT STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit output data
        o_qBar      : OUT STD_LOGIC_VECTOR(7 downto 0)   -- 8-bit inverted output data
    );
END dFF_8bit;

ARCHITECTURE rtl OF dFF_8bit IS
    COMPONENT d_FF
        PORT(
            i_d, i_en, i_reset       : IN  STD_LOGIC;
            i_clock   : IN  STD_LOGIC;
            o_q       : OUT STD_LOGIC;
            o_qBar    : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL q_internal   : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL qBar_internal: STD_LOGIC_VECTOR(7 downto 0);

BEGIN
    
	 
    dff_inst0: d_FF
        PORT MAP (
            i_d     => i_d(0),
				i_en	  => i_en,
				i_reset => i_reset,
            i_clock => i_clock,
            o_q     => q_internal(0),
            o_qBar  => qBar_internal(0)
        );

    dff_inst1: d_FF
        PORT MAP (
            i_d     => i_d(1),
				i_en	  => i_en,
				i_reset => i_reset,
            i_clock => i_clock,
            o_q     => q_internal(1),
            o_qBar  => qBar_internal(1)
        );

    dff_inst2: d_FF
        PORT MAP (
            i_d     => i_d(2),
				i_en	  => i_en,
				i_reset => i_reset,
            i_clock => i_clock,
            o_q     => q_internal(2),
            o_qBar  => qBar_internal(2)
        );

    dff_inst3: d_FF
        PORT MAP (
            i_d     => i_d(3),
				i_en	  => i_en,
				i_reset => i_reset,
            i_clock => i_clock,
            o_q     => q_internal(3),
            o_qBar  => qBar_internal(3)
        );

    dff_inst4: d_FF
        PORT MAP (
            i_d     => i_d(4),
				i_en	  => i_en,
				i_reset => i_reset,
            i_clock => i_clock,
            o_q     => q_internal(4),
            o_qBar  => qBar_internal(4)
        );

    dff_inst5: d_FF
        PORT MAP (
            i_d     => i_d(5),
				i_en	  => i_en,
				i_reset => i_reset,
            i_clock => i_clock,
            o_q     => q_internal(5),
            o_qBar  => qBar_internal(5)
        );

    dff_inst6: d_FF
        PORT MAP (
            i_d     => i_d(6),
				i_en	  => i_en,
				i_reset => i_reset,
            i_clock => i_clock,
            o_q     => q_internal(6),
            o_qBar  => qBar_internal(6)
        );

    dff_inst7: d_FF
        PORT MAP (
            i_d     => i_d(7),
				i_en	  => i_en,
				i_reset => i_reset,
            i_clock => i_clock,
            o_q     => q_internal(7),
            o_qBar  => qBar_internal(7)
        );

    -- Assign internal signals to outputs
    o_q <= q_internal;
    o_qBar <= qBar_internal;

END rtl;