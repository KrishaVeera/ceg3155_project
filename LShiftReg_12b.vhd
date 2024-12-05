library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- left shift register
entity LShiftReg_12b is
    port(
        LOAD, SHIFTL, CLK: in std_logic;
        INPUT: in std_logic_vector(11 downto 0);
        OUTPUT: out std_logic_vector(11 downto 0)
    );
end LShiftReg_12b;

architecture struct OF LShiftReg_12b is
    signal signalenardFF: std_logic_vector(11 downto 0);
    signal signalMUX: std_logic_vector(11 downto 0);
    signal signalQshift: std_logic_vector(11 downto 0);
    
begin


    -- Shift signal logic
    signalQshift(11 downto 1) <= signalenardFF(10 downto 0);
    signalQshift(0) <= '0';

    ENDFF_0: entity work.enardFF_2(rtl)
        port map(signalMUX(0), LOAD, CLK, signalenardFF(0));
    ENDFF_1: entity work.enardFF_2(rtl)
        port map(signalMUX(1), LOAD, CLK, signalenardFF(1));
    ENDFF_2: entity work.enardFF_2(rtl)
        port map(signalMUX(2), LOAD, CLK, signalenardFF(2));
    ENDFF_3: entity work.enardFF_2(rtl)
        port map(signalMUX(3), LOAD, CLK, signalenardFF(3));
    ENDFF_4: entity work.enardFF_2(rtl)
        port map(signalMUX(4), LOAD, CLK, signalenardFF(4));
    ENDFF_5: entity work.enardFF_2(rtl)
        port map(signalMUX(5), LOAD, CLK, signalenardFF(5));
    ENDFF_6: entity work.enardFF_2(rtl)
        port map(signalMUX(6), LOAD, CLK, signalenardFF(6));
    ENDFF_7: entity work.enardFF_2(rtl)
        port map(signalMUX(7), LOAD, CLK, signalenardFF(7));
    ENDFF_8: entity work.enardFF_2(rtl)
        port map(signalMUX(8), LOAD, CLK, signalenardFF(6));
    ENDFF_9: entity work.enardFF_2(rtl)
        port map(signalMUX(9), LOAD, CLK, signalenardFF(7));
    ENDFF_10: entity work.enardFF_2(rtl)
        port map(signalMUX(10), LOAD, CLK, signalenardFF(6));
    ENDFF_11: entity work.enardFF_2(rtl)
        port map(signalMUX(11), LOAD, CLK, signalenardFF(7));    
    -- SHIFTL is the select to determine the register's input
    -- OUTPUT <= left shifted signal if SHIFTL is 1
    -- OUTPUT <= INPUT signal if SHIFTL is 0
        MUX2to1_12b: entity work.mux2to1_12b(struct)
        port map(INPUT, signalQshift, SHIFTL, signalMUX);
    OUTPUT <= signalenardFF;
end struct;