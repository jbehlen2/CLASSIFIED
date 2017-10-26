library ieee;
use ieee.std_logic_1164.all;

ENTITY ripCarryAdder IS
	PORT(
		A,B :IN std_logic_vector(15 downto 0);
		Cin :IN std_logic;
		F: OUT std_logic_vector(15 downto 0);
		C14,C15 :OUT std_logic
	);
END ripCarryAdder;

ARCHITECTURE behavior of ripCarryAdder IS
	COMPONENT fullAdder
		PORT(
			A,B,Cin :IN std_logic;
			S,Cout :OUT std_logic
		);
	END COMPONENT;
	SIGNAL Cout :std_logic_vector(15 downto 0);
BEGIN
	and0: fullAdder PORT MAP(A(0),B(0),Cin,F(0),Cout(0));
	and1: fullAdder PORT MAP(A(1),B(1),Cout(0),F(1),Cout(1));
	and2: fullAdder PORT MAP(A(2),B(2),Cout(1),F(2),Cout(2));
	and3: fullAdder PORT MAP(A(3),B(3),Cout(2),F(3),Cout(3));
	and4: fullAdder PORT MAP(A(4),B(4),Cout(3),F(4),Cout(4));
	and5: fullAdder PORT MAP(A(5),B(5),Cout(4),F(5),Cout(5));
	and6: fullAdder PORT MAP(A(6),B(6),Cout(5),F(6),Cout(6));
	and7: fullAdder PORT MAP(A(7),B(7),Cout(6),F(7),Cout(7));
	and8: fullAdder PORT MAP(A(8),B(8),Cout(7),F(8),Cout(8));
	and9: fullAdder PORT MAP(A(9),B(9),Cout(8),F(9),Cout(9));
	and10: fullAdder PORT MAP(A(10),B(10),Cout(9),F(10),Cout(10));
	and11: fullAdder PORT MAP(A(11),B(11),Cout(10),F(11),Cout(11));
	and12: fullAdder PORT MAP(A(12),B(12),Cout(11),F(12),Cout(12));
	and13: fullAdder PORT MAP(A(13),B(13),Cout(12),F(13),Cout(13));
	and14: fullAdder PORT MAP(A(14),B(14),Cout(13),F(14),Cout(14));
	and15: fullAdder PORT MAP(A(15),B(15),Cout(14),F(15),Cout(15));
	
	C14 <= Cout(14);
	C15 <= Cout(15);
END behavior;