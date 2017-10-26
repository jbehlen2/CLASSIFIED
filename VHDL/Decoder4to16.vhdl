library ieee;
use ieee.std_logic_1164.all;


entity Decoder4to16 is
	port (
		in1: in std_logic_vector(3 downto 0);
		out1: out std_logic_vector(15 downto 0)
	);
end Decoder4to16;

architecture decoder_arc of Decoder4to16 is
begin

	out(0) <= (not in1(3)) and (not in1(2)) and (not in1(1)) and (not in1(0));
	out(1) <= (not in1(3)) and (not in1(2)) and (not in1(1)) and in1(0);
	out(2) <= (not in1(3)) and (not in1(2)) and in1(1) and (not in1(0));
	out(3) <= (not in1(3)) and (not in1(2)) and in1(1) and in1(0);
	out(4) <= (not in1(3)) and in1(2) and (not in1(1)) and (not in1(0));
	out(5) <= (not in1(3)) and in1(2) and (not in1(1)) and in1(0);
	out(6) <= (not in1(3)) and in1(2) and in1(1) and (not in1(0));
	out(7) <= (not in1(3)) and in1(2) and in1(1) and in1(0);
	out(8) <= in1(3) and (not in1(2)) and (not in1(1)) and (not in1(0));
	out(9) <= in1(3) and (not in1(2)) and (not in1(1)) and in1(0);
	out(10) <= in1(3) and (not in1(2)) and in1(1) and (not in1(0));
	out(11) <= in1(3) and (not in1(2)) and in1(1) and in1(0);
	out(12) <= in1(3) and in1(2) and (not in1(1)) and (not in1(0));
	out(13) <= in1(3) and in1(2) and (not in1(1)) and in1(0);
	out(14) <= in1(3) and in1(2) and in1(1) and (not in1(0));
	out(15) <= in1(3) and in1(2) and in1(1) and in1(0);

end decoder_arc;
