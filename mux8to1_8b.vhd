library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX8to1_8b is
 Port (
    IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7: in std_logic_vector(7 downto 0);
    SEL: in std_logic_vector(2 downto 0);
    output: out std_logic_vector(7 downto 0)
 );
end MUX8to1_8b;

architecture struct of MUX8to1_8b is
    signal MUX1out, MUX2out: std_logic_vector(7 downto 0);
begin
    MUX1: entity work.MUX4to1_8b(struct)
        port map(IN0, IN2, IN1, IN3, SEL(1), SEL(0), MUX1out);

    MUX2: entity work.MUX4to1_8b(struct)
        port map(IN4, IN6, IN5, IN7, SEL(1), SEL(0), MUX2out);

    MUX3: entity work.MUX2to1_8b(struct)
        port map(MUX1out, MUX2out, SEL(2), output);
end ;