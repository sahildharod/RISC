library ieee;
use ieee.std_logic_1164.all;


entity lm_sm_block is
 port(counter:in std_logic_vector(2 downto 0);
		immediate:in std_logic_vector(8 downto 0);
	 	reg_write_lm: out std_logic;
		alub_input : out std_logic_vector(8 downto 0));
end entity lm_sm_block;		

architecture behav of lm_sm_block is

component bit_adder is
port(
		input : in std_logic_vector(8 downto 0);
		output : out std_logic_vector(3 downto 0)
		);
end component bit_adder;

signal zerobit:std_logic := '0';
signal onebit:std_logic := '0';
signal twobit:std_logic := '0';
signal threebit:std_logic := '0';
signal fourbit:std_logic := '0';
signal fivebit:std_logic := '0';
signal sixbit:std_logic := '0';
signal sevenbit:std_logic := '0';
signal onebitadderin : std_logic_vector(8 downto 0) := "000000000";
signal onebitadderout : std_logic_vector(3 downto 0) := "0000";
signal data : std_logic_vector(8 downto 0) := "000000000";  

begin

oba1 : bit_adder port map(onebitadderin , onebitadderout);

	data<=immediate;
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
	if(counter="000") then
		reg_write_lm <= zerobit;
		onebitadderin <= "0" & data(7 downto 0);
		alub_input <= "00000" & onebitadderout;
		
	elsif(counter="001") then
		reg_write_lm<=onebit;
		onebitadderin	<= "00" & data(6 downto 0);
		alub_input <= "00000" & onebitadderout;

	elsif(counter="010") then
		reg_write_lm<=twobit;
		onebitadderin <= "000" & data(5 downto 0);
		alub_input <= "00000" & onebitadderout;
	
	elsif(counter="011") then
		reg_write_lm<=threebit;
		onebitadderin <= "0000" & data(4 downto 0);
		alub_input <= "00000" & onebitadderout;
	
	elsif(counter="100") then
		reg_write_lm<=fourbit;
		onebitadderin <= "00000" & data(3 downto 0);
		alub_input <= "00000" & onebitadderout;

	elsif(counter="101") then
		reg_write_lm<=fivebit;
		onebitadderin <= "000000" & data(2 downto 0);
	elsif(counter="110") then
		reg_write_lm<=sixbit;
		onebitadderin <= "0000000" & data(1 downto 0);
		alub_input <= "00000" & onebitadderout;

	elsif(counter="111") then
		reg_write_lm<=sevenbit;
		onebitadderin <= "00000000" & data(0);
		alub_input <= "00000" & onebitadderout;

	end if;
end process;
end architecture behav;