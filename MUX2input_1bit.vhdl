library ieee;
use ieee.std_logic_1164.all;

entity MUX2input_1bit is 
port(
		add_line:in std_logic;
		input0,input1: in std_logic;
		output: out std_logic);
end MUX2input_1bit; 
 
architecture Structure1 of MUX2input_1bit is
begin
	process(add_line,input1,input0)
	begin
	if (add_line ='1') then
		output<=input1;
	else
		output<=input0;
	end if;
	end process;
end Structure1;
	
library ieee;
use ieee.std_logic_1164.all;

entity MUX2input_3bit is 
port(
		add_line:in std_logic;
		input0,input1: in std_logic_vector(2 downto 0);
		output: out std_logic_vector(2 downto 0));
end MUX2input_3bit; 
 
architecture Structure2 of MUX2input_3bit is
begin
	process(add_line,input1,input0)
	begin
	if (add_line ='1') then
		output<=input1;
	else
		output<=input0;
	end if;
	end process;
end Structure2;
	