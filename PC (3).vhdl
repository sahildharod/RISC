library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
port(inputs:in std_logic_vector(15 downto 0);
stall_pc:in std_logic;
reset:in std_logic;
clk:in std_logic;
outputs:out std_logic_vector(15 downto 0));
end entity PC;

architecture behav of PC is
signal data: std_logic_vector(15 downto 0);
begin
outputs<=data;

process(inputs,stall_pc,reset,clk)
begin
report integer'image(to_integer(unsigned(data)));

	if(reset='1') then
		data<="0000000000000000";
		
	elsif(stall_pc='1') then
		data<=data;

	elsif(falling_edge(clk)) then
		data<=inputs;
	end if;
end process;
end architecture behav;