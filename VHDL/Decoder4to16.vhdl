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
	out(0) <= (NOT in1(3)) AND (NOT in1(2)) AND (NOT in1(1)) AND (NOT in1(0));
	out(1) <= (NOT in1(3)) AND (NOT in1(2)) AND (NOT in1(1)) AND in1(0);
	out(2) <= (NOT in1(3)) AND (NOT in1(2)) AND in1(1) AND (NOT in1(0));
	out(3) <= (NOT in1(3)) AND (NOT in1(2)) AND in1(1) AND in1(0);
	out(4) <= (NOT in1(3)) AND in1(2) AND (NOT in1(1)) AND (NOT in1(0));
	out(5) <= (NOT in1(3)) AND in1(2) AND (NOT in1(1)) AND in1(0);
	out(6) <= (NOT in1(3)) AND in1(2) AND in1(1) AND (NOT in1(0));
	out(7) <= (NOT in1(3)) AND in1(2) AND in1(1) AND in1(0);
	out(8) <= in1(3) AND (NOT in1(2)) AND (NOT in1(1)) AND (NOT in1(0));
	out(9) <= in1(3) AND (NOT in1(2)) AND (NOT in1(1)) AND in1(0);
	out(10) <= in1(3) AND (NOT in1(2)) AND in1(1) AND (NOT in1(0));
	out(11) <= in1(3) AND (NOT in1(2)) AND in1(1) AND in1(0);
	out(12) <= in1(3) AND in1(2) AND (NOT in1(1)) AND (NOT in1(0));
	out(13) <= in1(3) AND in1(2) AND (NOT in1(1)) AND in1(0);
	out(14) <= in1(3) AND in1(2) AND in1(1) AND (NOT in1(0));
	out(15) <= in1(3) AND in1(2) AND in1(1) AND in1(0);
END behavior;