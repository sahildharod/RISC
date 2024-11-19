library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity preg2 is

    port ( pc_in : in std_logic_vector(15 downto 0);
           --reg_add_in : in std_logic_vector(2 downto 0);
           reg_write_in: in std_logic;
           mem_write_in: in std_logic;
           control_data_in : in std_logic_vector(1 downto 0);
           opcode_in : in std_logic_vector(3 downto 0);
           comp_control_in : in std_logic;
           cz_flag_control_in : in std_logic_vector(1 downto 0);
           rega_add_in : in std_logic_vector(2 downto 0);
           regb_add_in : in std_logic_vector(2 downto 0);
           regc_add_in : in std_logic_vector(2 downto 0);
           imm6_in : in std_logic_vector(5 downto 0);
           imm9_in : in std_logic_vector(8 downto 0);
			  alub_mux1_in : in std_logic_vector(1 downto 0);
			  alub_mux2_in : in std_logic_vector(1 downto 0);
			  alua_mux_rr_in : in std_logic;
			  --lm_sm_mux_in : in std_logic; --left reminder **
			  imm_mux_in : in std_logic;
			  lmsm_regmux_in , lmsm_destmux_in: in std_logic;
			  sm_mem_mux_in : in std_logic;

			  flush_idor : in std_logic;
			  stall_idor : in std_logic;
			  
           clk : in std_logic;
           rst : in std_logic;
           --reg_add_out : out std_logic_vector(2 downto 0);
			  --lm_sm_mux_out : out std_logic;
           reg_write_out: out std_logic;
           mem_write_out: out std_logic;
           control_data_out : out std_logic_vector(1 downto 0);
           opcode_out : out std_logic_vector(3 downto 0);
           comp_control_out : out std_logic;
           cz_flag_control_out : out std_logic_vector(1 downto 0);
           rega_add_out : out std_logic_vector(2 downto 0);
           regb_add_out : out std_logic_vector(2 downto 0);
           regc_add_out : out std_logic_vector(2 downto 0);
           imm6_out : out std_logic_vector(5 downto 0);
           imm9_out : out std_logic_vector(8 downto 0);
			  alub_mux1_out : out std_logic_vector(1 downto 0);
			  alub_mux2_out : out std_logic_vector(1 downto 0);
			  alua_mux_rr_out : out std_logic;
			  imm_mux_out : out std_logic;
			  lmsm_regmux_out , lmsm_destmux_out: out std_logic;
			   sm_mem_mux_out : out std_logic;
			  pc_out : out std_logic_vector(15 downto 0)

        );


end entity preg2;

architecture p2bhev  of preg2 is
    --signal regadd : std_logic_vector(2 downto 0);
    signal regwrite : std_logic:='0';
    signal memwrite : std_logic:='0';
    signal controldata : std_logic_vector(1 downto 0):="00";
    signal opcode : std_logic_vector(3 downto 0):="0011";
    signal compcontrol : std_logic:='0';
    signal czflagcontrol : std_logic_vector(1 downto 0):="00";
    signal imm6 : std_logic_vector(5 downto 0):="000000";
    signal imm9 : std_logic_vector(8 downto 0):="000000000";
    signal rega : std_logic_vector(2 downto 0):="000";
    signal regb : std_logic_vector(2 downto 0):="000";
    signal regc : std_logic_vector(2 downto 0):="001"; 
	 signal pc : std_logic_vector(15 downto 0):="0000000000000000";
	 signal alub_mux1 : std_logic_vector(1 downto 0):="00";
	 signal alub_mux2 : std_logic_vector(1 downto 0):="00";
	 --signal lm_sm_mux : std_logic;
	 signal imm_mux : std_logic:='0';
	 signal alua_mux_rr : std_logic:='0';
	 signal lmsm_regmux , lmsm_destmux: std_logic;
	 signal sm_mem_mux : std_logic;

	 
	 
    begin
		  pc_out <= pc;
        --reg_add_out <= regadd;
        reg_write_out <= regwrite;
        mem_write_out <= memwrite;
        control_data_out <= controldata;
        opcode_out <= opcode;
        comp_control_out <= compcontrol;
        cz_flag_control_out <= czflagcontrol;
        imm6_out <= imm6;
        imm9_out <= imm9; 
        rega_add_out <= rega;
        regb_add_out <= regb;
        regc_add_out <= regc;
		  alub_mux1_out <= alub_mux1;
		  alub_mux2_out <= alub_mux2;
		  --lm_sm_mux_out <= lm_sm_mux;
		  imm_mux_out <= imm_mux; 	
		  alua_mux_rr_out <= alua_mux_rr;
		  lmsm_regmux_out <= lmsm_regmux;
		  lmsm_destmux_out <= lmsm_destmux;
         sm_mem_mux_out <=  sm_mem_mux;
	
	
        process(clk,rst)
            begin
                if ( rst = '1') then
                    pc <= (others => '0');
                    --regadd <= (others => '0');
                    regwrite <= '0';
                    memwrite <= '0';
                    controldata <=  (others => '0');
                    opcode <= (others => '0');
                    compcontrol <= '0';
                    czflagcontrol <= (others => '0');
                    imm6 <= (others => '0');
                    imm9 <= (others => '0');
                    rega <= (others => '0');
                    regb <= (others => '0');
                    regc <= "001";
						  imm_mux <= '0';
						  --lm_sm_mux <= '0';
						  alub_mux1 <= (others => '0');
						  alub_mux2 <= (others => '0');
						  alua_mux_rr <= '0';
						  lmsm_regmux <= '0';
						  lmsm_destmux <= '0';
						 sm_mem_mux <= '0';
                
					   elsif(flush_idor = '1') then
						  pc <= (others => '0');
                    --regadd <= (others => '0');
                    regwrite <= '0';
                    memwrite <= '0';
                    controldata <=  (others => '0');
                    opcode <= (others => '0');
                    compcontrol <= '0';
                    czflagcontrol <= (others => '0');
                    imm6 <= (others => '0');
                    imm9 <= (others => '0');
                    rega <= (others => '0');
                    regb <= (others => '0');
                    regc <= "001";
						  imm_mux <= '0';
						  --lm_sm_mux <= '0';
						  alub_mux1 <= (others => '0');
						  alub_mux2 <= (others => '0');
						  alua_mux_rr <= '0';
						  lmsm_regmux <= '0';
						  lmsm_destmux <= '0';
						  sm_mem_mux <='0';
                
					 
					   elsif(stall_idor = '1') then
						  pc <= pc;
                    --regadd <= regadd;
                    regwrite <= regwrite;
                    memwrite <= memwrite;
                    controldata <= controldata;
                    opcode <= opcode;
                    compcontrol <= compcontrol;
                    czflagcontrol <= czflagcontrol;
                    imm6 <= imm6;
                    imm9 <= imm9; 
                    rega <= rega;
                    regb <= regb;
                    regc <= regc;
						  alub_mux1 <= alub_mux1;
						  alub_mux2 <= alub_mux2;
						  --lm_sm_mux <= lm_sm_mux;
						  imm_mux <= imm_mux; 
						  alua_mux_rr <= alua_mux_rr;
						  lmsm_regmux <= lmsm_regmux;
						  lmsm_destmux <= lmsm_destmux;
						 sm_mem_mux <=  sm_mem_mux;
                
						  
					   elsif(falling_edge(clk)) then 

                    pc <= pc_in;
                    --regadd <= reg_add_in;
                    regwrite <= reg_write_in;
                    memwrite <= mem_write_in;
                    controldata <= control_data_in;
                    opcode <= opcode_in;
                    compcontrol <= comp_control_in;
                    czflagcontrol <= cz_flag_control_in;
                    imm6 <= imm6_in;
                    imm9 <= imm9_in; 
                    rega <= rega_add_in;
                    regb <= regb_add_in;
                    regc <= regc_add_in;         
						  alub_mux1 <= alub_mux1_in;
						  alub_mux2 <= alub_mux2_in;
						  --lm_sm_mux <= lm_sm_mux_in;
						  imm_mux <= imm_mux_in; 
						  alua_mux_rr <= alua_mux_rr_in;
						  lmsm_regmux <= lmsm_regmux_in;
						  lmsm_destmux <= lmsm_destmux_in;
                sm_mem_mux <= sm_mem_mux_in ;
						  
				  end if;
        end process;
        
end architecture p2bhev;

