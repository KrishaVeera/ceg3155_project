library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ARShiftReg_8b is
 Port (
    LOAD, SHIFTR, CLK: in std_logic;
    INPUT: in std_logic_vector(7 downto 0);
    OUTPUT: out std_logic_vector(7 downto 0);
    ASout: out std_logic
 );
end ARShiftReg_8b;

architecture struct of ARShiftReg_8b is
    signal signalenardFF: std_logic_vector(7 downto 0);
    signal signalMUX: std_logic_vector(7 downto 0);
    signal signalQshift: std_logic_vector(7 downto 0);
begin

    -- Shift signal logic
    signalQshift(6 downto 0) <= signalenardFF(7 downto 1);
    signalQshift(7) <= '1';

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
    
    -- SHIFTL is the select to determine the register's input
    -- OUTPUT <= left shifted signal if SHIFTR is 1
    -- OUTPUT <= INPUT signal if SHIFTR is 0
    MUX2to1_8b: entity work.mux2to1_8b(struct)
    port map(INPUT, signalQshift, SHIFTR, signalMUX);
    
        OUTPUT <= signalenardFF;
    ASout <= signalenardFF(0);
end ;