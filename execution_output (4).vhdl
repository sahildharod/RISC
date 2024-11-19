library ieee;
use ieee.std_logic_1164.all;

entity ex_out_block is
	port (
			rc : in std_logic_vector(15 downto 0);
			alu_c :  in std_logic_vector(15 downto 0);
			carry_zero_inst : in std_logic_vector(1 downto 0);
			carry,zero : in std_logic;
			opcode : in std_logic_vector(3 downto 0);
			alu_c_final : out std_logic_vector(15 downto 0)
	     );
		  
end entity ex_out_block;

architecture bhv of ex_out_block is
	begin
		process(alu_c , rc)
		begin
		if (opcode = "0001" or opcode = "0010") then
			if (carry_zero_inst = "10") then
				if(carry = '1') then
					alu_c_final <= alu_c;
				else
					alu_c_final <= rc;
				end if;
			elsif(carry_zero_inst = "01") then
				if(zero = '1') then
					alu_c_final <= alu_c;
				else 
					alu_c_final <= rc;
				end if;
			else
					alu_c_final <= alu_c;
			end if;
		elsif(opcode = "1000" or opcode = "1001" or opcode = "1010") then
			alu_c_final <= rc; -- memory size issue
		else 
			alu_c_final <= alu_c;
		end if;
		end process;
end architecture bhv;
	