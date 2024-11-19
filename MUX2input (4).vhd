library ieee;
use ieee.std_logic_1164.all;

entity MUX2input is 
port(
		add_line:in std_logic;
		input0,input1: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0));
end MUX2input; 
 
architecture Structure of MUX2input is
begin
	process(add_line,input1,input0)
	begin
	if (add_line ='1') then
		output<=input1;
	else
		output<=input0;
	end if;
	end process;
end Structure;
	