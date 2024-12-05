library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- MUX 4 to 1 with inputs and outputs as 8 bit std_logic_vectors
-- Truth table:
-- Sel1     Sel2    output
--   0       0       IN0
--   0       1       IN2
--   1       0       IN1
--   1       1       IN3
entity mux4to1_8b is
    port(
        IN0, IN1, IN2, IN3: in std_logic_vector(7 downto 0);
        Sel1, Sel2: in std_logic;
        OUTPUT: out std_logic_vector(7 downto 0)
    );
end mux4to1_8b;

architecture struct of mux4to1_8b is
    signal signalMUX1, signalMUX2: std_logic_vector(7 downto 0);
begin
    MUX1: entity work.mux2to1_8b(struct)
        port map(IN0, IN1, Sel1, signalMUX1);
    MUX2: entity work.mux2to1_8b(struct)
        port map(IN2, IN3, Sel1, signalMUX2);
    MUX3: entity work.mux2to1_8b(struct)
		  port map(signalMUX1, signalMUX2, Sel2, OUTPUT);
       
end ;