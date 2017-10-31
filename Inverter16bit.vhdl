library ieee;
use ieee.std_logic_1164.all;


entity Inverter16bit is
	port (
		A: in std_logic_vector(15 downto 0);
		A_inv: in std_logic;
		F: out std_logic_vector(15 downto 0)
	);
end Inverter16bit;

architecture inverter_arc of Inverter16bit is

begin
	
	with A_inv select
	F <= not A when '1',
		 A when '0';
	
end inverter_arc;