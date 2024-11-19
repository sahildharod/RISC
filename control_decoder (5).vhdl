library ieee;
use ieee.std_logic_1164.all;
-- lm sm mux 
entity control_decoder is
	port (inst : in std_logic_vector(15 downto 0);
	      clk : in std_logic;
			reg_file_write : out std_logic;
			mem_write : out std_logic;
			mem_data_select : out std_logic_vector(1 downto 0);
			carry_zero_inst : out std_logic_vector(1 downto 0);
			alub_mux1 : out std_logic_vector(1 downto 0);
			alub_mux2 : out std_logic_vector(1 downto 0);
			alua_mux_rr : out std_logic;
			imm_mux : out std_logic;
			lmsm_regmux : out std_logic;
			lmsm_destmux : out std_logic;
			sm_memmux : out std_logic; 
			complement : out std_logic;
			opcode : out std_logic_vector(3 downto 0)
			
		);
end entity control_decoder;

architecture bhv of control_decoder is
signal opcode1 : std_logic_vector(3 downto 0);
signal complement1 : std_logic;
	begin
	
	
	
	process(inst,clk)
	begin
	
	opcode1 <= inst(15 downto 12);
	complement<=inst(2);
	complement1<=inst(2);

	opcode <= inst(15 downto 12);
	carry_zero_inst <= inst(1 downto 0);
	
	mem_write <= (not(inst(15)) and inst(14) and inst(12));
	
	alua_mux_rr <= inst(15) and inst(14) and not(inst(13));
	
	case opcode1 is
   when "0100" => mem_data_select <= "00";
	when "0110" => mem_data_select <= "00";
	when "1111" => mem_data_select <= "00";
	when "0011" => mem_data_select <= "01";
	when others => mem_data_select <= "10";
	end case;

	case opcode1 is

	when "0000" => reg_file_write <= '1';
	when "0001" => reg_file_write <= '1';
	when "0010" => reg_file_write <= '1';
	when "0011" => reg_file_write <= '1';
	when "0100" => reg_file_write <= '1';
	when "0110" => reg_file_write <= '1';
	when "1100" => reg_file_write <= '1';
	when "1101" => reg_file_write <= '1';
	when others => reg_file_write <= '0';
	end case;
	
	case opcode1 is
	when "1100" => alub_mux1 <= "11";
	when "1101" => alub_mux1 <= "11";
	when "1111" => alub_mux1 <= "10";
	when "0011" => alub_mux1 <= "10";
	when "0000" => alub_mux1 <= "01";
	when "0100" => alub_mux1 <= "01";
	when "0101" => alub_mux1 <= "01";
	when others => alub_mux1 <= "00";
	end case;
	
	case opcode1 is
	when "0001" =>
		case complement1 is
		when '1'=> alub_mux2 <= "01";
		when others =>	alub_mux2 <= "00";
		end case;
	when "0010" =>
	case complement1 is
		when '1'=> alub_mux2 <= "01";
		when others =>	alub_mux2 <= "00";
		end case;
	when "0110" =>alub_mux2 <= "10";
	when "0111" => alub_mux2 <= "10";
	when others => alub_mux2 <= "00";
	end case;
	
	case opcode1 is
	when "1000" => imm_mux <= '0';
	when "1001" => imm_mux <= '0';
	when "1010" => imm_mux <= '0';
	when "1100" => imm_mux <= '1';
	when others => imm_mux <= '0';
	end case;
	
	----recheck for lmsm 
	case opcode1 is
	when "0110" => lmsm_regmux <= '1';
	when others => lmsm_regmux <= '0';
	end case;
	
	case opcode1 is
	when "0110" => lmsm_destmux <= '1';
	--when "0111" => lmsm_destmux <= '1';
	when others => lmsm_destmux <= '0';
	end case;
		
	case opcode1 is
	when "0111" => sm_memmux <= '1';
	--when "0111" => lmsm_destmux <= '1';
	when others => sm_memmux <= '0';
	end case;
	end process;
	end architecture bhv;