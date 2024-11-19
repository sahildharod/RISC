library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity preg3 is

    port ( store_data_in : in std_logic_vector(15 downto 0);
			  pc_in : in std_logic_vector(15 downto 0);
			  flush_orex : in std_logic;
			  stall_orex : in std_logic;
           reg_add_in : in std_logic_vector(2 downto 0);
           reg_write_in: in std_logic;
           mem_write_in: in std_logic;
           control_data_in : in std_logic_vector(1 downto 0);
           alu2_a_in : in std_logic_vector(15 downto 0);
           alu2_b_in : in std_logic_vector(15 downto 0);
           reg_c_data_in : in std_logic_vector(15 downto 0);
           opcode_in : in std_logic_vector(3 downto 0);
           comp_control_in : in std_logic;
           cz_flag_control_in : in std_logic_vector(1 downto 0);
           imm6_in : in std_logic_vector(5 downto 0);
           imm9_in : in std_logic_vector(8 downto 0);
			  alub_mux1_in : in std_logic_vector(1 downto 0);
			  alub_mux2_in : in std_logic_vector(1 downto 0);
			  --lm_sm_mux_in : in std_logic;
			  imm_mux_in : in std_logic;
			  lmsm_regmux_in , lmsm_destmux_in : in std_logic;
           clk : in std_logic;
           rst : in std_logic;
			  

           store_data_out : out std_logic_vector(15 downto 0);
			  pc_out : out std_logic_vector(15 downto 0);
           reg_add_out : out std_logic_vector(2 downto 0);
           reg_write_out: out std_logic;
           mem_write_out: out std_logic;
           control_data_out : out std_logic_vector(1 downto 0);
           alu2_a_out : out std_logic_vector(15 downto 0);
           alu2_b_out : out std_logic_vector(15 downto 0);
           reg_c_data_out : out std_logic_vector(15 downto 0);
           opcode_out : out std_logic_vector(3 downto 0);
           comp_control_out : out std_logic;
           cz_flag_control_out : out std_logic_vector(1 downto 0);
           imm6_out : out std_logic_vector(5 downto 0);
           imm9_out : out std_logic_vector(8 downto 0);
			  alub_mux1_out : out std_logic_vector(1 downto 0);
			  alub_mux2_out : out std_logic_vector(1 downto 0);
			  --lm_sm_mux_out : out std_logic;
			  imm_mux_out : out std_logic;
			  lmsm_regmux_out , lmsm_destmux_out : out std_logic

        );


end entity preg3;

architecture p3bhev  of preg3 is
    signal store_data : std_logic_vector(15 downto 0):="0000000000000000";
    signal reg_add : std_logic_vector(2 downto 0):="001";
    signal regwrite : std_logic:='0';
    signal memadd : std_logic_vector(15 downto 0):="0000000000000000";
    signal memwrite : std_logic:='0';
    signal controldata : std_logic_vector(1 downto 0):="00";
    signal alua : std_logic_vector(15 downto 0):="0000000000000000";
    signal alub : std_logic_vector(15 downto 0):="0000000000000000";
    signal regcdata : std_logic_vector(15 downto 0):="0000000000000000";
    signal opcode : std_logic_vector(3 downto 0):="0000";
    signal compcontrol : std_logic:='0';
    signal czflagcontrol : std_logic_vector(1 downto 0):="00";
    signal imm6 : std_logic_vector(5 downto 0):="000000";
    signal imm9 : std_logic_vector(8 downto 0):="000000000";
	 signal alub_mux1 : std_logic_vector(1 downto 0):="00";
	 signal alub_mux2 : std_logic_vector(1 downto 0):="00";
	 signal lm_sm_mux : std_logic:='0';
	 signal imm_mux : std_logic:='0';
	 signal pc : std_logic_vector(15 downto 0):="0000000000000000";
	 signal lmsm_regmux , lmsm_destmux : std_logic := '0';
	 
    begin
        store_data_out <= store_data;
        reg_add_out <= reg_add;
        reg_write_out <= regwrite;
        mem_write_out <= memwrite;
        control_data_out <= controldata;
        alu2_a_out <= alua;
        alu2_b_out <= alub;
        reg_c_data_out <= regcdata;
        opcode_out <= opcode;
        comp_control_out <= compcontrol;
        cz_flag_control_out <= czflagcontrol;
        imm6_out <= imm6;
        imm9_out <= imm9; 
		  alub_mux1_out <= alub_mux1;
		  alub_mux2_out <= alub_mux2;
		  --lm_sm_mux_out <= lm_sm_mux;
		  imm_mux_out <= imm_mux;
		  lmsm_regmux_out <= lmsm_regmux;
		  lmsm_destmux_out <= lmsm_destmux; 
		  pc_out <= pc;
        process(clk,rst)
            begin
                if ( rst = '1') then
                    store_data <= (others => '0');
						  pc <= (others => '0');
                    reg_add <= "001";
                    regwrite <= '0';
                    memwrite <= '0';
                    controldata <= (others => '0');
                    alua <= (others => '0');
                    alub <= (others => '0');
                    regcdata <= (others => '0');
                    opcode <= (others => '0');
                    compcontrol <= '0';
                    czflagcontrol <= (others => '0');
                    imm6 <= (others => '0');
                    imm9 <= (others => '0');
						  imm_mux <= '0';
						  --lm_sm_mux <= '0';
						  alub_mux1 <= (others => '0');
						  alub_mux2 <= (others => '0');
						  lmsm_regmux <= '0';
						  lmsm_destmux <= '0';
						  


						elsif(stall_orex = '1') then
						  store_data <= store_data;
                    reg_add <= reg_add;
                    regwrite <= regwrite;
                    memwrite <= memwrite;
                    controldata <= controldata;
                    alua <= alua;
                    alub <= alub;
                    regcdata <= regcdata;
                    opcode <= opcode;
                    compcontrol <= compcontrol;
                    czflagcontrol <= czflagcontrol;
                    imm6 <= imm6;
                    imm9 <= imm9;
						  pc <= pc;
						  alub_mux1 <= alub_mux1;
						  alub_mux2 <= alub_mux2;
						  --lm_sm_mux <= lm_sm_mux;
						  imm_mux <= imm_mux;
						  lmsm_regmux <= lmsm_regmux;
						  lmsm_destmux <= lmsm_destmux; 
						  
						 elsif(falling_edge(clk)) then 
							                
							if(flush_orex = '1') then
								store_data <= (others => '0');
								reg_add <= "001";
								regwrite <= '0';
								memwrite <= '0';
							controldata <= (others =>'0');
                    alua <= (others => '0');
                    alub <= (others => '0');
                    regcdata <= (others => '0');
                    opcode <= (others => '0');
                    compcontrol <= '0';
                    czflagcontrol <= (others => '0');
                    imm6 <= (others => '0');
                    imm9 <= (others => '0');
						  pc <= (others => '0');
						  imm_mux <= '0';
						  --lm_sm_mux <= '0';
						  alub_mux1 <= (others => '0');
						  alub_mux2 <= (others => '0');
						  lmsm_regmux <= '0';
						  lmsm_destmux <= '0';
						  
						 else
                    store_data <= store_data_in;
                    reg_add <= reg_add_in;
                    regwrite <= reg_write_in;
                    memwrite <= mem_write_in;
                    controldata <= control_data_in;
                    alua <= alu2_a_in;
                    alub <= alu2_b_in;
                    regcdata <= reg_c_data_in;
                    opcode <= opcode_in;
                    compcontrol <= comp_control_in;
                    czflagcontrol <= cz_flag_control_in;
                    imm6 <= imm6_in;
						  pc <= pc_in;
                    imm9 <= imm9_in;
						  alub_mux1 <= alub_mux1_in;
						  alub_mux2 <= alub_mux2_in;
						  --lm_sm_mux <= lm_sm_mux_in;
						  imm_mux <= imm_mux_in; 
						  lmsm_regmux <= lmsm_regmux_in;
						  lmsm_destmux <= lmsm_destmux_in;
						 end if;
                end if;
        end process;
        
end architecture p3bhev;