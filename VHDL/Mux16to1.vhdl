library ieee;
use ieee.std_logic_1164.all;

ENTITY Mux16to1 IS
	PORT(
		a,b,c,d,e,f,g,h,
		i,j,k,l,m,n,o,p :IN std_logic_vector(15 downto 0);
		
		sel 			:IN std_logic_vector(3 downto 0);
		f 				:OUT std_logic_vector(15 downto 0)
	);
END Mux16to1;

ARCHITECTURE behavior OF Mux16to1 IS

Begin

	WITH sel SELECT
	f <= a WHEN "0000",
		 b WHEN "0001",
		 c WHEN "0010",
		 d WHEN "0011",
		 e WHEN "0100",
		 f WHEN "0101",
		 g WHEN "0110",
		 h WHEN "0111",
		 i WHEN "1000",
		 j WHEN "1001",
		 k WHEN "1010",
		 l WHEN "1011",
		 m WHEN "1100",
		 n WHEN "1101",
		 o WHEN "1110",
		 p WHEN "1111";

END behavior;