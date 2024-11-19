library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- lm sm mux
entity execution_block is
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
			  alu2_output_muxin : out std_logic_vector(15 downto 0)

			 
	);
end entity execution_block;

architecture bhv of execution_block is

component ex_out_block is
	port (
			rc : in std_logic_vector(15 downto 0);
			alu_c :  in std_logic_vector(15 downto 0);
			carry_zero_inst : in std_logic_vector(1 downto 0);
			carry,zero : in std_logic;
			opcode : in std_logic_vector(3 downto 0);
			alu_c_final : out std_logic_vector(15 downto 0)
	     );
end component ex_out_block;


component alu is 
	port ( alu_a : in std_logic_vector(15 downto 0);
			 alu_b : in std_logic_vector(15 downto 0);
			 alu_c : out std_logic_vector(15 downto 0);
			 carry,zero: in std_logic;
			 carry_zero_instruction: in std_logic_vector(1 downto 0);
			 carry_flag : out std_logic;
			 zero_flag : out std_logic;
			 opcode : in std_logic_vector(3 downto 0)
			);
			
end component alu;

component RippleCarryAdder is
	port(A,B: in std_logic_vector(15 downto 0);
		Cin: in std_logic;
		Carry: out std_logic;
		Sum: out std_logic_vector(15 downto 0)
		);
end component RippleCarryAdder;

component Sign_extender_6digit is
   port (Input_6bit: in std_logic_vector(5 downto 0); 
			Output_16bit: out std_logic_vector(15 downto 0));
end component Sign_extender_6digit;

component Sign_extender_9digit is
   port (Input_9bit: in std_logic_vector(8 downto 0); 
			Output_16bit: out std_logic_vector(15 downto 0));
end component Sign_extender_9digit;

component MUX4input is 
port(
		a:in std_logic_vector(1 downto 0);
		input0,input1,input2,input3: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0));
end component MUX4input; 

component MUX2input is 
port(
		add_line:in std_logic;
		input0,input1: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0));
end component MUX2input; 
 
component compliment_16bit is 
port	(input:in std_logic_vector(15 downto 0);	
		output: out std_logic_vector(15 downto 0));
end component compliment_16bit;

component one_bit_register is 
port(input:in std_logic;
	clk:in std_logic;
	reset:in std_logic;
	output: out std_logic) ;
end component one_bit_register;
 
component shifter is
	port (
			shift_in : in std_logic_vector(15 downto 0);
			shift_out : out std_logic_vector(15 downto 0)
			);
end component shifter;

component bit_adder is
port(
		input : in std_logic_vector(7 downto 0);
		output : out std_logic_vector(3 downto 0)
		);
end component bit_adder;

signal s1 : std_logic_vector(15 downto 0);
signal s2 : std_logic_vector(15 downto 0);
signal s3 : std_logic_vector(15 downto 0);
signal s4 : std_logic_vector(15 downto 0);
signal s5 : std_logic_vector(15 downto 0);
signal alu2_b_input : std_logic_vector(15 downto 0);
signal alu_zero :  std_logic;
signal alu_carry : std_logic;
signal carry_reg_out : std_logic;
signal zero_reg_out : std_logic;
signal alu2_out_signal : std_logic_vector(15 downto 0);
signal carry3 : std_logic;
signal alu2_out : std_logic_vector(15 downto 0);

begin
	process(clk)
	begin
	report "alu2_out"&integer'image(to_integer(unsigned(alu2_out_signal)));
	report "alu2_a"&integer'image(to_integer(unsigned(alu2_a)));
	report "alu2_b_input"&integer'image(to_integer(unsigned(alu2_b_input)));
	report "alub_mux_ex "&integer'image(to_integer(unsigned(alub_mux1)));
  	report "imm6 "&integer'image(to_integer(unsigned(s3)));
	report "imm_mux "&std_logic'image(((imm_mux)));
	report "imm_muxout "&integer'image(to_integer(unsigned(s5)));

	
   end process;

	r1 : one_bit_register port map(alu_zero ,clk,rst, zero_reg_out);
	r2 : one_bit_register port map(alu_carry ,clk,rst, carry_reg_out);
	m1 : MUX4input port map(alub_mux1,alu2_b,s3,s4,"0000000000000001",s1);
	se1 : Sign_extender_6digit port map(imm6,s3);
	se2 : Sign_extender_9digit port map(imm9,s4);
 	c1 : compliment_16bit port map(s1,s2);
	m2 : MUX4input port map(alub_mux2,s1,s2,alub_lmsm,"0000000000000000",alu2_b_input);
	a1 : alu port map(alu2_a , alu2_b_input ,alu2_out_signal,carry_reg_out,zero_reg_out,cz_flag_control,alu_carry,alu_zero,opcode);
	ex1 : ex_out_block port map(reg_c_data, alu2_out_signal,cz_flag_control, carry_reg_out , zero_reg_out , opcode , alu2_out);
	m3 : MUX2input port map(imm_mux,s3,s4,s5);
	
   alu3_out<=pc+s5;
	alu2_output_muxin <= alu2_out_signal;
	alu2_output <= alu2_out;
	opcode_out <= opcode;
	control_data_out <= control_data;
	store_data_out <= store_data_in;
	reg_add_out <= reg_add;
   reg_write_out <= reg_write;
   mem_write_out <= mem_write;
end architecture bhv;