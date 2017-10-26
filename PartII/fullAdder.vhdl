library ieee;
use ieee.std_logic_1164.all;

ENTITY fullAdder IS
	PORT(
		A,B,Cin :IN std_logic;
		S,Cout :OUT std_logic
	);
END fullAdder;

ARCHITECTURE behavior of fullAdder IS
	SIGNAL s0,s1,s2 :std_logic;
BEGIN
	s0 <= A XOR B;
	s1 <= s0 AND Cin;
	s2 <= A AND B;
	S	<= s0 XOR Cin;
	Cout <= s1 OR s2;
END behavior;