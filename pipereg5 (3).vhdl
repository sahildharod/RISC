library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity preg5 is

    port ( data_in : in std_logic_vector(15 downto 0);
           reg_add_in : in std_logic_vector(2 downto 0);
           reg_write_in: in std_logic;
           rst :in std_logic;
           clk : in std_logic;
           data_out : out std_logic_vector(15 downto 0);
           reg_add_out : out std_logic_vector(2 downto 0);
           reg_write_out: out std_logic 
        );

end entity preg5;

architecture p5bhev  of preg5 is
    signal data : std_logic_vector(15 downto 0):="0000000000000000";
    signal regadd : std_logic_vector(2 downto 0):="001";
    signal regwrite: std_logic:='0';
    
    begin
        data_out <= data;
        reg_add_out <= regadd;
        reg_write_out <= regwrite;
        process(clk,rst)
            begin  
                if ( rst = '1') then
                    data <= (others=>'0');
                    regadd <= "001";
                    regwrite <= '0';
                
                elsif(falling_edge(clk)) then 
                    data <= data_in;
                    regadd <= reg_add_in;
                    regwrite <= reg_write_in;
                end if;
        end process;

end architecture p5bhev;