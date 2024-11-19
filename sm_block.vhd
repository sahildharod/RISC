library ieee;
use ieee.std_logic_1164.all;

entity sm_block is
	port(counter : in std_logic_vector(2 downto 0);
			imm9 : in std_logic_vector(8 downto 0);
			mem_write : out std_logic;
			rf_d1 : out std_logic_vector(2 downto 0));
end entity sm_block;

architecture bhv of sm_block is

signal zerobit:std_logic := '0';
signal onebit:std_logic := '0';
signal twobit:std_logic := '0';
signal threebit:std_logic := '0';
signal fourbit:std_logic := '0';
signal fivebit:std_logic := '0';
signal sixbit:std_logic := '0';
signal sevenbit:std_logic := '0';
signal data : std_logic_vector(8 downto 0);


begin
	data<=imm9;
	zerobit<=data(7);
	onebit<=data(6);
	twobit<=data(5);
	threebit<=data(4);
	fourbit<=data(3);
	fivebit<=data(2);
	sixbit<=data(1);
	sevenbit<=data(0);
	
process(counter)
begin
	if(counter="111") then
		mem_write <= sevenbit;
		rf_d1 <= counter;
	elsif(counter="110") then
		mem_write <= sixbit;
		rf_d1 <= counter;
	elsif(counter="101") then
		mem_write <= fivebit;
		rf_d1 <= counter;
	elsif(counter="100") then
		mem_write <= fourbit;
		rf_d1 <= counter;
	elsif(counter="011") then
		mem_write <= threebit;
		rf_d1 <= counter;
	elsif(counter="010") then
		mem_write <= twobit;
		rf_d1 <= counter;
	elsif(counter="001") then
		mem_write <= onebit;
		rf_d1 <= counter;
	elsif(counter = "000") then
		mem_write <= zerobit;
		rf_d1 <= counter;
	end if;
end process;

end architecture bhv;
		
		
	

	