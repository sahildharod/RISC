library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity reset_for_counter is 
port(opcode,opcode_ex,opcode_mem:in std_Logic_vector(3 downto 0);
		rd_ex,rd_mem : in std_logic_vector(2 downto 0);
		stall: in std_logic;
		flush_ifid : in std_logic;
		output_ex : in std_logic_vector(15 downto 0);
		reset_out:out std_logic_vector(1 downto 0));
end entity reset_for_counter;


architecture behav of reset_for_counter is
begin
process(opcode,opcode_ex,opcode_mem,stall,flush_ifid)
begin
	if (opcode_ex ="0110" ) then -- stall at ex stage
		if (unsigned(opcode_ex) = unsigned(opcode_mem)) then
			reset_out<="00";
		else
			reset_out <= "11";
		end if;
	elsif (opcode ="0111") then -- stall at rr stage
		if (unsigned(opcode_ex) = unsigned(opcode)) then
			reset_out<="00";
		else
			reset_out <= "11";
		end if;
   elsif(stall = '1') then
			reset_out <= "00";
	elsif(opcode = "0000" or opcode = "0001" or opcode = "0010" or opcode = "0101" or opcode = "1000" or opcode = "1001" or opcode = "1010" or opcode = "1101" or opcode = "1111") then
		if ((unsigned(opcode_ex) = unsigned(opcode_mem)) and (unsigned(rd_ex) = unsigned(rd_mem))) then
			reset_out <="00";
		else 
			reset_out <= "01";
		end if;
	

	elsif(flush_ifid='1') then --- recheck
		reset_out<="00";
	elsif(opcode_ex="1000" or opcode_ex="1001" or opcode_ex="1010") then
		if (output_ex="1111111111111111") then
			reset_out<="01";
		else 
			reset_out<="00";
		end if;
	elsif(opcode_ex="1100" or opcode_ex="1101" or opcode_ex="1111") then
		reset_out<="01";
	elsif(opcode_ex="0000" or opcode_ex="0001" or opcode_ex="0010") then
		if(rd_ex="000") then
			reset_out<="01";
		else 
			reset_out<="00";
		end if;
	elsif(opcode_mem="0011" or opcode_mem="0100") then
		if(rd_mem="000") then
			reset_out<="01";
		else 
			reset_out<="00";
		end if;
	
	else
			reset_out<="00";
	end if;
end process;
end architecture behav;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 


entity counter_stall is
port (reset_for_counter1: in std_logic_vector(1 downto 0);
		clk:in std_logic;
		counter_out:out std_logic_vector(2 downto 0));
end entity counter_stall;

architecture bhv of counter_stall is
signal count:integer:=0;
begin
counter_out<=std_logic_vector(to_unsigned(count,3));
process(reset_for_counter1,clk)
begin
if(reset_for_counter1="11") then
	count<=7;
elsif(reset_for_counter1="01") then
 count <= 1;
elsif(falling_edge(clk)) then
	if(count>0) then
		count<=count-1;
	elsif(count = 0) then
		count<=0;
	else
		count<=0;		
	end if;
else
	count<=count;
end if;
end process;
end architecture bhv;