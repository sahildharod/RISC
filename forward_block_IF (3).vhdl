--stall bit add krlena	for LM SM;also add in pipeline registers;when stalled output not changing;implemented by intermediate signals

library ieee;
use ieee.std_logic_1164.all;

entity forward_block_IF is 
port(PC_regular,PC_Imm,out_ex,out_mem,out_wb,jlr_alu:in std_logic_vector(15 downto 0);
			opcode_ex,opcode_mem:in std_logic_vector(3 downto 0);
			rd_ex,rd_mem,rd_wb:in std_logic_vector(2 downto 0);
			PC_final:out std_logic_vector(15 downto 0));
end entity forward_block_IF;
	
architecture behav of forward_block_IF is
	begin
	process(PC_regular,PC_Imm,out_ex,out_mem,out_wb,opcode_ex,opcode_mem,rd_ex,rd_mem,rd_wb,jlr_alu)
		begin
		
		if(opcode_mem="0100" or opcode_mem="0011" or opcode_mem = "0110") then -- AM into R0 -> out mem daaldo
			if(rd_mem="000") then
				PC_final<=out_mem;
			else
				PC_final<=PC_regular;
			end if;
		
		elsif(opcode_ex="1000" or opcode_ex="1001" or opcode_ex="1010") then -- Branch
			if(out_ex="1111111111111111") then
				PC_final<=PC_Imm;
			else 
				PC_final<= PC_regular;
			end if;
		elsif(opcode_ex="1100") then  -- Jump
			PC_final<=PC_Imm;
		elsif(opcode_ex="1111") then
			PC_final<=out_ex;
		elsif	(opcode_ex="1101") then
			PC_final<=jlr_alu;
		elsif (opcode_ex="0000" or opcode_ex="0001" or opcode_ex="0010") then -- Load into R0 -> ex_out 
			if(rd_ex="000") then
				PC_final<=out_ex;
			else
				PC_final<=PC_regular;
			end if;
		elsif(opcode_mem="0100" or opcode_mem="0011" or opcode_mem = "0110") then -- AM into R0 -> out mem daaldo
			if(rd_mem="000") then
				PC_final<=out_mem;
			else
				PC_final<=PC_regular;
		end if;
		else
			PC_final<=PC_regular;
		end if;
		
		if (opcode_ex="0000" or opcode_ex="0001" or opcode_ex="0010") then -- Load into R0 -> ex_out 
			if(rd_ex="000") then
				PC_final<=out_ex;
			else
				PC_final<=PC_regular;
			end if;
		end if;
	end process;
end architecture behav;