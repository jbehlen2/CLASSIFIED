library ieee;
use ieee.std_logic_1164.all;

ENTITY controlUnit IS
	PORT(															--Inputs
		opCode,Cond 	 		:IN std_logic_vector(3 downto 0);
		opx 				 	:IN std_logic_vector(2 downto 0);
		S,N,C,V,Z,mfc,
		clock,reset 	 		:IN std_logic;
		
		alu_op,c_select,
		y_select,extEnd      	:OUT std_logic_vector(1 downto 0);	--Outputs
		
		rf_write,b_select,
		a_Inv,b_Inv,ir_enable,
		ma_select,mem_read,
		mem_write,pc_select,
		pc_enable,Inc_select 	:OUT std_logic
	);
END controlUnit;

ARCHITECTURE behavior OF controlUnit IS
	SIGNAL wmfc 		  :std_logic;								--Define signal
	SHARED VARIABLE stage :Integer:= 0;								--and variable
BEGIN
	PROCESS(clock,reset)											--Start process
		BEGIN
			IF(risINg_edge(clock)) THEN
				IF(reset = '1') THEN
					stage := 0;
				END IF;
				IF((mfc = '1' or wmfc = '0')) THEN
					stage := stage mod 5 + 1;
				END IF;
				IF(stage = 1) THEN									--Instruction fetch
					wmfc <= '1';
					alu_op <= "00";
					c_select <= "01";
					y_select <= "00";
					rf_write <= '0';
					b_select <= '0';
					a_Inv <= '0';
					b_Inv <= '0';
					extEnd <= "00";
					ir_enable <= '1';
					ma_select <= '1';
					mem_read <= '1';
					mem_write <= '0';
					pc_select <= '1';
					pc_enable <= mfc;
					Inc_select <= '0';
				ELSIF(stage = 2) THEN								--Register load
					wmfc <= '0';
					ir_enable <= '0';
					mem_read <= '0';
					pc_enable <= '0';
					
				ELSIF(stage = 3) THEN										--ALU,branch,jump op
					IF(opCode(3) = '0' and opCode(2) = '0') THEN			--R-type instructions
						IF(opCode(1) = '0' and opCode(0) = '1') THEN
						--This is for JR, just fill in the values for the if statement
						ELSIF(opCode(1) = '0' and opCode(0) = '0') THEN
							--This for the other instructions
							IF(opx = "111") THEN								
								alu_op <= "00";								--AND instruction
							ELSIF(opx = "110") THEN
								alu_op <= "01";								--OR instruction
							ELSIF(opx = "101") THEN
								alu_op <= "10";								--XOR instruction
							ELSIF(opx = "100") THEN
								alu_op <= "11";								--ADD instruction
							ELSIF(opx = "011") THEN
								alu_op <= "11";								--SUB instruction
								b_Inv <= '1';
							END IF;
						END IF;
					END IF;
				ELSIF(stage = 4) THEN										--Memory stage
					--R-type instructions
					IF(opCode(3) = '0' and opCode(2) = '0') THEN
						IF(opCode(1) = '0' and opCode(0) = '1') THEN
						--This is for JR, just fill in the values for the if statement
						--We will have to set some flags here in the future
						END IF;
					END IF;
				ELSIF(stage = 5) THEN										--Write back stage
					--R-type instructions
					IF(opCode(3) = '0' and opCode(2) = '0') THEN
						IF(opCode(1) = '0' and opCode(0) = '1') THEN
						--This is for JR, just fill in the values for the if statement
						ELSIF(opCode(1) = '0' and opCode(0) = '0') THEN
							rf_write <= '1';
						END IF;
					END IF;
				END IF;
			END IF;
	END PROCESS;
END behavior;