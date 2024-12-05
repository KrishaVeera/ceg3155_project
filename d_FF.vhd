--FROM PROF just changed name to organize better

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY d_FF IS
    PORT(
        i_d, i_en, i_reset : IN STD_LOGIC;
        i_clock            : IN STD_LOGIC;
        o_q, o_qBar        : OUT STD_LOGIC
    );
END d_FF;

ARCHITECTURE behavioral OF d_FF IS
    SIGNAL int_q : STD_LOGIC;
BEGIN
    PROCESS(i_clock, i_reset)
    BEGIN
        -- Reset Logic
        IF i_reset = '1' THEN
            int_q <= '0';
        
        -- Latch data on clock edge, or reset if enable is low
        ELSIF rising_edge(i_clock) THEN
            IF i_en = '1' THEN
                int_q <= i_d;      -- Capture input if enabled
            ELSE
                int_q <= '0';      -- Set to 0 if not enabled
            END IF;
        END IF;
    END PROCESS;
    
    -- Output Assignments
    o_q <= int_q;
    o_qBar <= NOT int_q;
END behavioral;