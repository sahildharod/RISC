library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hazard_stall_unit is
port(opcode_id,opcode_rr,opcode_ex,opcode_mem:in std_logic_vector(3 downto 0);
rd_ex,rd_mem,rd_wb,ra_rr,rb_rr:in std_logic_vector(2 downto 0);
counter:in std_logic_vector(2 downto 0);
output_ex:in std_logic_vector(15 downto 0);
hazard_reset : in std_logic_vector(2 downto 0);
stall_ifid,stall_idrr,stall_rrex,stall_pc:out std_logic;
flush_ifid,flush_idrr,flush_rrex,flush_exmem:out std_logic);
end entity hazard_stall_unit;

architecture behav of hazard_stall_unit is

begin
process(rd_ex,rd_mem,rd_wb,opcode_id,opcode_rr,opcode_ex,opcode_mem,counter,output_ex,ra_rr,rb_rr,hazard_reset)
begin 

if(hazard_reset = "000") then

	if(opcode_rr="0111") then
	if(counter="000") then
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
	else
			stall_ifid<='1';
			stall_idrr<='1';
			stall_rrex<='0';
			
			stall_pc<='1';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
	end if;
	
	elsif(opcode_ex="0110") then
		if(counter="000") then
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
		else
			stall_ifid<='1';
			stall_idrr<='1';
			stall_rrex<='1';
			
			stall_pc<='1';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
		end if;
	elsif (opcode_ex="0011" or opcode_ex="0100") then
		if(opcode_rr="0001" or opcode_rr="0000" or opcode_rr="0010" or opcode_rr="0101" or opcode_rr="1000" or opcode_rr="1001" or opcode_rr="1010") then
			if(ra_rr=rd_ex or rb_rr =rd_ex ) then
				if(unsigned(counter) > 0) then
				stall_ifid <='1';
				stall_idrr <='1';
				stall_rrex <='1';
				stall_pc<='1';
				flush_ifid<='0';
				flush_idrr<='0';
				flush_rrex<='0';
				flush_exmem<='0';
			else
				stall_ifid<='0';
				stall_idrr<='0';
				stall_rrex<='0';
				stall_pc<='0';
				flush_ifid<='0';
				flush_idrr<='0';
				flush_rrex<='0';
				flush_exmem<='0';
			end if;

		else
				stall_ifid<='0';
				stall_idrr<='0';
				stall_rrex<='0';
				stall_pc<='0';
				flush_ifid<='0';
				flush_idrr<='0';
				flush_rrex<='0';
				flush_exmem<='0';
		end if;
	elsif(opcode_rr="1101" or opcode_rr="1111") then
		if(ra_rr=rd_ex or rb_rr =rd_ex) then
			if(unsigned(counter) > 0) then
				stall_ifid <='1';
				stall_idrr <='1';
				stall_rrex <='1';
				stall_pc<='1';
				flush_ifid<='0';
				flush_idrr<='0';
				flush_rrex<='0';
				flush_exmem<='0';
			else
				stall_ifid<='0';
				stall_idrr<='0';
				stall_rrex<='0';
				stall_pc<='0';
				flush_ifid<='0';
				flush_idrr<='0';
				flush_rrex<='0';
				flush_exmem<='0';
			end if;
		else
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
		end if;
	else 
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
	end if;
 
elsif(opcode_ex="1000" or opcode_ex="1001" or opcode_ex="1010") then
	if (output_ex="1111111111111111") then
		if(unsigned(counter)>0) then
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='1';
			flush_idrr<='1';
			flush_rrex<='0'; --- test doubtful
			flush_exmem<='0';
	else 
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
	end if;
	else 
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
	end if;

elsif(opcode_ex="1100" or opcode_ex="1101" or opcode_ex="1111") then
	if(unsigned(counter)>0) then		
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='1';
			flush_idrr<='1';
			flush_rrex<='1';
			flush_exmem<='0';
	else
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
	end if;
			

 elsif(opcode_ex="0000" or opcode_ex="0001" or opcode_ex="0010") then
	if(rd_ex="000") then
		if(unsigned(counter)>0) then
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='1';
			flush_idrr<='1';
			flush_rrex<='1';
			flush_exmem<='0';
		else
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
		end if;
	else	
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
	end if;
elsif(opcode_mem="0011" or opcode_mem="0100") then
	if(rd_mem="000") then
		if(unsigned(counter)>0) then
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='1';
			flush_idrr<='1';
			flush_rrex<='1';
			flush_exmem<='1';
	-- flush is synchronous reset
		else	
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
		end if;
	else
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
	end if;

  else 
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
  end if;
else
			stall_ifid<='0';
			stall_idrr<='0';
			stall_rrex<='0';
			
			stall_pc<='0';
			flush_ifid<='0';
			flush_idrr<='0';
			flush_rrex<='0';
			flush_exmem<='0';
end if;
end process;
end architecture behav;