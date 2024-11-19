library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.numeric_std.all;

entity bit_adder is
port(
		input : in std_logic_vector(8 downto 0);
		output : out std_logic_vector(3 downto 0)
		);
end bit_adder;

architecture behav of bit_adder is
signal b0,b1,b2,b3,b4,b5,b6,b7,b8,sum : integer := 0;
signal bit4 : integer := 4;
begin
b0 <=to_integer(unsigned(input(0 downto 0)));
b1 <=to_integer(unsigned(input(1 downto 1)));
b2 <=to_integer(unsigned(input(2 downto 2)));
b3 <=to_integer(unsigned(input(3 downto 3)));
b4 <=to_integer(unsigned(input(4 downto 4)));
b5 <=to_integer(unsigned(input(5 downto 5)));
b6 <=to_integer(unsigned(input(6 downto 6)));
b7 <=to_integer(unsigned(input(7 downto 7)));
b8 <=to_integer(unsigned(input(8 downto 8)));

sum <= b0+b1+b2+b3+b4+b5+b6+b7+b8;
output <= std_logic_vector(to_unsigned(sum,output'length));
end behav;