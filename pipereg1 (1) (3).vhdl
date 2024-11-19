library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity preg1 is
    port (  pc_in : in std_logic_vector(15 downto 0);
            instruction_in : in std_logic_vector(15 downto 0);
				flush_ifid : in std_logic;
				stall_ifid : in std_logic;
				rst : in std_logic;
				clk : in std_logic;
            pc_out : out std_logic_vector(15 downto 0);
            instruction_out : out std_logic_vector(15 downto 0)          
        );
end entity preg1;

architecture p1bhev of preg1 is
    signal pc : std_logic_vector(15 downto 0):="0000000000000000";
    signal instruction : std_logic_vector(15 downto 0):="0011010000000011";

    begin
        pc_out <= pc;
        instruction_out <= instruction;
        process(clk,rst)
            begin
                if ( rst = '1') then
                    pc <= (others => '0');
                    instruction <= "0011010000000011";
					 
					 elsif(flush_ifid = '1' ) then
							pc <= (others => '0');
						   instruction <=  "0011010000000011";
					 elsif(stall_ifid = '1') then
							pc <= pc;
							instruction <= instruction;
					 elsif(falling_edge(clk)) then
                     pc <= pc_in;
                     instruction <= instruction_in;
--              end if;
				end if;
        end process;
        
end architecture p1bhev;



