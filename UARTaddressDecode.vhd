library ieee;
use ieee.std_logic_1164.all;

entity UARTaddressDecode is
	port(
	Address : in STD_LOGIC_VECTOR(1 downto 0);
	RWbar   : in STD_LOGIC;
	DecodeOut   : out STD_LOGIC_VECTOR(5 downto 0));
end UARTaddressDecode;

architecture rtl of UARTaddressDecode is
	SIGNAL notAddress : STD_LOGIC_VECTOR(1 downto 0);
	SIGNAL notRWbar : STD_LOGIC;
begin
	notAddress <= not Address;
	notRWbar <= not RWbar;
	
	DecodeOut(0)<= notAddress(1) AND notAddress(0) AND notRWbar;
	DecodeOut(1)<= notAddress(1) AND notAddress(0) AND RWbar;
	DecodeOut(2)<= notAddress(1) AND Address(0) AND notRWbar;
	DecodeOut(3)<= notAddress(1) AND Address(0) AND RWbar;
	DecodeOut(4)<= Address(1) AND notRWbar;
	DecodeOut(5)<= Address(1) AND RWbar;
end architecture rtl;