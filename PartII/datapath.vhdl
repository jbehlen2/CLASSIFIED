library ieee;
use ieee.std_logic_1164.all;

ENTITY datapath IS
	PORT(
		IR 			   :IN std_logic_vector(23 downto 0);
		clock,reset    :IN std_logic;
		DataD				:OUT std_logic_vector(15 downto 0)
	);
END datapath;

ARCHITECTURE behavior OF datapath IS
	COMPONENT alu16bit
		PORT(
			A,B 			:IN std_logic_vector(15 downto 0);
			alu_op 	:IN std_logic_vector(1 downto 0);
			A_inv,B_inv :IN std_logic;
			ALU_out 		:OUT std_logic_vector(15 downto 0);
			N,C,V,Z 		:OUT std_logic
		);
	END COMPONENT;
	COMPONENT controlUnit
		PORT(
			opCode,Cond 	 	   	:In std_logic_vector(3 downto 0);
			opx 				 	   	:In std_logic_vector(2 downto 0);
			S,N,C,V,Z,mfc,
			clock,reset 	 	   	:In std_logic;
			
			alu_op,c_select,
			y_select,extend      :Out std_logic_vector(1 downto 0);
			
			rf_write,b_select,
			a_inv,b_inv,ir_enable,
			ma_select,mem_read,
			mem_write,pc_select,
			pc_enable,Inc_select :Out std_logic
		);
	END COMPONENT;
	COMPONENT registers
		PORT(
			regS,regT,regD 	   	 :IN std_logic_vector(3 downto 0);
			dataD 			      	 :IN std_logic_vector(15 downto 0);
			reset,enable,clock   :IN std_logic;
			dataS,dataT 	      	 :OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT reg16
		PORT(
			data					   		:IN std_logic_vector(15 downto 0);
			enable,reset,clock	:IN std_logic;
			output							:OUT std_logic_vector(15 downto 0)
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
	COMPONENT immediate
		PORT(
			immed 	 :IN std_logic_vector(6 downto 0);
			extend :IN std_logic_vector(1 downto 0);
			immedEx 	 :OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
		
		SIGNAL outputA 	   :std_logic_vector(15 downto 0);
		SIGNAL outputB 		:std_logic_vector(15 downto 0);
		SIGNAL ALUInA			:std_logic_vector(15 downto 0);
		SIGNAL ALUInB			:std_logic_vector(15 downto 0);
		SIGNAL MuxBIn			:std_logic_vector(15 downto 0);
		SIGNAL outputMuxB 	:std_logic_vector(15 downto 0);
		SIGNAL ALUOut  		:std_logic_vector(15 downto 0);
		SIGNAL MuxYIn  		:std_logic_vector(15 downto 0);
		SIGNAL outputMemM 	:std_logic_vector(15 downto 0);
		SIGNAL outputDataD   :std_logic_vector(15 downto 0);
		SIGNAL nSig 		 	:std_logic;
		SIGNAL cSig 		 	:std_logic;
		SIGNAL vSig 			:std_logic;
		SIGNAL zSig 			:std_logic;
		SIGNAL rD				:std_logic_vector(3 downto 0);
		SIGNAL rS				:std_logic_vector(3 downto 0);
		SIGNAL rT				:std_logic_vector(3 downto 0);
		SIGNAL tempImmed		:std_logic_vector(6 downto 0);
		SIGNAL immed			:std_logic_vector(15 downto 0);
		SIGNAL RYIn				:std_logic_vector(15 downto 0);
		SIGNAL tempMemData	:std_logic_vector(15 downto 0);
		SIGNAL tempRetAdd		:std_logic_vector(15 downto 0);
		SIGNAL sSig				:std_logic;
		SIGNAL rf_writeSig	:std_logic;
		SIGNAL a_invSig		:std_logic;
		SIGNAL b_invSig		:std_logic;
		SIGNAL b_selSig		:std_logic;
		SIGNAL extendSig		:std_logic_vector(1 downto 0);
		SIGNAL alu_opSig		:std_logic_vector(1 downto 0);
		
		SIGNAL CondSig				:std_logic_vector(3 downto 0);
		SIGNAL opxSig				:std_logic_vector(2 downto 0);
		SIGNAL mfcSig				:std_logic;
		SIGNAL c_selSig			:std_logic_vector(1 downto 0);
		SIGNAL y_selSig			:std_logic_vector(1 downto 0);
		SIGNAL ir_enableSig		:std_logic;
		SIGNAL ma_selSig			:std_logic;
		SIGNAL mem_readSig		:std_logic;
		SIGNAL mem_writeSig		:std_logic;
		SIGNAL pc_selSig			:std_logic;
		SIGNAL pc_enableSig		:std_logic;
		SIGNAL inc_selSig			:std_logic;
		SIGNAL opCodeSig			:std_logic_vector(3 downto 0);
	
BEGIN
	sSig <= IR(15);
	opCodeSig <= IR(23 downto 20);
	fromControl :controlUnit PORT MAP(opCodeSig,CondSig,opxSig,sSig,nSig,cSig,vSig,
					         zSig,mfcSig,clock,reset,alu_opSig,
							 c_selSig,y_selSig,extendSig,rf_writeSig,b_selSig,
							 a_invSig,b_invSig,ir_enableSig,ma_selSig,mem_readSig,
							 mem_writeSig,pc_selSig,pc_enableSig,inc_selSig);
	
	tempImmed <= IR(14 downto 8);
	imm :immediate PORT MAP(tempImmed,extendSig,immed);
	rD <= IR(11 downto 8);
	rS <= IR(7 downto 4);
	rT <= IR(3 downto 0);
	regs :registers PORT MAP(rS,rT,rD,outputDataD,reset,rf_writeSig,clock,outputA,outputB);			 
	regA :reg16 PORT MAP(outputA,rf_writeSig,reset,clock,ALUInA);
	regB :reg16 PORT MAP(outputB,rf_writeSig,reset,clock,MuxBIn);
	Mux2 :Mux2to1 PORT MAP(MuxBIn,immed,b_selSig,outputMuxB);
	Alu :alu16bit PORT MAP(ALUInA,outputMuxB,alu_opSig,a_invSig,b_invSig,ALUOut,
				   nSig,cSig,vSig,zSig);
						
	regZ :reg16 PORT MAP(ALUOut,rf_writeSig,reset,clock,MuxYIn);
	regM :reg16 PORT MAP(MuxBIn,rf_writeSig,reset,clock,outputMemM);
	tempMemData <= "0000000000000000";
	tempRetAdd <= "0000000000000000";
	Mux3 :Mux3to1 PORT MAP(MuxYIn,tempMemData,tempRetAdd,y_selSig,RYIn);
	regY :reg16 PORT MAP(RYIn,rf_writeSig,reset,clock,outputDataD);
	DataD <= outputDataD;
END behavior;