library ieee;
use ieee.std_logic_1164.all;


entity Lab7 is
	port (
		regS,regT,regD: in std_logic_vector(3 downto 0);
		dataD: in std_logic_vector(15 downto 0);
		reset,enable,clock: in std_logic;
		dataS,dataT: out std_logic_vector(15 downto 0)
	);
end Lab7;

architecture lab7_arc of Lab7 is

component Mux16to1
	port (
		a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p : in std_logic_vector(15 downto 0);
		sel : in std_logic_vector(3 downto 0);
		out1 : out std_logic_vector(15 downto 0)
	);
end component;

component Decoder4to16
	port (
		in1: in std_logic_vector(3 downto 0);
		out1: out std_logic_vector(15 downto 0)
	);
end component;

component reg16
	port (
		data: in std_logic_vector(15 downto 0);
		enable, reset, Clock: in std_logic;
		output: out std_logic_vector(15 downto 0)
	);
end component;

signal decout,en: std_logic_vector(15 downto 0);
signal Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15: std_logic_vector(15 downto 0);

begin

	dec1: Decoder4to16 port map (regD,decout);
	en(1) <= decout(1) and enable;
	en(2) <= decout(2) and enable;
	en(3) <= decout(3) and enable;
	en(4) <= decout(4) and enable;
	en(5) <= decout(5) and enable;
	en(6) <= decout(6) and enable;
	en(7) <= decout(7) and enable;
	en(8) <= decout(8) and enable;
	en(9) <= decout(9) and enable;
	en(10) <= decout(10) and enable;
	en(11) <= decout(11) and enable;
	en(12) <= decout(12) and enable;
	en(13) <= decout(13) and enable;
	en(14) <= decout(14) and enable;
	en(15) <= decout(15) and enable;
	
	Q0 <= (others => '0');
	reg1: reg16 port map (dataD,en(1),reset,clock,Q1);
	reg2: reg16 port map (dataD,en(2),reset,clock,Q2);
	reg3: reg16 port map (dataD,en(3),reset,clock,Q3);
	reg4: reg16 port map (dataD,en(4),reset,clock,Q4);
	reg5: reg16 port map (dataD,en(5),reset,clock,Q5);
	reg6: reg16 port map (dataD,en(6),reset,clock,Q6);
	reg7: reg16 port map (dataD,en(7),reset,clock,Q7);
	reg8: reg16 port map (dataD,en(8),reset,clock,Q8);
	reg9: reg16 port map (dataD,en(9),reset,clock,Q9);
	reg10: reg16 port map (dataD,en(10),reset,clock,Q10);
	reg11: reg16 port map (dataD,en(11),reset,clock,Q11);
	reg12: reg16 port map (dataD,en(12),reset,clock,Q12);
	reg13: reg16 port map (dataD,en(13),reset,clock,Q13);
	reg14: reg16 port map (dataD,en(14),reset,clock,Q14);
	reg15: reg16 port map (dataD,en(15),reset,clock,Q15);
	
	muxS: mux16to1 port map (Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,regS,dataS);
	muxT: mux16to1 port map (Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,regT,dataT);

end lab7_arc;