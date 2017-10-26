library ieee;
use ieee.std_logic_1164.all;

ENTITY MultiMux2to1 IS										--Input/Output defined
	PORT( 
		in0,in1 :IN std_logic_vector(15 downto 0);
		sel :in std_logic;
		output :OUT std_logic_vector(15 downto 0)
	);
END MultiMux2to1;

ARCHITECTURE behavior OF MultiMux2to1 IS						--Behavior of Mux2to1

BEGIN													         --Signals given value and																										--final output is decided
		output <= in0 when (sel = '0') else in1;
		
END behavior;