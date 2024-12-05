library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- MUX 2 to 1 with inputs and outputs as 8 bit std_logic_vectors
-- OUT1 <= IN1 when SEL is 0
-- OUT1 <= IN2 when SEL is 1
entity MUX2to1_12b is
    port(
        IN1, IN2: in std_logic_vector(11 downto 0);
        Sel: in std_logic;
        OUT1: out std_logic_vector(11 downto 0)
    );
end MUX2to1_12b;

architecture struct OF MUX2to1_12b is
begin
    OUT1(11) <= ((IN1(11) and not(Sel)) or (IN2(11) and Sel));
    OUT1(10) <= ((IN1(10) and not(Sel)) or (IN2(10) and Sel));
    OUT1(9) <= ((IN1(9) and not(Sel)) or (IN2(9) and Sel));
    OUT1(8) <= ((IN1(8) and not(Sel)) or (IN2(8) and Sel));
    OUT1(7) <= ((IN1(7) and not(Sel)) or (IN2(7) and Sel));
    OUT1(6) <= ((IN1(6) and not(Sel)) or (IN2(6) and Sel));
    OUT1(5) <= ((IN1(5) and not(Sel)) or (IN2(5) and Sel));
    OUT1(4) <= ((IN1(4) and not(Sel)) or (IN2(4) and Sel));
    OUT1(3) <= ((IN1(3) and not(Sel)) or (IN2(3) and Sel));
    OUT1(2) <= ((IN1(2) and not(Sel)) or (IN2(2) and Sel));
    OUT1(1) <= ((IN1(1) and not(Sel)) or (IN2(1) and Sel));
    OUT1(0) <= ((IN1(0) and not(Sel)) or (IN2(0) and Sel));
end struct;