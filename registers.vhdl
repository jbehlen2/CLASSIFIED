library ieee;
use ieee.std_logic_1164.all;

entity registers is
	port (
		regS,regT,regD: in std_logic_vector(3 downto 0);
		dataD: in std_logic_vector(15 downto 0);
		reset,enable,clock: in std_logic;
		dataS,dataT: out std_logic_vector(15 downto 0)
	);
end registers;

architecture behavior of registers is

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

	

end behavior;