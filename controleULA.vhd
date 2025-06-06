library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;	
use work.riscv_pkg.all;

entity ULAControle is
    port 
	 (
		ALUop: 			in std_logic_vector(2 downto 0);
		funct3: 			in std_logic_vector(2 downto 0);
		funct7: 			in std_logic;					-- Pegando só o bit mais importate
		controleULA: 	out std_logic_vector(3 downto 0)
	);
end ULAControle;

architecture arc of ULAControle is
begin
		
	process (ALUop, funct3, funct7)
	begin
	case ALUop is
		when "000" => 									-- lw e sw (fazem add)
			controleULA <= "0010";
				
		when "001" => 									-- beq
			controleULA <= "0110";
				
		when "010" => 									-- instruções do tipo-R (add, sub, and, or, slt)
			case funct3 is
				when "000" => 
					if funct7 = '0' then 
						controleULA <= "0010"; 				-- add
					else 
						controleULA <= "0110"; 				-- sub
					end if;
 						
				when "111" => 							-- and
					controleULA <= "0000";
					
				when "110" => 
					controleULA <= "0001"; 					-- or
						
				when "010" =>
					controleULA <= "0111"; 					-- slt
				end case;
						
			when "011" =>					
				controleULA <= "0010"; 						-- addi e jalr (os dois fazem add). Note que o jal não passa pela ULA
							
	end case;
	end process;
end arc;
	
