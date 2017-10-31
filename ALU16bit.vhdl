library ieee;
use ieee.std_logic_1164.all;


entity ALU16bit is
	port (
		A,B: in std_logic_vector(15 downto 0);
		ALU_op: in std_logic_vector(1 downto 0);
		A_inv,B_inv: in std_logic;
		ALU_out: out std_logic_vector(15 downto 0);
		N,C,Z,V: out std_logic
	);
end ALU16bit;

architecture ALU_arc of ALU16bit is

	Signal result,or1,xor1,and1,A1,B1,out1: std_logic_vector(15 downto 0);
	Signal Cin,c14,c15: std_logic;

	component Adder16bit
		port (
			A,B: in std_logic_vector(15 downto 0);
			Cin: in std_logic;
			F: out std_logic_vector(15 downto 0);
			c14, c15: out std_logic
		);
	end component;
	
	component Inverter16bit
		port (
			A: in std_logic_vector(15 downto 0);
			A_inv: in std_logic;
			F: out std_logic_vector(15 downto 0)
		);
	end component;

begin
	
	Cin <= A_inv or B_inv;
	inv1: Inverter16bit port map(A,A_inv,A1);
	inv2: Inverter16bit port map(B,B_inv,B1);
	or1 <= A1 or B1;
	xor1 <= A1 xor B1;
	and1 <= A1 and B1;
	add1: Adder16bit port map(A1,B1,Cin,result,c14,c15);
	
	with ALU_op select
	out1 <= and1 when "00",
			   or1 when "01",
			   xor1 when "10",
			   result when "11";
			
	ALU_out <= out1;		
	N <= out1(15);
	C <= c15;
	Z <= (not out1(0)) and (not out1(1)) and (not out1(2))
			and (not out1(3)) and (not out1(4)) and (not out1(5))
			and (not out1(6)) and (not out1(7)) and (not out1(8))
			and (not out1(9)) and (not out1(10)) and (not out1(11))
			and (not out1(12)) and (not out1(13)) and (not out1(14))
			and (not out1(15));
	V <= c14 xor c15;
	
	
end ALU_arc;