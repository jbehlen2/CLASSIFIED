library ieee;
use ieee.std_logic_1164.all;

Entity controlUnit Is
	Port(																			--Inputs
		opCode,Cond 	 		:In std_logic_vector(3 downto 0);
		opx 				 		:In std_logic_vector(2 downto 0);
		S,N,C,V,Z,mfc,
		clock,reset 	 		:In std_logic;
		alu_op,c_select,
		y_select,extend      :Out std_logic_vector(1 downto 0);	--Outputs
		rf_write,b_select,
		a_inv,b_inv,ir_enable,
		ma_select,mem_read,
		mem_write,pc_select,
		pc_enable,inc_select :Out std_logic
	);
End controlUnit;

Architecture behavior of controlUnit Is
	signal wmfc :std_logic;													--Define signal
	shared variable stage :integer:= 0;									--and variable
Begin
	Process(clock,reset)														--Start process
		Begin
			If(rising_edge(clock)) Then
				If(reset = '1') Then
					stage := 0;
				End If;
				If((mfc = '1' or wmfc = '0')) Then
					stage := stage mod 5 + 1;
				End If;
				If(stage = 1) Then											--Instruction fetch
					wmfc <= '1';
					alu_op <= "00";
					c_select <= "01";
					y_select <= "00";
					rf_write <= '0';
					b_select <= '0';
					a_inv <= '0';
					b_inv <= '0';
					extend <= "00";
					ir_enable <= '1';
					ma_select <= '1';
					mem_read <= '1';
					mem_write <= '0';
					pc_select <= '1';
					pc_enable <= mfc;
					inc_select <= '0';
				Elsif(stage = 2) Then										--Register load
					wmfc <= '0';
					ir_enable <= '0';
					mem_read <= '0';
					pc_enable <= '0';
					
				Elsif(stage = 3) Then										--ALU,branch,jump op
					If(opCode(3) = '0' and opCode(2) = '0') Then		--R-type instructions
						If(opCode(1) = '0' and opCode(0) = '1') Then
						--This is for JR, just fill in the values for the if statement
						Elsif(opCode(1) = '0' and opCode(0) = '0') Then
							--This for the other instructions
							If(opx = "111") Then								
								alu_op <= "00";								--AND instruction
							Elsif(opx = "110") Then
								alu_op <= "01";								--OR instruction
							Elsif(opx = "101") Then
								alu_op <= "10";								--XOR instruction
							Elsif(opx = "100") Then
								alu_op <= "11";								--ADD instruction
							Elsif(opx = "011") Then
								alu_op <= "11";								--SUB instruction
								b_inv <= '1';
							End If;
						End If;
					End If;
				Elsif(stage = 4) Then										--Memory stage
					--R-type instructions
					If(opCode(3) = '0' and opCode(2) = '0') Then
						If(opCode(1) = '0' and opCode(0) = '1') Then
						--This is for JR, just fill in the values for the if statement
						--We will have to set some flags here in the future
						End If;
					End If;
				Elsif(stage = 5) Then										--Write back stage
					--R-type instructions
					If(opCode(3) = '0' and opCode(2) = '0') Then
						If(opCode(1) = '0' and opCode(0) = '1') Then
						--This is for JR, just fill in the values for the if statement
						Elsif(opCode(1) = '0' and opCode(0) = '0') Then
							rf_write <= '1';
						End If;
					End If;
				End If;
			End If;
	End Process;
End behavior;