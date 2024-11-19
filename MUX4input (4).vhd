library ieee;
use ieee.std_logic_1164.all;

entity MUX4input is 
port(
		a:in std_logic_vector(1 downto 0);
		input0,input1,input2,input3: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0));
end MUX4input; 
 
architecture Structure of MUX4input is
signal data : std_logic_vector(15 downto 0);
begin
	process(a,input0,input1,input2,input3)
	begin
	if (a(0) ='1' and a(1) ='1') then
		output<=input3;
	elsif(a(0) ='0' and a(1) ='1') then
		output<=input2;
	elsif (a(0) ='1' and a(1) ='0') then
		output<=input1;
	else
		output<=input0;
	
	end if;
	end process;
end Structure;
	