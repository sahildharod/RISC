library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity forward_block_rr is
port(ra_content,rb_content:in std_logic_vector(15 downto 0);
		ra_address_rr,rb_address_rr:in std_logic_vector(2 downto 0);
		modified_ex,modified_mem,modified_wb:in std_logic_vector(15 downto 0);
		--garbage_or_not:in std_logic;
		rf_d4 : in std_logic_vector(15 downto 0);
		rd_address_rr : in std_logic_vector(2 downto 0);
		rd_ex,rd_mem,rd_wb:in std_logic_vector(2 downto 0);
		output_a,output_b:out std_logic_vector(15 downto 0);
		regc_out : out std_logic_vector(15 downto 0));
	end entity forward_block_rr;
	
architecture behav of forward_block_rr is
begin 
process(ra_address_rr,rb_address_rr,ra_content,rb_content,modified_ex,modified_mem,modified_wb,rd_ex,rd_mem,rd_wb)
begin
	if ((unsigned(ra_address_rr)=unsigned(rd_mem)))then
		output_a<=modified_mem;
	elsif ((unsigned(ra_address_rr)=unsigned(rd_ex))) then
		output_a<=modified_ex;
	elsif ((unsigned(ra_address_rr)=unsigned(rd_wb))) then
		output_a<=modified_wb;
	else 
		output_a<=ra_content;
end if;

if ((unsigned(rd_address_rr)=unsigned(rd_mem)))then
		regc_out<=modified_mem;
	elsif ((unsigned(rd_address_rr)=unsigned(rd_ex))) then
		regc_out<=modified_ex;
	elsif ((unsigned(rd_address_rr)=unsigned(rd_wb))) then
		regc_out<=modified_wb;
	else 
		regc_out<=rf_d4;
end if;

if((unsigned(rb_address_rr)=unsigned(rd_mem)))then
output_b<=modified_mem;
elsif ((unsigned(rb_address_rr)=unsigned(rd_ex))) then
output_b<=modified_ex;
elsif ((unsigned(rb_address_rr)=unsigned(rd_wb))) then
output_b<=modified_wb;
else 
output_b<=rb_content;
end if;
end process;
end architecture behav;