LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY equality_Comparator_8bit IS
	PORT (
		A, B : IN STD_LOGIC_VECTOR(7 downto 0);
		isEqual : OUT STD_LOGIC
	);
END equality_Comparator_8bit;

architecture basic of equality_Comparator_8bit IS
	SIGNAL equalcond : STD_LOGIC;
begin 
	equalcond <= NOT (A(7) XOR B(7)) AND 
	             NOT (A(6) XOR B(6)) AND 
	             NOT (A(5) XOR B(5)) AND 
	             NOT (A(4) XOR B(4)) AND 
	             NOT (A(3) XOR B(3)) AND 
	             NOT (A(2) XOR B(2)) AND 
	             NOT (A(1) XOR B(1)) AND 
	             NOT (A(0) XOR B(0));

					
	isEqual <= equalcond;
end basic;