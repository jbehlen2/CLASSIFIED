library ieee;
use ieee.std_logic_1164.all;

ENTITY immediate IS
	PORT(
		immed :IN std_logic_vector(6 downto 0);
		extend :IN std_logic_vector(1 downto 0);
		immedEx :OUT std_logic_vector(15 downto 0)
	);
END immediate;

ARCHITECTURE behavior OF immediate IS
BEGIN
	PROCESS(immed,extend)
	BEGIN
		IF(extend = "00")THEN
			immedEx <= "000000000" & immed;
		ELSE
			IF(immed(6) = '0')THEN
				immedEx <= "000000000" & immed;
			ELSE
				immedEx <= "111111111" & immed;
			END IF;
		END IF;
	END PROCESS;
END behavior;