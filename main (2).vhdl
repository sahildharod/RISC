library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

	
entity main is
    port( rst : in std_logic;
          clk : in std_logic;
			 wb_reg : out std_logic_vector(15 downto 0));
end entity main;

architecture bhv of main is

component inst_memory is

	port(rst : in std_logic ; 
        mem_address : in std_logic_vector(15 downto 0);
		mem_output : out std_logic_vector(15 downto 0));

end component inst_memory;

component data_memory is

	port(rst , mem_write: in std_logic ; 
        mem_input , mem_address : in std_logic_vector(15 downto 0);
		mem_output : out std_logic_vector(15 downto 0));

end component data_memory;

component Register_File is    
    port(

        clk,rst : in std_logic;
		rf_d3 : in std_logic_vector(15 downto 0);  
		pc_rr : in std_logic_vector(15 downto 0);
		
		----------- address lines of mux, basically we are reading values of 3 registers A,B and C
	  	rf_a1 : in std_logic_vector(2 downto 0);
		rf_a2 : in std_logic_vector(2 downto 0);
		rf_a4 : in std_logic_vector(2 downto 0);
		----------- tells the address of the register to which we have to write in the data
		rf_a3 : in std_logic_vector(2 downto 0);
		----------- control variabe for registers
		rf_write : in std_logic;
		rf_d1 : out std_logic_vector(15 downto 0);
		rf_d2 : out std_logic_vector(15 downto 0);
		rf_d4 : out std_logic_vector(15 downto 0));

end component;

component preg1 is
    port (  pc_in : in std_logic_vector(15 downto 0);
            instruction_in : in std_logic_vector(15 downto 0);
				flush_ifid : in std_logic;
				stall_ifid : in std_logic;
				rst : in std_logic;
				clk : in std_logic;
            pc_out : out std_logic_vector(15 downto 0);
            instruction_out : out std_logic_vector(15 downto 0)          
        );
end component preg1;


component preg2 is

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

end component preg2;

component preg3 is

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


end component preg3;

component preg4 is

    port ( store_data_in : in std_logic_vector(15 downto 0);
           reg_add_in : in std_logic_vector(2 downto 0);
           reg_write_in: in std_logic;
           mem_address_in: in std_logic_vector(15 downto 0);
			  opcode_in : in std_logic_vector(3 downto 0);
           mem_write_in: in std_logic;
			  flush_exmem : in std_logic;
			  imm9_in : in std_logic_vector(8 downto 0);
           clk : in std_logic;
           rst : in std_logic;
           control_data_in : in std_logic_vector(1 downto 0);
			  imm9_out : out std_logic_vector(8 downto 0);
           store_data_out : out std_logic_vector(15 downto 0);
           reg_add_out : out std_logic_vector(2 downto 0);
			  reg_write_out: out std_logic;
			  mem_address_out: out std_logic_vector(15 downto 0);
			  opcode_out : out std_logic_vector(3 downto 0);
           mem_write_out: out std_logic;
           control_data_out : out std_logic_vector(1 downto 0)
        );

end component preg4;

component preg5 is

    port ( data_in : in std_logic_vector(15 downto 0);
           reg_add_in : in std_logic_vector(2 downto 0);
           reg_write_in: in std_logic;
           rst :in std_logic;
           clk : in std_logic;
           data_out : out std_logic_vector(15 downto 0);
           reg_add_out : out std_logic_vector(2 downto 0);
           reg_write_out: out std_logic 
        );

end component preg5;

component PC is
    port(  inputs:in std_logic_vector(15 downto 0);
           stall_pc:in std_logic;
           reset:in std_logic;
           clk:in std_logic;
           outputs:out std_logic_vector(15 downto 0));
end component PC;

component control_decoder is
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
end component control_decoder;

 component hazard_stall_unit is
    port(   opcode_id,opcode_rr,opcode_ex,opcode_mem:in std_logic_vector(3 downto 0);
            rd_ex,rd_mem,rd_wb,ra_rr,rb_rr:in std_logic_vector(2 downto 0);
            counter:in std_logic_vector(2 downto 0);
            output_ex:in std_logic_vector(15 downto 0);
				hazard_reset : in std_logic_vector(2 downto 0);
            stall_ifid,stall_idrr,stall_rrex,stall_pc:out std_logic;
            flush_ifid,flush_idrr,flush_rrex,flush_exmem:out std_logic);
end component hazard_stall_unit;

component forward_block_rr is
    port(   ra_content,rb_content:in std_logic_vector(15 downto 0);
            ra_address_rr,rb_address_rr:in std_logic_vector(2 downto 0);
            modified_ex,modified_mem,modified_wb:in std_logic_vector(15 downto 0);
            --garbage_or_not:in std_logic;
				rf_d4 : in std_logic_vector(15 downto 0);
				rd_address_rr : in std_logic_vector(2 downto 0);
            rd_ex,rd_mem,rd_wb:in std_logic_vector(2 downto 0);
            output_a,output_b:out std_logic_vector(15 downto 0);
				regc_out : out std_logic_vector(15 downto 0));
    end component forward_block_rr;

component forward_block_IF is 
    port(   PC_regular,PC_Imm,out_ex,out_mem,out_wb,jlr_alu:in std_logic_vector(15 downto 0);
			opcode_ex,opcode_mem:in std_logic_vector(3 downto 0);
			rd_ex,rd_mem,rd_wb:in std_logic_vector(2 downto 0);
			PC_final:out std_logic_vector(15 downto 0));
end component forward_block_IF;

component execution_block is
	port (
			  store_data_in : in std_logic_vector(15 downto 0); -- maybe store ka data 
			  pc : in std_logic_vector(15 downto 0);
           reg_add : in std_logic_vector(2 downto 0);
           reg_write: in std_logic;
           mem_write: in std_logic;
           control_data : in std_logic_vector(1 downto 0);
           alu2_a : in std_logic_vector(15 downto 0);
			  alu2_b : in std_logic_vector(15 downto 0);
			  alub_mux1 : in std_logic_vector(1 downto 0);
			  alub_mux2 : in std_logic_vector(1 downto 0);
			  imm_mux : in std_logic ;
           reg_c_data : in std_logic_vector(15 downto 0);
           --opcode : in std_logic_vector(1 downto 0);
           comp_control : in std_logic;
           cz_flag_control : in std_logic_vector(1 downto 0);
           imm6 : in std_logic_vector(5 downto 0);
           imm9 : in std_logic_vector(8 downto 0);
			  opcode : in std_logic_vector(3 downto 0);
			  alub_lmsm : in std_logic_vector(15 downto 0);
			  clk : in std_logic;
			  rst : in std_logic;
			  store_data_out : out std_logic_vector(15 downto 0); -- maybe store ka data 
			  alu2_output : out std_logic_vector(15 downto 0);
			  reg_add_out : out std_logic_vector(2 downto 0);
           reg_write_out : out std_logic;
           mem_write_out : out std_logic;
			  opcode_out : out std_logic_vector(3 downto 0);
			  control_data_out : out std_logic_vector( 1 downto 0);
			  alu3_out : out std_logic_vector(15 downto 0);
			  alu2_output_muxin: out std_logic_vector(15 downto 0)
			 
	);
end component execution_block;


component immediate_decoder is
    port(instruction: in std_logic_vector(15 downto 0);
			 clk : in std_logic;
          imm6:out std_logic_vector(5 downto 0);
          imm9:out std_logic_vector(8 downto 0));
end component immediate_decoder;

component MUX2input_3bit is 
port(
		add_line:in std_logic;
		input0,input1: in std_logic_vector(2 downto 0);
		output: out std_logic_vector(2 downto 0));
end component MUX2input_3bit; 

component MUX2input is 
port(
		add_line:in std_logic;
		input0,input1: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0));
end component MUX2input; 
 
component register_decoder is
    port(inst : in std_logic_vector(15 downto 0);
			clk : in std_logic;
          opr1 : out std_logic_vector(2 downto 0);
          opr2 : out std_logic_vector(2 downto 0);
          dest : out std_logic_vector(2 downto 0)
    );
end component register_decoder;

component MUX2input_1bit is 
port(
		add_line:in std_logic;
		input0,input1: in std_logic;
		output: out std_logic);
end component MUX2input_1bit; 

component MUX4input is 
port(
		a:in std_logic_vector(1 downto 0);
		input0,input1,input2,input3: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0));
end component MUX4input; 

component Sign_extender_9digit is
   port (Input_9bit: in std_logic_vector(8 downto 0); Output_16bit: out std_logic_vector(15 downto 0));
end component Sign_extender_9digit;

component RippleCarryAdder is

    port(A,B: in std_logic_vector(15 downto 0);
        Cin: in std_logic;
		  Carry: out std_logic;
        Sum: out std_logic_vector(15 downto 0)
);
    
end component RippleCarryAdder;

component reset_for_counter is 
port(opcode,opcode_ex,opcode_mem:in std_Logic_vector(3 downto 0);
		rd_ex ,rd_mem : in std_logic_vector(2 downto 0); 
		stall : in std_logic;
		flush_ifid : in std_logic;
		output_ex : in std_logic_vector(15 downto 0);
		reset_out:out std_logic_vector(1 downto 0));
end component reset_for_counter;

component hazard_counter is
    Port ( rst,clk : in std_logic;
           output: out std_logic_vector(2 downto 0));
end component hazard_counter;


component counter_stall is
port (reset_for_counter1: in std_logic_vector(1 downto 0);
		clk:in std_logic;
		counter_out:out std_logic_vector(2 downto 0));
end component counter_stall;

component lm_sm_block is
 port(counter:in std_logic_vector(2 downto 0);
		immediate:in std_logic_vector(8 downto 0);
	 	reg_write_lm: out std_logic;
		alub_input : out std_logic_vector(8 downto 0));
end component lm_sm_block;		

component sm_block is
	port(counter : in std_logic_vector(2 downto 0);
			imm9 : in std_logic_vector(8 downto 0);
			mem_write : out std_logic;
			rf_d1 : out std_logic_vector(2 downto 0));
end component sm_block;


signal forwdpcout: std_logic_vector(15 downto 0):="0000000000000000";
signal stallpc: std_logic:='0';
signal pc_init : std_logic_vector(15 downto 0):="0000000000000000";
signal forwdpcin : std_logic_vector(15 downto 0):="0000000000000000";
signal alu1_carry : std_logic:='0';
signal instruction : std_logic_vector(15 downto 0):="0011011000000111";
signal flush_ifid : std_logic:='0';
signal stall_ifid : std_logic:='0';
signal pc_out1 : std_logic_vector(15 downto 0) := "0000000000000000";
signal instruction_out1  : std_logic_vector(15 downto 0):="0011010000000011";
signal imm_mux, reg_file_write, mem_write, alua_mux_rr, complement : std_logic:='0';
signal alub_mux1, alub_mux2, carry_zero_instruction : std_logic_vector(1 downto 0):="00";
signal opcode : std_logic_vector(3 downto 0):="1110";
signal mem_data_select,mem_data_select_out2,mem_data_select_out3,mem_data_select_in4,mem_data_select_out4: std_logic_vector(1 downto 0) := "00";
signal imm6 : std_logic_vector(5 downto 0):="000000";
signal imm9 : std_logic_vector(8 downto 0):="000000000";
signal opr1, opr2 : std_logic_vector(2 downto 0):="000";
signal dest : std_logic_vector(2 downto 0) := "001";
signal pc2_out : std_logic_vector(15 downto 0):="0000000000000000";
signal opr1_out2, opr2_out2 : std_logic_vector(2 downto 0):="000";
signal dest_out2 : std_logic_vector(2 downto 0) := "001";
signal imm_mux_out2, reg_file_write_out2, mem_write_out2, alua_mux_rr_out2, complement_out2 : std_logic:='0';
signal alub_mux1_out2, alub_mux2_out2, carry_zero_instruction_out2 : std_logic_vector(1 downto 0):="00";
signal opcode_out2 : std_logic_vector(3 downto 0):="1110";
signal imm6_out2 : std_logic_vector(5 downto 0):="000000";
signal imm9_out2 : std_logic_vector(8 downto 0):="000000000";
signal flush_idor : std_logic:='0';
signal stall_idor : std_logic:='0';
signal rf_d3 : std_logic_vector(15 downto 0):="0000000000000000";
signal rf_d1 : std_logic_vector(15 downto 0):="0000000000000000";
signal rf_d2 : std_logic_vector(15 downto 0):="0000000000000000";
signal rf_d4 : std_logic_vector(15 downto 0):="0000000000000000";
signal fwdrr1, fwdrr2: std_logic_vector(15 downto 0):="0000000000000000";
signal alu2a_input : std_logic_vector( 15 downto 0):="0000000000000000";
signal alu2a_out3 : std_logic_vector( 15 downto 0):="0000000000000000";
signal flush_orex : std_logic:='0';
signal stall_orex : std_logic:='0';
signal reg_file_write_out3, mem_write_out3, complement_out3, imm_mux_out3: std_logic:='0';
signal pc_out3 : std_logic_vector(15 downto 0):="0000000000000000";
signal carry_zero_instruction_out3, alub_mux1_out3, alub_mux2_out3 : std_logic_vector(1 downto 0):="00";
signal imm6_out3  : std_logic_vector(5 downto 0):="000000";
signal imm9_out3 : std_logic_vector(8 downto 0):="000000000";
signal rf_d2out3 : std_logic_vector(15 downto 0):="0000000000000000";
signal rf_d2out3_s : std_logic_vector(15 downto 0):="0000000000000000";
signal rf_d4out3 : std_logic_vector(15 downto 0):="0000000000000000";
signal dest_out3 : std_logic_vector(2 downto 0):="001";
signal opcode_out3 : std_logic_vector(3 downto 0):="1110";
signal rfd2_in4 : std_logic_vector(15 downto 0):="0000000000000000";
signal reg_file_write_in4, mem_write_in4  : std_logic:='0';
signal alu2_output : std_logic_vector(15 downto 0):="0000000000000000";
signal dest_in4 : std_logic_vector(2 downto 0):="001";
signal opcode_in4 : std_logic_vector(3 downto 0):="1110";
signal flush_exmem: std_logic:='0';
signal opcode_out4 : std_logic_vector(3 downto 0):="1110";
signal reg_file_write_out4, mem_write_out4 : std_logic:='0';
signal alu2_outputout4 : std_logic_vector(15 downto 0):="0000000000000000";
signal dest_out4 : std_logic_vector(2 downto 0):="001";
signal rf_d2out4 : std_logic_vector(15 downto 0):="0000000000000000";
signal mem_output : std_logic_vector(15 downto 0):="0000000000000000";
signal wbout : std_logic_vector(15 downto 0):="0000000000000000";
signal wbout5 : std_logic_vector(15 downto 0):="0000000000000000";
signal dest_out5 : std_logic_vector(2 downto 0):="001";
signal reg_file_write_out5 : std_logic:='0';
signal imm9_out4 : std_logic_vector(8 downto 0):="000000000";
signal imm9_out4_ext : std_logic_vector(15 downto 0):="0000000000000000";
signal alu3_out : std_logic_vector(15 downto 0) := "0000000000000000";
signal opcode_id : std_logic_vector(3 downto 0) := "1110";
signal counter_in : std_logic_vector(2 downto 0) := "000";
signal reset_out1 : std_logic_vector(1 downto 0) := "00";
signal hazard_rst : std_logic_vector(2 downto 0) := "000";
signal alu2_out_mux : std_logic_vector(15 downto 0) := "0000000000000000";
signal regc_out2 : std_logic_vector(15 downto 0) ;
signal reg_write_lm : std_logic := '0';
signal alub_lm : std_logic_vector(8 downto 0);
signal alub_lm_se : std_logic_vector(15 downto 0);
signal lmsm_regmux , lmsm_destmux , lmsm_regmux_out2 , lmsm_regmux_out3 , lmsm_destmux_out2, lmsm_destmux_out3 : std_logic; 
signal reg_write_final : std_logic;
signal dest_final : std_logic_vector(2 downto 0);
signal dest_final_p : std_logic_vector(2 downto 0);
signal mem_write_sm : std_logic;
signal rfd1_sm : std_logic_vector(2 downto 0);
signal sm_memmux , sm_memmux_out2 , mem_write_final : std_logic := '0';


begin

    PC1: PC
        port map(forwdpcout, stallpc, rst, clk, pc_init);
	
	 forwdpcin<=pc_init + ("000000000000000"&'1');
	
    IM2: inst_memory
        port map(rst, pc_init, instruction);
    
    P1: preg1
        port map(pc_init, instruction, flush_ifid, stall_ifid, rst, clk, pc_out1, instruction_out1);
    
    CD1: control_decoder
        port map(instruction_out1,clk,reg_file_write, mem_write, mem_data_select,
         carry_zero_instruction, alub_mux1, alub_mux2, alua_mux_rr, imm_mux,lmsm_regmux,lmsm_destmux, sm_memmux, complement, opcode);

    IM1: immediate_decoder
        port map( instruction_out1,clk, imm6, imm9);

    RD1: register_decoder 
        port map( instruction_out1,clk, opr1, opr2, dest);
    
    P2: preg2
        port map(pc_out1, reg_file_write, mem_write, mem_data_select,
         opcode, complement, carry_zero_instruction,opr1, opr2, dest, 
         imm6, imm9, alub_mux1, alub_mux2, alua_mux_rr, imm_mux,lmsm_regmux, lmsm_destmux, sm_memmux ,flush_idor, 
         stall_idor, clk, rst, reg_file_write_out2, mem_write_out2, mem_data_select_out2,
         opcode_out2, complement_out2, carry_zero_instruction_out2, opr1_out2, opr2_out2, dest_out2, 
         imm6_out2, imm9_out2, alub_mux1_out2, alub_mux2_out2, alua_mux_rr_out2, imm_mux_out2,lmsm_regmux_out2,
			lmsm_destmux_out2 ,sm_memmux_out2, pc2_out);
        
    RF1 : Register_File
        port map (clk, rst, wbout5, pc2_out, opr1_out2, opr2_out2, dest_out2, dest_out5, reg_file_write_out5 ,rf_d1, rf_d2, rf_d4);

    M1rf: MUX2input
        port map(alua_mux_rr_out2, fwdrr1 , pc2_out, alu2a_input);
		  
	 Muxsm : MUX2input_1bit
			port map(sm_memmux_out2 , mem_write_out2 , mem_write_sm , mem_write_final);
	
    
    P3: preg3  
        port map(fwdrr2, pc2_out, flush_orex, stall_orex,dest_out2, reg_file_write_out2, 
        mem_write_final, mem_data_select_out2, alu2a_input, fwdrr2, regc_out2, opcode_out2,
        complement_out2, carry_zero_instruction_out2, imm6_out2, imm9_out2, alub_mux1_out2, 
        alub_mux2_out2, imm_mux_out2, lmsm_regmux_out2, lmsm_destmux_out2, clk, rst, rf_d2out3_s, pc_out3, dest_out3,  
        reg_file_write_out3, mem_write_out3, mem_data_select_out3, alu2a_out3, rf_d2out3, 
        rf_d4out3, opcode_out3, complement_out3, carry_zero_instruction_out3, imm6_out3, imm9_out3,
        alub_mux1_out3,alub_mux2_out3, imm_mux_out3, lmsm_regmux_out3, lmsm_destmux_out3);
    
	 M2lm : MUX2input_1bit
			port map(lmsm_regmux_out3 , reg_file_write_out3 , reg_write_lm , reg_write_final);
			
	 M3lm : MUX2input_3bit
			port map(lmsm_destmux_out3 , dest_out3 , counter_in , dest_final);
			
    E1: execution_block
        port map(rf_d2out3_s, pc_out3, dest_out3, reg_write_final, mem_write_out3, mem_data_select_out3,
        alu2a_out3, rf_d2out3, alub_mux1_out3, alub_mux2_out3, imm_mux_out3, rf_d4out3, complement_out3,
        carry_zero_instruction_out3, imm6_out3, imm9_out3 , opcode_out3, alub_lm_se, clk, rst , rfd2_in4, alu2_output,
        dest_final_p, reg_file_write_in4, mem_write_in4, opcode_in4, mem_data_select_in4 , alu3_out,alu2_out_mux);

    P4: preg4
        port map(rfd2_in4, dest_final, reg_file_write_in4, alu2_output, opcode_in4, mem_write_in4,
        flush_exmem,imm9_out3, clk, rst, mem_data_select_in4,imm9_out4, rf_d2out4, dest_out4, reg_file_write_out4, 
        alu2_outputout4, opcode_out4, mem_write_out4, mem_data_select_out4);
    
    DM: data_memory
        port map(rst, mem_write_out4, rf_d2out4,alu2_outputout4, mem_output);
    -- add imm
	 
	 se3 : Sign_extender_9digit
			port map(imm9_out4, imm9_out4_ext);
			
    M4pr: MUX4input
        port map(mem_data_select_out4, mem_output,imm9_out4_ext, alu2_outputout4 ,"0000000000000000" , wbout);

    P5: preg5
        port map(wbout, dest_out4, reg_file_write_out4, rst, clk, wbout5, dest_out5,
                reg_file_write_out5);
					 
	fr1 : forward_block_rr
        port map(rf_d1, rf_d2, opr1_out2, opr2_out2, alu2_output, wbout, wbout5, rf_d4, dest_out2, dest_out3,
        dest_out4, dest_out5, fwdrr1, fwdrr2 ,regc_out2);
		  
	ff1 : forward_block_IF
		  port map(forwdpcin , alu3_out ,alu2_out_mux , wbout ,wbout5 ,rf_d2out3, opcode_out3 , opcode_out4 ,
						dest_out3,dest_out4,dest_out5,forwdpcout);
				
	hs1 : hazard_stall_unit
		  port map( opcode_id ,opcode_out2,opcode_out3,opcode_out4,dest_out3,dest_out4,dest_out5,opr1_out2,
					opr2_out2,counter_in,alu2_out_mux,hazard_rst, stall_ifid, stall_idor,stall_orex,stallpc, flush_ifid ,flush_idor, 
					flush_orex, flush_exmem
		  );
   rfc1 : reset_for_counter
			port map(opcode_out2,opcode_out3,opcode_out4,dest_out3,dest_out4,stall_idor,flush_ifid,alu2_out_mux,reset_out1);
			
	c1 : counter_stall
			port map(reset_out1,clk,counter_in);
			
	c2 : hazard_counter
			port map(rst,clk,hazard_rst);
		
	lmsm : lm_sm_block
			port map(counter_in, imm9_out3, reg_write_lm , alub_lm);
			
	se4 : Sign_extender_9digit
		   port map(alub_lm, alub_lm_se);
	
	sm1 : sm_block
			port map(counter_in , imm9_out2 , mem_write_sm , rfd1_sm);

	
	
	opcode_id <= instruction_out1(15 downto 12); 
	wb_reg <= wbout5;
	process(clk)
	begin
	report "instruction "&integer'image(to_integer(unsigned(instruction)));
	report "instruction_reg "&integer'image(to_integer(unsigned(instruction_out1)));
	report "counterhazard "&integer'image(to_integer(unsigned(hazard_rst)));


	report "opr1 "&integer'image(to_integer(unsigned(opr1)));
	report "opr1_out2 "&integer'image(to_integer(unsigned(opr1_out2)));
	
	report "opr2 "&integer'image(to_integer(unsigned(opr2)));
	report "opr2_out2 "&integer'image(to_integer(unsigned(opr2_out2)));

	report "dest "&integer'image(to_integer(unsigned(dest)));
	report "dest_out2 "&integer'image(to_integer(unsigned(dest_out2)));
	
   report "opcode_mem "&integer'image(to_integer(unsigned(opcode_out4)));
	report "out_mem "&integer'image(to_integer(unsigned(wbout)));
	
   report "opcode_ex "&integer'image(to_integer(unsigned(opcode_out3)));
   report "opcode_rr "&integer'image(to_integer(unsigned(opcode_out2)));
   report "dest_out3 "&integer'image(to_integer(unsigned(dest_out3)));
   report "dest_out4 "&integer'image(to_integer(unsigned(dest_out4)));

	
   report "alu_out "&integer'image(to_integer(unsigned(alu2_output)));
	report "alu3_out "&integer'image(to_integer(unsigned(alu3_out)));

   report "counter "&integer'image(to_integer(unsigned(counter_in)));
	report "reset_out "&integer'image(to_integer(unsigned(reset_out1)));

	
	report "stallpc "&std_logic'image(((stallpc)));
	report "stallifid "&std_logic'image(((stall_ifid)));
	report "stallidor "&std_logic'image(((stall_idor)));
	report "stallorex "&std_logic'image(((stall_orex)));
   report "flushifid "&std_logic'image(((flush_ifid)));
   report "flushidor "&std_logic'image(((flush_idor)));
	
   report "flushorex "&std_logic'image(((flush_orex)));


	--report "mem_write "&std_logic'image(((mem_write_out4)));
	--report "address "&integer'image(to_integer(unsigned(alu2_outputout4)));
	report "data "&integer'image(to_integer(unsigned(rf_d2out4)));

	report "pc_regular "&integer'image(to_integer(unsigned(forwdpcin)));
	report "pc_imm "&integer'image(to_integer(unsigned(alu3_out)));
	report "out_ex "&integer'image(to_integer(unsigned(alu2_output)));
	report "out_mem "&integer'image(to_integer(unsigned(wbout)));
	report "out_wb "&integer'image(to_integer(unsigned(wbout5)));
	
	report "rfd1 "&integer'image(to_integer(unsigned(rf_d1)));
	report "rfd2 "&integer'image(to_integer(unsigned(rf_d2)));
	report "rfd4 "&integer'image(to_integer(unsigned(rf_d4)));
	

	report "alua_pipein "&integer'image(to_integer(unsigned(alu2a_input)));
	report "pcout1 "&integer'image(to_integer(unsigned(pc_out1)));
	report "pcinit "&integer'image(to_integer(unsigned(pc_init)));
	
	report "pc2out "&integer'image(to_integer(unsigned(pc2_out)));
	report "alua_mux_rr "&std_logic'image(((alua_mux_rr_out2)));
	
	report "alua_pipeout "&integer'image(to_integer(unsigned(alu2a_out3)));
	report "alub_pipein "&integer'image(to_integer(unsigned(fwdrr2)));
	report "alub_pipeout "&integer'image(to_integer(unsigned(rf_d2out3)));

	
	report "pc "&integer'image(to_integer(unsigned(forwdpcout)));
	report "alub_mux "&integer'image(to_integer(unsigned(alub_mux1)));
	report "alub_mux_o2 "&integer'image(to_integer(unsigned(alub_mux1_out2)));
	report "alub_mux_o3 "&integer'image(to_integer(unsigned(alub_mux1_out3)));
	

	report "wb "&integer'image(to_integer(unsigned(wbout5)));
	report "dest_wb "&integer'image(to_integer(unsigned(dest_out5)));
	report "regfile5 "&std_logic'image(((reg_file_write_out5)));

	end process;

            
end architecture bhv;