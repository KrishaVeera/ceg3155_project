library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SCCR is
 Port (
    CLK: in std_logic;
    SCCRin: in std_logic_vector(7 downto 0);
    SCCRload: in std_logic;
    SCCRout: out std_logic_vector(7 downto 0);
    SELout: out std_logic_vector(2 downto 0);
    TIE, RIE: out std_logic
 );
end SCCR;

architecture struct of SCCR is
    signal signalenardFF: std_logic_vector(7 downto 0);
begin
    
    --SEL:
    ENDFF_0: entity work.enardFF_2(rtl)
        port map(SCCRin(0), SCCRload, CLK, signalenardFF(0));
    ENDFF_1: entity work.enardFF_2(rtl)
        port map(SCCRin(1), SCCRload, CLK, signalenardFF(1));
    ENDFF_2: entity work.enardFF_2(rtl)
        port map(SCCRin(2), SCCRload, CLK, signalenardFF(2));
    
    
    
    ENDFF_3: entity work.enardFF_2(rtl)
        port map(SCCRin(3), SCCRload, CLK, signalenardFF(3));
    ENDFF_4: entity work.enardFF_2(rtl)
        port map(SCCRin(4), SCCRload, CLK, signalenardFF(4));
    ENDFF_5: entity work.enardFF_2(rtl)
        port map(SCCRin(5), SCCRload, CLK, signalenardFF(5));
    ENDFF_6: entity work.enardFF_2(rtl)
        port map(SCCRin(6), SCCRload, CLK, signalenardFF(6));
    ENDFF_7: entity work.enardFF_2(rtl)
        port map(SCCRin(7), SCCRload, CLK, signalenardFF(7));
    
    SCCRout <= signalenardFF;
    SELout <= signalenardFF(2 downto 0);
    TIE <= signalenardFF(7);
    RIE <= signalenardFF(6);
end ;