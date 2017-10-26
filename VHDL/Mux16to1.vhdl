library ieee;
use ieee.std_logic_1164.all;


entity Mux16to1 is
	port (
		a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p : in std_logic_vector(15 downto 0);
		sel : in std_logic_vector(3 downto 0);
		f : out std_logic_vector(15 downto 0)
	);
end Mux16to1;

architecture mux_arc of Mux16to1 is
begin

	with sel select
	f <= a when "0000",
		 b when "0001",
		 c when "0010",
		 d when "0011",
		 e when "0100",
		 f when "0101",
		 g when "0110",
		 h when "0111",
		 i when "1000",
		 j when "1001",
		 k when "1010",
		 l when "1011",
		 m when "1100",
		 n when "1101",
		 o when "1110",
		 p when "1111";

end mux_arc;
