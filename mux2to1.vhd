library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- MUX 2 to 1 with inputs and outputs as 8 bit std_logic_vectors
-- OUT1 <= IN1 when SEL is 0
-- OUT1 <= IN2 when SEL is 1
entity mux2to1 is
    port(
        IN1, IN2: in std_logic;
        Sel: in std_logic;
        OUT1: out std_logic
    );
end mux2to1;

architecture struct OF mux2to1 is
begin
    OUT1 <= ((IN1 and not(Sel)) or (IN2 and Sel));
end struct;