LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BCD_to_7Segment IS
    PORT (
        A_in : IN  STD_LOGIC_VECTOR(3 downto 0); 
        seg : OUT STD_LOGIC_VECTOR(13 downto 0)  
    );
END BCD_to_7Segment;

ARCHITECTURE Structural OF BCD_to_7Segment IS
    SIGNAL A, B, C, D : STD_LOGIC;
BEGIN
    A <= A_in(3);
    B <= A_in(2);
    C <= A_in(1);
    D <= A_in(0);

	 -- a
    seg(0) <= (NOT B AND NOT C AND NOT D) OR 
	 (NOT A AND C) OR 
	 (A AND NOT C) OR 
	 (B AND D);
	 
	 --b
    seg(1) <= (NOT A AND NOT B) OR 
	 (NOT C AND NOT D) OR 
	 (NOT B AND D) OR 
	 (A AND NOT C) OR 
	 (NOT A AND C AND D) OR 
	 (A AND B AND NOT D);
	 
	 --c
    seg(2) <= D OR (B AND C) OR (NOT A AND NOT C) OR (NOT B AND NOT C);
	 
	 --d
    seg(3) <= (A AND NOT C) OR 
	 (NOT A AND C AND NOT D) OR 
	 (B AND NOT C AND D) OR 
	 (NOT A AND NOT B AND NOT D) OR 
	 (A AND B AND D) OR 
	 (NOT A AND NOT B AND C);
	 
	 --e
    seg(4) <= (A AND NOT C AND NOT D) OR 
	 (NOT A AND C AND NOT D) OR 
	 (NOT A AND NOT B AND NOT D);
	 
	 --f
    seg(5) <= (NOT A AND B AND NOT C) OR 
	 (NOT B AND NOT C AND NOT D) OR 
	 (A AND NOT B AND NOT C) OR 
	 (A AND B AND C) OR 
	 (NOT A AND B AND NOT D);
	 
	 --g
    seg(6) <= (A AND B) OR 
	 (B AND NOT C) OR 
	 (A AND NOT C) OR
	 (NOT A AND C AND NOT D) OR 
	 (NOT A AND NOT B AND C); 
	 
	 seg(7) <= '0';
	 
	 seg(8) <= (A AND B) OR (A AND C);
	 
	 seg(9) <= (A AND B) OR (A AND C);
	 
	 seg(10) <= '0';
	 seg(11) <= '0';
	 seg(12) <= '0';
	 seg(13) <= '0';

END Structural;