library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- input and output are 8 bit std_logic_vectors
-- LOAD is given as the EN signal for the ENDFF
entity Reg_8b is
    port(
        LOAD, CLK: in std_logic;
        INPUT: in std_logic_vector(7 downto 0);
        OUTPUT: out std_logic_vector(7 downto 0)
    );
end Reg_8b;

architecture struct OF Reg_8b is
    signal signalenardFF: std_logic_vector(7 downto 0);
begin
    ENDFF_0: entity work.enardFF_2(rtl)
        port map(INPUT(0), LOAD, CLK, signalenardFF(0));
     ENDFF_1: entity work.enardFF_2(rtl)
        port map(INPUT(1), LOAD, CLK, signalenardFF(1));
     ENDFF_2: entity work.enardFF_2(rtl)
        port map(INPUT(2), LOAD, CLK, signalenardFF(2));
     ENDFF_3: entity work.enardFF_2(rtl)
        port map(INPUT(3), LOAD, CLK, signalenardFF(3));
     ENDFF_4: entity work.enardFF_2(rtl)
        port map(INPUT(4), LOAD, CLK, signalenardFF(4));
     ENDFF_5: entity work.enardFF_2(rtl)
        port map(INPUT(5), LOAD, CLK, signalenardFF(5));
     ENDFF_6: entity work.enardFF_2(rtl)
        port map(INPUT(6), LOAD, CLK, signalenardFF(6));
     ENDFF_7: entity work.enardFF_2(rtl)
        port map(INPUT(7), LOAD, CLK, signalenardFF(7));
    OUTPUT <= signalenardFF;
end struct;