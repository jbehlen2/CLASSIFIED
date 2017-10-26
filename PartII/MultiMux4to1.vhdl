library ieee;
use ieee.std_logic_1164.all;

ENTITY MultiMux4to1 IS										--Input/Output defined
	PORT( 
		inp0,inp1,inp2,inp3 :IN std_logic_vector(15 downto 0);
		s :in std_logic_vector(1 downto 0);
		outP :OUT std_logic_vector(15 downto 0)
	);
END MultiMux4to1;

ARCHITECTURE behavior OF MultiMux4to1 IS						--Behavior of MultiMux4to1
	SIGNAL zero :std_logic_vector(15 downto 0);
BEGIN													--Signals given value and														
	zero <= "0000000000000000";												--final output is decided
	with s select 
		outP <= inp0 when "00",
					 inp1 when "01",
					 inp2 when "10",
					 zero when others;

END behavior;