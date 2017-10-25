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
			N,C,Z,V :OUT std_logic
		);
	END COMPONENT;
BEGIN
	
END behavior;