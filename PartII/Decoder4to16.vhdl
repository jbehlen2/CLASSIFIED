library ieee;
use ieee.std_logic_1164.all;

ENTITY Decoder4to16 IS
	PORT(
		in1  :IN std_logic_vector(3 downto 0);
		out1 :OUT std_logic_vector(15 downto 0)
	);
END Decoder4to16;

ARCHITECTURE behavior OF Decoder4to16 IS

BEGIN
	out1(0) <= (NOT in1(3)) AND (NOT in1(2)) AND (NOT in1(1)) AND (NOT in1(0));
	out1(1) <= (NOT in1(3)) AND (NOT in1(2)) AND (NOT in1(1)) AND in1(0);
	out1(2) <= (NOT in1(3)) AND (NOT in1(2)) AND in1(1) AND (NOT in1(0));
	out1(3) <= (NOT in1(3)) AND (NOT in1(2)) AND in1(1) AND in1(0);
	out1(4) <= (NOT in1(3)) AND in1(2) AND (NOT in1(1)) AND (NOT in1(0));
	out1(5) <= (NOT in1(3)) AND in1(2) AND (NOT in1(1)) AND in1(0);
	out1(6) <= (NOT in1(3)) AND in1(2) AND in1(1) AND (NOT in1(0));
	out1(7) <= (NOT in1(3)) AND in1(2) AND in1(1) AND in1(0);
	out1(8) <= in1(3) AND (NOT in1(2)) AND (NOT in1(1)) AND (NOT in1(0));
	out1(9) <= in1(3) AND (NOT in1(2)) AND (NOT in1(1)) AND in1(0);
	out1(10) <= in1(3) AND (NOT in1(2)) AND in1(1) AND (NOT in1(0));
	out1(11) <= in1(3) AND (NOT in1(2)) AND in1(1) AND in1(0);
	out1(12) <= in1(3) AND in1(2) AND (NOT in1(1)) AND (NOT in1(0));
	out1(13) <= in1(3) AND in1(2) AND (NOT in1(1)) AND in1(0);
	out1(14) <= in1(3) AND in1(2) AND in1(1) AND (NOT in1(0));
	out1(15) <= in1(3) AND in1(2) AND in1(1) AND in1(0);
END behavior;