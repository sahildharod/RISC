library ieee;
use ieee.std_logic_1164.all;

entity compliment_16bit is 

port	(input:in std_logic_vector(15 downto 0);	
		output: out std_logic_vector(15 downto 0));
		
end entity compliment_16bit;

architecture behav of compliment_16bit is
	begin
	output<=not input;
end architecture behav;