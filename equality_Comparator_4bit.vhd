LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY equality_Comparator_4bit IS
	PORT (
		A, B : IN STD_LOGIC_VECTOR(3 downto 0);
		isEqual : OUT STD_LOGIC
	);
END equality_Comparator_4bit;

architecture basic of equality_Comparator_4bit IS
	SIGNAL equalcond, greatercond : STD_LOGIC;
begin 
	equalcond <= NOT (A(3) XOR B(3)) AND NOT (A(2) XOR B(2)) AND NOT (A(1) XOR B(1)) AND NOT (A(0) XOR B(0));
	greatercond <= (A(3) AND NOT B(3)) OR 
               (NOT (A(3) XOR B(3)) AND A(2) AND NOT B(2)) OR
               (NOT (A(3) XOR B(3)) AND NOT (A(2) XOR B(2)) AND A(1) AND NOT B(1)) OR
               (NOT (A(3) XOR B(3)) AND NOT (A(2) XOR B(2)) AND NOT (A(1) XOR B(1)) AND A(0) AND NOT B(0));
					
	isEqual <= equalcond OR greatercond;
end basic;