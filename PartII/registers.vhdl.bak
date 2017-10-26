library ieee;
use ieee.std_logic_1164.all;

ENTITY registers is
	PORT(
		regS,regT,regD 	   :IN std_logic_vector(3 downto 0);
		dataD 			   :IN std_logic_vector(15 downto 0);
		reset,enable,clock :IN std_logic;
		dataS,dataT 	   :OUT std_logic_vector(15 downto 0)
	);
END registers;

ARCHITECTURE behavior OF registers IS
	COMPONENT Mux16to1
		PORT(
			a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p :IN std_logic_vector(15 downto 0);
			sel  							:IN std_logic_vector(3 downto 0);
			out1  							:OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT Decoder4to16
		PORT(
			in1  :IN std_logic_vector(3 downto 0);
			out1 :OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT reg16
		PORT(
			data 			   :IN std_logic_vector(15 downto 0);
			enable,reset,clock :IN std_logic;
			output 			   :OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
		SIGNAL decout,en 						:std_logic_vector(15 downto 0);
		SIGNAL Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,
		       Q10,Q11,Q12,Q13,Q14,Q15 			:std_logic_vector(15 downto 0);
			   
BEGIN
	dec1 :Decoder4to16 PORT MAP(regD,decout);
	en(1) <= decout(1) AND enable;
	en(2) <= decout(2) AND enable;
	en(3) <= decout(3) AND enable;
	en(4) <= decout(4) AND enable;
	en(5) <= decout(5) AND enable;
	en(6) <= decout(6) AND enable;
	en(7) <= decout(7) AND enable;
	en(8) <= decout(8) AND enable;
	en(9) <= decout(9) AND enable;
	en(10) <= decout(10) AND enable;
	en(11) <= decout(11) AND enable;
	en(12) <= decout(12) AND enable;
	en(13) <= decout(13) AND enable;
	en(14) <= decout(14) AND enable;
	en(15) <= decout(15) AND enable;
	
	Q0 <= (OTHERS => '0');
	reg1 :reg16 PORT MAP(dataD,en(1),reset,clock,Q1);
	reg2 :reg16 PORT MAP(dataD,en(2),reset,clock,Q2);
	reg3 :reg16 PORT MAP(dataD,en(3),reset,clock,Q3);
	reg4 :reg16 PORT MAP(dataD,en(4),reset,clock,Q4);
	reg5 :reg16 PORT MAP(dataD,en(5),reset,clock,Q5);
	reg6 :reg16 PORT MAP(dataD,en(6),reset,clock,Q6);
	reg7 :reg16 PORT MAP(dataD,en(7),reset,clock,Q7);
	reg8 :reg16 PORT MAP(dataD,en(8),reset,clock,Q8);
	reg9 :reg16 PORT MAP(dataD,en(9),reset,clock,Q9);
	reg10 :reg16 PORT MAP(dataD,en(10),reset,clock,Q10);
	reg11 :reg16 PORT MAP(dataD,en(11),reset,clock,Q11);
	reg12 :reg16 PORT MAP(dataD,en(12),reset,clock,Q12);
	reg13 :reg16 PORT MAP(dataD,en(13),reset,clock,Q13);
	reg14 :reg16 PORT MAP(dataD,en(14),reset,clock,Q14);
	reg15 :reg16 PORT MAP(dataD,en(15),reset,clock,Q15);
	
	muxS :mux16to1 PORT MAP(Q0,Q1,Q2,Q3,Q4,Q5,Q6,
				   Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,
				   Q15,regS,dataS);
				   
	muxT :mux16to1 PORT MAP(Q0,Q1,Q2,Q3,Q4,Q5,Q6,
				   Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,
				   Q15,regT,dataT);
END behavior;