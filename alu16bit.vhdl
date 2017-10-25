library ieee;
use ieee.std_logic_1164.all;

ENTITY alu16bit IS
	PORT(
		A,B :IN std_logic_vector(15 downto 0);
		alu_op :IN std_logic_vector(1 downto 0);
		A_inv,B_inv :IN std_logic;
		ALU_out :OUT std_logic_vector(15 downto 0);
		N,C,Z,V :OUT std_logic
	);
END alu16bit;

ARCHITECTURE behavior of alu16bit IS
	COMPONENT ripCarryAdder
		PORT(
			A,B :IN std_logic_vector(15 downto 0);
			Cin :IN std_logic;
			F: OUT std_logic_vector(15 downto 0);
			C14,C15 :OUT std_logic
		);
	END COMPONENT;
	COMPONENT flags
		PORT(
			S :IN std_logic_vector(15 downto 0);
			C14,C15 :IN std_logic;
			n,c,z,v :OUT std_logic
		);
	END COMPONENT;
	COMPONENT MultiMux4to1
		PORT(
			inp0,inp1,inp2,inp3 :IN std_logic_vector(15 downto 0);
			s :in std_logic_vector(1 downto 0);
			outP :OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT MultiMux2to1
		PORT(
			in0,in1 :IN std_logic_vector(15 downto 0);
			sel :in std_logic;
			output :OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	SIGNAL invOr :std_logic;
	SIGNAL andd :std_logic_vector(15 downto 0);
	SIGNAL orr :std_logic_vector(15 downto 0);
	SIGNAL xorr :std_logic_vector(15 downto 0);
	SIGNAL multiOutA :std_logic_vector(15 downto 0);
	SIGNAL multiOutB :std_logic_vector(15 downto 0);
	SIGNAL multiS :std_logic_vector(15 downto 0);
	SIGNAL cOut14 :std_logic;
	SIGNAL cOut15 :std_logic;
	SIGNAL notA :std_logic_vector(15 downto 0);
	SIGNAL notB :std_logic_vector(15 downto 0);
BEGIN
	notA <= NOT A;
	notB <= NOT B;
	muxA: MultiMux2to1 PORT MAP(A,notA,A_inv,multiOutA);
	muxB: MultiMux2to1 PORT MAP(B,notB,B_inv,multiOutB);
	invOr <= A_inv OR B_inv;
	andd <= multiOutA AND multiOutB;
	orr <= multiOutA OR multiOutB;
	xorr <= multiOutA XOR multiOutB;
	FA: ripCarryAdder PORT MAP(multiOutA,multiOutB,invOr,multiS,cOut14,cOut15);
	flagLogic: flags PORT MAP(multiS,cOut14,cOut15,N,C,Z,V);
	aluOut: MultiMux4to1 PORT MAP(andd,orr,xorr,multiS,alu_op,ALU_out);
END behavior;