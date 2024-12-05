library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter is
 Port (
    CTRload, CTRinc, CLK: in std_logic;
    c: out std_logic
 );
end Counter;

architecture struct of Counter is
    signal COUNT: std_logic_vector(7 downto 0);
begin
    counter: entity work.LshiftReg_8b(struct)
        port map(CTRload, CTRinc, CLK, "11111110", COUNT);

    c <= COUNT(7);

end ;