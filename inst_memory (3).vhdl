library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all; 
library ieee;
use ieee.numeric_std.all; 

entity inst_memory is

	port(rst : in std_logic ; 
         mem_address : in std_logic_vector(15 downto 0);
		mem_output : out std_logic_vector(15 downto 0));

end entity inst_memory;

architecture bhv of inst_memory is

	type ROM is array (0 to 127) of std_logic_vector(15 downto 0);
	signal instruction : ROM := (others => "0001001010011000");
	
	begin
	
		mem_output <= instruction(to_integer(unsigned(mem_address)));

		process(rst,mem_address)
		
			begin
				 for x in 0 to 1 loop
                report "inst"&integer'image(x)&" = "&integer'image(to_integer(unsigned(instruction(x))));
            end loop;
				if (rst = '1') then
					instruction(0) <= "0011001000000001"; --  
					instruction(1) <= "0011010000000010";-- 
					instruction(2) <= "0011011000000011"; -- 
					instruction(3) <= "0011100000000100"; -- 
					instruction(4) <= "0011101000000101"; -- NDU
					instruction(5) <= "0001001010011000"; -- 				   --instruction(6) <= ""; -- 
					--instruction(7) <= "0001001010011000"; -- 
--					instruction(8) <= "0100010011101000"; -- 
--					instruction(9) <= "0101010011101000"; -- SW
--					instruction(10) <= "0110010011101000"; -- LM
					--instruction(11) <= "0011110001000000"; -- SM
					--instruction(25) <= "0001101110111000"; -- BEQ
--					instruction(13) <= "1000010011101000"; -- JAL
--					instruction(14) <= "1001010011000000"; -- JLR
				end if;

		end process;

end architecture bhv;
	