library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Transmitter is
 Port (
    Greset, BCLK: in std_logic;
    TxD: out std_logic;
    TSRout: out std_logic_vector(7 downto 0)
 );
end Transmitter;