library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;	
use work.riscv_pkg.all;

entity unidadeDeControle is
    port 
	 (
			opcode:     in std_logic_vector(6 downto 0);					
			Mem2Reg:    out std_logic;		
			LeMem:      out std_logic;		
			Branch:     out std_logic;		
			ALUop:      out std_logic_vector(2 downto 0); 
			EscreveMem: out std_logic;		
			OrigULA:    out std_logic;		
			EscreveReg: out std_logic;		
			JAL:        out std_logic;		
			JALR:       out std_logic								
	);
end unidadeDeControle;

architecture arc of unidadeDeControle is

	signal aux_opcode: 		std_logic_vector(6 downto 0);					
	signal aux_Mem2Reg:    	std_logic;		
	signal aux_LeMem:      	std_logic;		
	signal aux_Branch:     	std_logic;		
	signal aux_ALUop:      	std_logic_vector(2 downto 0); 
	signal aux_EscreveMem: 	std_logic;		
	signal aux_OrigULA:    	std_logic;		
	signal aux_EscreveReg: 	std_logic;		
	signal aux_JAL:        	std_logic;		
	signal aux_JALR:       	std_logic;
	
	begin
	
		aux_opcode <= opcode;
		Branch <= aux_Branch;
		LeMem <= aux_LeMem;
		Branch <= aux_Branch;
		ALUop <= aux_ALUop;
		EscreveMem <= aux_EscreveMem;
		OrigULA <= aux_OrigULA;
		EscreveReg <= aux_EscreveReg;
		JAL <= aux_JAL;
		JALR <= aux_JALR;
		
		
		process (aux_opcode)
			begin
				case opcode is 
				-- Instruções do tipo-R (add, sub, and, or, slt)
					when "0110011"	=>
						aux_Mem2Reg 	<= '0';
						aux_LeMem	<= '0';
						aux_Branch 	<= '0';
						aux_ALUop 	<= "010";
						aux_EscreveMem 	<= '0';
						aux_OrigULA 	<= '0';
						aux_EscreveReg 	<= '1';
						aux_JAL 	<= '0';
						aux_JALR 	<= '0';
			
						-- Instrução lw  OK
					when "0000011" =>
						aux_Mem2Reg 	<= '1';
						aux_LeMem	<= '1';
						aux_Branch 	<= '0';
						aux_ALUop 	<= "000";
						aux_EscreveMem 	<= '0';
						aux_OrigULA 	<= '1';
						aux_EscreveReg 	<= '1';
						aux_JAL 	<= '0';
						aux_JALR 	<= '0';
						
						-- Instrução sw  OK
					when "0100011" =>
						aux_Mem2Reg 	<= '0';
						aux_LeMem	<= '0';
						aux_Branch 	<= '0';
						aux_ALUop 	<= "000";
						aux_EscreveMem 	<= '1';
						aux_OrigULA 	<= '1';
						aux_EscreveReg 	<= '0';
						aux_JAL 	<= '0';
						aux_JALR 	<= '0';
						
						-- Instrução beq  OK
					when "1100011" =>
						aux_Mem2Reg 	<= '0';
						aux_LeMem	<= '0';
						aux_Branch 	<= '1';
						aux_ALUop 	<= "001";
						aux_EscreveMem 	<= '0';
						aux_OrigULA 	<= '0';
						aux_EscreveReg 	<= '0';
						aux_JAL 	<= '0';
						aux_JALR 	<= '0';
						
					-- Instruções do tipo-I (addi)  Ok
					when "0010011" =>
						aux_Mem2Reg 	<= '0';
						aux_LeMem	<= '0';
						aux_Branch 	<= '0';
						aux_ALUop 	<= "011";
						aux_EscreveMem 	<= '0';
						aux_OrigULA 	<= '1';
						aux_EscreveReg 	<= '1';
						aux_JAL 	<= '0';
						aux_JALR 	<= '0';
						
					-- Instrução jal  OK
					when "1101111" =>
						aux_Mem2Reg 	<= '0';
						aux_LeMem	<= '0';
						aux_Branch 	<= '1';
						aux_ALUop 	<= "100";
						aux_EscreveMem 	<= '0';
						aux_OrigULA 	<= '0';
						aux_EscreveReg 	<= '1';
						aux_JAL 	<= '1';
						aux_JALR 	<= '0';
					
					-- Instrução jalr  OK
					when "1100111" =>
						aux_Mem2Reg 	<= '0';
						aux_LeMem	<= '0';
						aux_Branch 	<= '0';
						aux_ALUop 	<= "011";
						aux_EscreveMem 	<= '0';
						aux_OrigULA 	<= '1';
						aux_EscreveReg 	<= '1';
						aux_JAL 	<= '1';
						aux_JALR 	<= '1';
						
					when others =>
						aux_Mem2Reg 	<= '0';
						aux_LeMem	<= '0';
						aux_Branch 	<= '0';
						aux_ALUop 	<= "000";
						aux_EscreveMem 	<= '0';
						aux_OrigULA 	<= '0';
						aux_EscreveReg 	<= '0';
						aux_JAL 	<= '0';
						aux_JALR 	<= '0';
	end case;
	end process;
end arc;
	
