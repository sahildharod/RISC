library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all; 
library ieee;
use ieee.numeric_std.all; 

entity data_memory is

	port(rst , mem_write: in std_logic ; 
        mem_input , mem_address : in std_logic_vector(15 downto 0);
		mem_output : out std_logic_vector(15 downto 0));

end entity data_memory;

architecture bhv of data_memory is

	type RAM is array (0 to 127) of std_logic_vector(15 downto 0);
	signal data : RAM := (0 => "1111111111111111",
								 1 => "0000000111111111",
								 2 => "0000000000011111",
								 others => "0000000000000000");
	
	begin
		mem_output <= data(to_integer(unsigned(mem_address)));

		process(rst,mem_write,mem_input,mem_address)
		
			begin

				if (rst = '1') then
					data <= (0 => "1111111111111111",
								 1 => "0000000111111111",
								 2 => "0000000000011111",
								 others => "0000000000000000");
				else
					data <= data;
				end if;

				if(mem_write = '1') then
					data(to_integer(unsigned(mem_address))) <= mem_input;
				else 
					data <= data;
				end if;
				

		end process;

end architecture bhv;
	