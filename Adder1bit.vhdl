library ieee;
use ieee.std_logic_1164.all;


entity Adder1bit is
	port (
		A,B: in std_logic;
		Cin: in std_logic;
		S: out std_logic;
		Cout: out std_logic
	);
end Adder1bit;

architecture adder_arc of Adder1bit is
	
begin

	S <= A xor B xor Cin;
	Cout <= (A and B) or (A and Cin) or (B and Cin);
	
end adder_arc;