LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY parityGen IS
	PORT(
		i_d	: IN	STD_LOGIC_VECTOR(6 downto 0);
		p_out	: OUT	STD_LOGIC);
END parityGen;

ARCHITECTURE rtl OF parityGen IS

BEGIN 

	p_out <= i_d(0) XOR i_d(1) XOR i_d(2) XOR i_d(3) XOR i_d(4) XOR i_d(5) XOR i_d(6);

END rtl;