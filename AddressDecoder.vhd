library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AddressDecoder is
 Port (
    CLK: in std_logic;
    ADDR: in std_logic_vector(1 downto 0);
    R, UARTselect: in std_logic;
    RDRout, SCSRout, SCCRout: in std_logic_vector(7 downto 0);
    DATA_BUS_IN: in std_logic_vector(7 downto 0);
    DATA_BUS_OUT: out std_logic_vector(7 downto 0);
    AD_TDRload, AD_SCCRload: out std_logic;
    AD_TDRin, AD_SCCRin: out std_logic_vector(7 downto 0);
    AD_TDREload, AD_TDREin: out std_logic;
    AD_RDRFload, AD_RDRFin: out std_logic
 );
end AddressDecoder;

architecture struct of AddressDecoder is
    signal MUX1out: std_logic_vector(7 downto 0);

begin
    MUX1: entity work.mux2to1_8b(struct)
        port map(RDRout, SCSRout, ADDR(0), MUX1out);

    MUX2: entity work.mux2to1_8b(struct)
        port map(MUX1out, SCCRout, ADDR(1), DATA_BUS_OUT);

    AD_TDRload <= (not ADDR(1) and not ADDR(0) and not R and UARTselect);
    AD_SCCRload <= (ADDR(1) and not R and UARTselect);
    AD_TDRin <= DATA_BUS_IN;
    AD_SCCRin <= DATA_BUS_IN;
    AD_TDREload <= (not ADDR(1) and not ADDR(0) and not R);
    AD_TDREin <= '0';
    AD_RDRFload <= (not ADDR(1) and not ADDR(0) and R);
    AD_RDRFin <= '0';

end ;