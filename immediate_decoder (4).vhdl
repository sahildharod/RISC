library ieee;
use ieee.std_logic_1164.all;

entity immediate_decoder is
	port(instruction: in std_logic_vector(15 downto 0);
		clk : in std_logic;
		imm6:out std_logic_vector(5 downto 0);
		imm9:out std_logic_vector(8 downto 0));
end entity immediate_decoder;
		
		
architecture behav of immediate_decoder is
begin
	imm6<=instruction(5 downto 0);
	imm9<=instruction(8 downto 0);
end architecture behav;