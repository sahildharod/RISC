LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity one_bit_register is 
port(input:in std_logic;
	clk:in std_logic;
	reset:in std_logic;
	output: out std_logic) ;
end entity one_bit_register;

architecture behav of one_bit_register is
signal intermediate: std_logic;
	begin
	output<=intermediate;
	process(clk,reset)
	begin
		if (reset = '1') then
			intermediate<='0';
		elsif (falling_edge(clk)) then
			intermediate<=input;
		end if;
end process;
end architecture behav;