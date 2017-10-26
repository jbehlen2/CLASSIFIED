library ieee;
use ieee.std_logic_1164.all;

ENTITY datapath IS
	PORT(
		IR 			   :IN std_logic_vector(23 downto 0);
		DataD 		   :IN std_logic_vector(15 downto 0);
		clock,reset,PS :IN std_logic;
	);
END datapath;

ARCHITECTURE behavior OF datapath IS
	COMPONENT alu16bit
		PORT(
			A,B 		:IN std_logic_vector(15 downto 0);
			alu_op 		:IN std_logic_vector(1 downto 0);
			A_inv,B_inv :IN std_logic;
			ALU_out 	:OUT std_logic_vector(15 downto 0);
			N,C,V,Z 	:OUT std_logic
		);
	END COMPONENT;
	COMPONENT controlUnit
		PORT(
			opCode,Cond 	 	 :In std_logic_vector(3 downto 0);
			opx 				 :In std_logic_vector(2 downto 0);
			S,N,C,V,Z,mfc,
			clock,reset 	 	 :In std_logic;
			alu_op,c_select,
			y_select,extend      :Out std_logic_vector(1 downto 0);
			rf_write,b_select,
			a_inv,b_inv,ir_enable,
			ma_select,mem_read,
			mem_write,pc_select,
			pc_enable,inc_select :Out std_logic
		);
	END COMPONENT;
	COMPONENT registers
		PORT(
			regS,regT,regD 	   :IN std_logic_vector(3 downto 0);
			dataD 			   :IN std_logic_vector(15 downto 0);
			reset,enable,clock :IN std_logic;
			dataS,dataT 	   :OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT reg16
		PORT(
			data					:IN std_logic_vector(15 downto 0);
			enable, reset, clock	:IN std_logic;
			output					:OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT Mux2to1
		PORT(
			data0x	:IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			data1x	:IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			sel		:IN STD_LOGIC ;
			result	:OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT Mux3to1
		PORT(
			data0x	:IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			data1x	:IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			data2x	:IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			sel		:IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			result	:OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT;
		SIGNAL outputA 		 :std_logic_vector(15 downto 0);
		SIGNAL outputB 		 :std_logic_vector(15 downto 0);
		SIGNAL outputMux2to1 :std_logic_vector(15 downto 0);
		SIGNAL outputAluOut  :std_logic_vector(15 downto 0);
		SIGNAL outputMuxYIn  :std_logic_vector(15 downto 0);
		SIGNAL outputMemB 	 :std_logic_vector(15 downto 0);
		SIGNAL outputDataD   :std_logic_vector(15 downto 0);
		SIGNAL nSig 		 :std_logic;
		SIGNAL cSig 		 :std_logic;
		SIGNAL vSig 		 :std_logic;
		SIGNAL zSig 		 :std_logic;
	
BEGIN
	fromControl: controlUnit PORT MAP(opCode,Cond,opx,S,nSig,cSig,vSig,
					         zSig,mfc,clock,reset,clock,reset,alu_op,
							 c_select,y_select,extend,rf_write,b_select,
							 a_inv,b_inv,ir_enable,ma_select,mem_read,
							 mem_write,pc_select,pc_enable,inc_select);
					 
	regA: reg16 PORT MAP(dataS,enable,reset,clock,outputA);
	regB: reg16 PORT MAP(dataT,enable,reset,clock,outputB);
	Mux2 : Mux2to1 PORT MAP(outputB,,b_select,outputMux2to1);
	Alu : alu16bit PORT MAP(outputA,outputMux2to1,alu_op,a_inv,b_inv,outputAluOut,
				   nSig,cSig,vSig,zSig);
					 
	regZ: reg16 PORT MAP(outputAluOut,enable,reset,clock,outputMuxYIn);
	regM: reg16 PORT MAP(outputB,enable,reset,clock,outputMemB);
	Mux3 : Mux3to1 PORT MAP(outputMuxYIn,,,result);
	regY: reg16 PORT MAP(result,enable,reset,clock,outputDataD);
END behavior;