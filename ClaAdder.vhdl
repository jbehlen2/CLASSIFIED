LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ClaAdder IS
	PORT(
		x,y					:IN std_logic_vector(15 downto 0);
		c_In					:IN std_logic;
		c_Gen1, c_Prop1	:OUT std_logic;
		sum					:OUT std_logic_vector(15 downto 0)
	);
END ClaAdder;

ARCHITECTURE behavior of ClaAdder IS

	SIGNAL firstFourX,firstFourY :std_logic_vector(3 downto 0);
	SIGNAL secondFourX,secondFourY :std_logic_vector(3 downto 0);
	SIGNAL thirdFourX,thirdFourY :std_logic_vector(3 downto 0);
	SIGNAL lastFourX,lastFourY :std_logic_vector(3 downto 0);
	SIGNAL tempGen1 :std_logic_vector(3 downto 0);
	SIGNAL tempProp1 :std_logic_vector(3 downto 0);
	SIGNAL tempCIn1 :std_logic_vector(4 downto 1);

	COMPONENT fullAdder4Bit
		PORT(
			A,B					:IN std_logic_vector(3 downto 0);
			Cin 					:IN std_logic;
			c_gen,c_prop		:OUT std_logic;
			finS					:OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
BEGIN
	
	firstFourX <= x(3 downto 0);
	firstFourY <= y(3 downto 0);
	secondFourX <= x(7 downto 4);
	secondFourY <= y(7 downto 4);
	thirdFourX <= x(11 downto 8);
	thirdFourY <= y(11 downto 8);
	lastFourX <= x(15 downto 12);
	lastFourY <= y(15 downto 12);
	
	first: fullAdder4Bit PORT MAP(firstFourX,firstFourY,c_In,tempGen1(0),tempProp1(0),sum(3 downto 0));
	second: fullAdder4Bit PORT MAP(secondFourX,secondFourY,tempCIn1(1),tempGen1(1),tempProp1(1),sum(7 downto 4));
	third: fullAdder4Bit PORT MAP(thirdFourX,thirdFourY,tempCIn1(2),tempGen1(2),tempProp1(2),sum(11 downto 8));
	fourth: fullAdder4Bit PORT MAP(lastFourX,lastFourY,tempCIn1(3),tempGen1(3),tempProp1(3),sum(15 downto 12));
	
	tempCIn1(1) <= tempGen1(0) OR (tempProp1(0) AND c_In);
	tempCIn1(2) <= tempGen1(1) OR (tempProp1(1) AND tempGen1(0)) OR (tempProp1(1) AND tempProp1(0) AND c_In);
	tempCIn1(3) <= tempGen1(2) OR (tempProp1(2) AND tempGen1(1)) OR (tempProp1(2) AND tempProp1(1) AND tempGen1(0))
	OR (tempProp1(2) AND tempProp1(1) AND tempProp1(0) AND c_In);
	tempCIn1(4) <= tempGen1(3) OR (tempProp1(3) AND tempGen1(2)) OR (tempProp1(3) AND tempProp1(2) AND tempGen1(1))
	OR (tempProp1(3) AND tempProp1(2) AND tempProp1(1) AND tempGen1(0)) OR (tempProp1(3) AND tempProp1(2) AND tempProp1(1)
	AND tempProp1(0) AND c_In);
	
	c_gen1 <= tempGen1(3) OR (tempProp1(3) AND tempGen1(2)) OR (tempProp1(3) AND tempProp1(2) AND tempGen1(1))
	OR (tempProp1(3) AND tempProp1(2) AND tempProp1(1) AND tempGen1(0));
	c_prop1 <= tempProp1(0) AND tempProp1(1) AND tempProp1(2) AND tempProp1(3);
	
END behavior;