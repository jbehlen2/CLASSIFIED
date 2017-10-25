library ieee;
use ieee.std_logic_1164.all;


entity Lab7 is
	port (
		regS,regT,regD: in std_logic_vector(3 downto 0);
		dataD: in std_logic_vector(15 downto 0);
		reset,enable,clock: in std_logic;
		dataS,dataT: out std_logic_vector(15 downto 0)
	);
end Lab7;

architecture lab7_arc of Lab7 is

component Mux16to1
	port (
		a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p : in std_logic_vector(15 downto 0);
		sel : in std_logic_vector(3 downto 0);
		f : out std_logic_vector(15 downto 0)
	);
end component;

component Decoder4to16
	port (
		in1: in std_logic_vector(3 downto 0);
		out1: out std_logic_vector(15 downto 0)
	);
end component;

begin

	

end lab7_arc;