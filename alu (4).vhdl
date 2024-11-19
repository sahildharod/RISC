	library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use ieee.NUMERIC_STD.all;



entity Full_Adder is
   port (A,B,Cin: in std_logic; Sum, Carry: out std_logic);
end entity Full_Adder;

architecture Struct of Full_Adder is
begin
   Sum <= (A xor B xor Cin);
   Carry <= ((A and B) or (Cin and(A xor B)));
end architecture Struct;

  
library ieee;
use ieee.std_logic_1164.all;

entity RippleCarryAdder is

port(A,B: in std_logic_vector(15 downto 0);
		Cin: in std_logic;
		Sum: out std_logic_vector(15 downto 0);
		Carry: out std_logic);
		
end entity RippleCarryAdder;

architecture Struct of RippleCarryAdder is
	component Full_Adder is
		port (A,B,Cin: in std_logic; Carry: out std_logic ; Sum : out std_logic);
	end component Full_Adder;
	
	signal cinter:std_logic_vector(15 downto 0) ;
	
begin
    
	N1: Full_Adder port map(A(0), B(0),Cin,cinter(1),Sum(0));
	N2: Full_Adder port map(A(1), B(1),cinter(1),cinter(2),Sum(1));
	N3: Full_Adder port map(A(2), B(2),cinter(2),cinter(3),Sum(2));
	N4: Full_Adder port map(A(3), B(3),cinter(3),cinter(4),Sum(3));
	N5: Full_Adder port map(A(4), B(4),cinter(4),cinter(5),Sum(4));
	N6: Full_Adder port map(A(5), B(5),cinter(5),cinter(6),Sum(5));
	N7: Full_Adder port map(A(6), B(6),cinter(6),cinter(7),Sum(6));
	N8: Full_Adder port map(A(7), B(7),cinter(7),cinter(8),Sum(7));
	N9: Full_Adder port map(A(8), B(8),cinter(8),cinter(9),Sum(8));
	N10: Full_Adder port map(A(9), B(9),cinter(9),cinter(10),Sum(9));
	N11: Full_Adder port map(A(10), B(10),cinter(10),cinter(11),Sum(10));
	N12: Full_Adder port map(A(11), B(11),cinter(11),cinter(12),Sum(11));
	N13: Full_Adder port map(A(12), B(12),cinter(12),cinter(13),Sum(12));
	N14: Full_Adder port map(A(13), B(13),cinter(13),cinter(14),Sum(13));
	N15: Full_Adder port map(A(14), B(14),cinter(14),cinter(15),Sum(14));
	N16: Full_Adder port map(A(15), B(15),cinter(15),carry,Sum(15));
	
end architecture Struct;

library ieee;
use ieee.std_logic_1164.all;

entity Sign_extender_6digit is
   port (Input_6bit: in std_logic_vector(5 downto 0); Output_16bit: out std_logic_vector(15 downto 0));
end entity Sign_extender_6digit;

architecture Struct of Sign_extender_6digit is
begin
process(input_6bit)
begin
if (Input_6bit(5) = '0') then
	Output_16bit<="0000000000" & Input_6bit;
elsif (Input_6bit(5) = '1') then
	Output_16bit<= "1111111111" & Input_6bit;
end if;
end process;

end architecture Struct;

library ieee;
use ieee.std_logic_1164.all;--

entity Sign_extender_9digit is
   port (Input_9bit: in std_logic_vector(8 downto 0); Output_16bit: out std_logic_vector(15 downto 0));
end entity Sign_extender_9digit;

architecture Struct of Sign_extender_9digit is
begin
process(input_9bit)
begin
if (Input_9bit(8) = '0') then
	Output_16bit <= "0000000" & Input_9bit;
elsif (Input_9bit(8) = '1') then
	Output_16bit<= "1111111" & Input_9bit;
end if;
end process;
	
end architecture Struct;


	library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use ieee.NUMERIC_STD.all;

entity alu is 
	port ( alu_a : in std_logic_vector(15 downto 0);
			 alu_b : in std_logic_vector(15 downto 0);
			 carry,zero: in std_logic;
			 carry_zero_instruction: in std_logic_vector(1 downto 0);
			 opcode : in std_logic_vector(3 downto 0);
			  alu_c : out std_logic_vector(15 downto 0);
			 carry_flag : out std_logic;
			 zero_flag : out std_logic
			);
end entity alu;

architecture behav of alu is
	component RippleCarryAdder is

	port(A,B: in std_logic_vector(15 downto 0);
		Cin: in std_logic;
		Sum: out std_logic_vector(15 downto 0);
		Carry: out std_logic);
		
	end component RippleCarryAdder;

signal output_add_with_carry: std_logic_vector(15 downto 0) := "0000000000000000";
signal output_add_without_carry: std_logic_vector(15 downto 0) := "0000000000000000";
signal output: std_logic_vector(15 downto 0) := "0000000000000000";
signal carry_output_with_carry: std_logic := '0';
signal carry_output_without_carry: std_logic := '0';

signal zero_output: std_logic := '0';
	
	begin 
	c1 : 	RippleCarryAdder port map(alu_a,alu_b,carry,output_add_with_carry,carry_output_with_carry);
	c2 : 	RippleCarryAdder port map(alu_a,alu_b,'0',output_add_without_carry,carry_output_without_carry);

	process (alu_a ,alu_b,opcode,carry_zero_instruction)
	begin
		if (opcode = "0000" or opcode = "0001")
			then
				if(carry_zero_instruction(0) = '1' and carry_zero_instruction(1) = '1') then
					output<=alu_a + alu_b + ("000000000000000" & carry);
				else 
					output<=alu_a + alu_b;
				end if;
			
			

		elsif (opcode = "0010")
			then
				output <= alu_a nand alu_b;
				
		
		elsif(opcode = "1000") then
			if(unsigned(alu_a)=unsigned(alu_b)) then
				output<="1111111111111111";
			else
				output<="0000000000000000";
			end if;
		
		elsif (opcode = "1001") then
			if(signed(alu_a) < signed(alu_b)) then
				output<="1111111111111111";
			else
				output<="0000000000000000";
			end if;
		
		
		elsif(opcode="1010") then
			if(signed(alu_a)<signed(alu_b)) then
				output<="1111111111111111";
			elsif(unsigned(alu_a)=unsigned(alu_b)) then
				output<="1111111111111111";
			else
				output<="0000000000000000";

			end if;
			
			
		elsif(opcode="0100" or opcode="0101") then
			output<=alu_a + alu_b;
		elsif(opcode="0110" or opcode="0111") then
			 output<=alu_a + alu_b;
			 
		else
			output<=alu_a + alu_b;
		end if;
		end process;
			
			
		process(output ,carry_output_with_carry , carry_output_without_carry )
		begin
			if (opcode = "0000" or opcode = "0001") then
				alu_c<=output;
				carry_flag<=carry_output_with_carry;
				
				if(output ="0000000000000000") then
						zero_flag<='1';
				else 
					   zero_flag<='0';
				end if;
				

			elsif (opcode = "0010") then
				alu_c<=output;
				carry_flag<=carry;
				if(output = "0000000000000000")
					then 
						zero_flag <= '1';
				else
					zero_flag<='0';
				end if;
			elsif(opcode="0100" or opcode="0101") then
				alu_c<=output;
				carry_flag<=carry;
				zero_flag<=zero;
			elsif(opcode="1000" or opcode="1001" or opcode="1010") then
				alu_c<=output;
				carry_flag<=carry;
				zero_flag<=zero;
			else
				alu_c<=output;
				carry_flag<=carry;
				zero_flag<=zero;
			end if;
		end process;
		end behav;