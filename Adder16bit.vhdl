library ieee;
use ieee.std_logic_1164.all;


entity Adder16bit is
	port (
		A,B: in std_logic_vector(15 downto 0);
		Cin: in std_logic;
		F: out std_logic_vector(15 downto 0);
		c14, c15: out std_logic
	);
end Adder16bit;

architecture adder_arc of Adder16bit is

	Signal c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c16: std_logic;
	
	component Adder1bit
		port (
		A,B, Cin: in std_logic;
		S,Cout: out std_logic
		);
	end component;

begin

	add1: Adder1bit port map(A(0),B(0),Cin,F(0),c0);
	add2: Adder1bit port map(A(1),B(1),c0,F(1),c1);
	add3: Adder1bit port map(A(2),B(2),c1,F(2),c2);
	add4: Adder1bit port map(A(3),B(3),c2,F(3),c3);
	add5: Adder1bit port map(A(4),B(4),c3,F(4),c4);
	add6: Adder1bit port map(A(5),B(5),c4,F(5),c5);
	add7: Adder1bit port map(A(6),B(6),c5,F(6),c6);
	add8: Adder1bit port map(A(7),B(7),c6,F(7),c7);
	add9: Adder1bit port map(A(8),B(8),c7,F(8),c8);
	add10: Adder1bit port map(A(9),B(9),c8,F(9),c9);
	add11: Adder1bit port map(A(10),B(10),c9,F(10),c10);
	add12: Adder1bit port map(A(11),B(11),c10,F(11),c11);
	add13: Adder1bit port map(A(12),B(12),c11,F(12),c12);
	add14: Adder1bit port map(A(13),B(13),c12,F(13),c13);
	add15: Adder1bit port map(A(14),B(14),c13,F(14),c16);
	add16: Adder1bit port map(A(15),B(15),c16,F(15),c15);
	c14 <= c16;
	
	
end adder_arc;