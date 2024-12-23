library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLKcounter is
 Port (
    CTRload, CTRinc, CTRSEL, CLK: in std_logic;
    c: out std_logic
 );
end CLKcounter;

architecture struct of CLKcounter is
    signal muxout, COUNT: std_logic_vector(11 downto 0);
begin
    counter: entity work.LShiftReg_12b(struct)
        port map(CTRload, CTRinc, CLK, muxout, COUNT);

    mux: entity work.mux2to1_12b(struct)
        port map("111111000000", "111111111110", CTRSEL, muxout);

    c <= COUNT(11);
end ;