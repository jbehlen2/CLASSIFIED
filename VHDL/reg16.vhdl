library ieee;
use ieee.std_logic_1164.all;

ENTITY Reg16 IS
	PORT(
		data					:IN std_logic_vector(15 downto 0);
		enable, reset, clock	:IN std_logic;
		output					:OUT std_logic_vector(15 downto 0)
	);
END Reg16;

ARCHITECTURE behavior OF Reg16 IS

BEGIN
	PROCESS(clock, reset)
	BEGIN
		IF(reset = '1') THEN	
			output <= (OTHERS =>'0');
		ELSIF(rising_edge(clock)) THEN
			IF(enable = '1') THEN
				output <= data;
			END IF;
		END IF;
	END PROCESS;
END behavior;
