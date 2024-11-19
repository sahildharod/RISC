library ieee;
use ieee.std_logic_1164.all;
-- recheck file
entity register_decoder is
	port(inst : in std_logic_vector(15 downto 0);
		  clk : in std_logic;
		  opr1 : out std_logic_vector(2 downto 0);
		  opr2 : out std_logic_vector(2 downto 0);
		  dest : out std_logic_vector(2 downto 0)
	);
end entity register_decoder;

architecture bhv of register_decoder is
signal opcode : std_logic_vector(3 downto 0);

	begin
	opcode <= inst(15 downto 12);
	
		process(inst,clk)
		begin
			if (opcode = "0001" or opcode = "0010") then
				opr1 <= inst(11 downto 9);
				opr2 <= inst(8 downto 6);
				dest <= inst(5 downto 3);
			elsif( opcode = "0000" ) then
				opr1 <= inst(11 downto 9);
				opr2 <= "001";
				dest <= inst(8 downto 6);
			elsif( opcode = "0100") then
				opr1 <= inst(8 downto 6);
				dest <= inst(11 downto 9);
				opr2 <=  "001";
			elsif( opcode= "0011") then
				opr1 <= "001";
				opr2 <= "001";
				dest <= inst(11 downto 9);
			elsif( opcode = "0101" or opcode = "1000" or opcode = "1001" or opcode = "1010") then
				opr1 <= inst(8 downto 6);
				opr2 <= inst(11 downto 9);
				dest <= "001";
			elsif(opcode = "1100") then
				opr1 <= "001";
				opr2 <= "001";
				dest <= inst(11 downto 9);
			elsif( opcode = "1101") then
				opr2 <= inst(8 downto 6);
				opr1 <= "001";
				dest <= inst(11 downto 9);
			elsif( opcode = "1111") then
				opr1 <= inst(11 downto 9);
				opr2 <= "001";
				dest <= "001";
			elsif(opcode = "0110" or opcode = "0111") then
				opr1 <= inst(11 downto 9);
				opr2 <= "001";
				dest <= "001";
				
			end if;
	end process;	
end architecture bhv;

