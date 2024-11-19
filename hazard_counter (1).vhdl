library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity hazard_counter is
    Port ( rst,clk : in std_logic;
           output: out std_logic_vector(2 downto 0));
end hazard_counter;

architecture count_arch of hazard_counter is
   signal count : std_logic_vector(2 downto 0):="110";
    begin
      process(rst,clk)
        begin
          if (rst = '1') then
				count <= "101";
			 elsif(count="000")
				then count<="000";
          elsif (falling_edge(clk)) then count <= count - 1;
          end if;
         end process;
         output <= count;
      end count_arch;