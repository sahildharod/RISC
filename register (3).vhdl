library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 


entity Register_File is    
  port(

      clk,rst : in std_logic;
		rf_d3 : in std_logic_vector(15 downto 0); 
		pc_rr : in std_logic_vector(15 downto 0);
		----------- address lines of mux, basically we are reading values of 3 registers A,B and C
	  	rf_a1 : in std_logic_vector(2 downto 0);
		rf_a2 : in std_logic_vector(2 downto 0);
		rf_a4 : in std_logic_vector(2 downto 0);
		----------- tells the address of the register to which we have to write in the data
		rf_a3 : in std_logic_vector(2 downto 0);
		----------- control variabe for registers
		rf_write : in std_logic;
		rf_d1 : out std_logic_vector(15 downto 0);
		rf_d2 : out std_logic_vector(15 downto 0);
		rf_d4 : out std_logic_vector(15 downto 0)
		);
		

end entity;

architecture behave of Register_File is

type reg_file is array (0 to 7) of std_logic_vector(15 downto 0);
signal data : reg_file := (others => "0000000000000000" ) ;  
signal rf_a11 : std_logic_vector(2 downto 0) := "000";
signal rf_a22 : std_logic_vector(2 downto 0) := "000";
signal rf_a44 : std_logic_vector(2 downto 0) := "000";         

begin
	rf_a11 <= rf_a1;
	rf_a22 <= rf_a2;
	rf_a44 <= rf_a4;
	data(0) <= pc_rr;


	
	rf_d1 <= data(to_integer(unsigned(rf_a11)));
	rf_d2 <= data(to_integer(unsigned(rf_a22)));
	rf_d4 <= data(to_integer(unsigned(rf_a44)));     
	process(clk,rst)

        begin 
					
            for x in 0 to 7 loop
                report "reg"&integer'image(x)&" = "&integer'image(to_integer(unsigned(data(x))));
            end loop;
            if ( rst = '1') then
--                data(0) <= "0000000000000000";
                data(1) <= "0000000000000000";
                data(2) <= "0000000000000000";
                data(3) <= "0000000000000000";
                data(4) <= "0000000000000000";
                data(5) <= "0000000000000000";
                data(6) <= "0000000000000000";
                data(7) <= "0000000010000000";

            elsif(falling_edge(clk)) then
                if(rf_write = '1') then
						if(unsigned(rf_a3) > 0) then
							if(rf_a3 = "001") then
								data(1) <= rf_d3;
							elsif(rf_a3 = "010") then
								data(2) <= rf_d3;
							elsif(rf_a3 = "011") then
								data(3) <= rf_d3;
							elsif(rf_a3 = "100") then
								data(4) <= rf_d3;
							elsif(rf_a3 = "101") then
								data(5) <= rf_d3;
							elsif(rf_a3 = "110") then
								data(6) <= rf_d3;
							elsif(rf_a3 = "111") then
								data(7) <= rf_d3;
							end if;
						 end if;
                end if;
            end if;
       
	end process;
end behave;
