library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity preg4 is

    port ( store_data_in : in std_logic_vector(15 downto 0);
           reg_add_in : in std_logic_vector(2 downto 0);
           reg_write_in: in std_logic;
           mem_address_in: in std_logic_vector(15 downto 0);
			  opcode_in : in std_logic_vector(3 downto 0);
           mem_write_in: in std_logic;
			  flush_exmem : in std_logic;
			  imm9_in : in std_logic_vector(8 downto 0);
           clk : in std_logic;
           rst : in std_logic;
           control_data_in : in std_logic_vector(1 downto 0);
			  imm9_out : out std_logic_vector(8 downto 0);
           store_data_out : out std_logic_vector(15 downto 0);
           reg_add_out : out std_logic_vector(2 downto 0);
			  reg_write_out: out std_logic;
			  mem_address_out: out std_logic_vector(15 downto 0);
			  opcode_out : out std_logic_vector(3 downto 0);
           mem_write_out: out std_logic;
           control_data_out : out std_logic_vector(1 downto 0)
        );

end entity preg4;

architecture p4bhev  of preg4 is
    signal store_data : std_logic_vector(15 downto 0):="0000000000000000";
    signal regadd : std_logic_vector(2 downto 0):="001";
    signal regwrite : std_logic:='0';
    signal memadd : std_logic_vector(15 downto 0):="0000000000000000";
    signal memwrite : std_logic:='0';
    signal controldata : std_logic_vector(1 downto 0):="00";
	 signal opcode : std_logic_vector(3 downto 0):="0101";
	 signal imm9 : std_logic_vector(8 downto 0):="000000000";

    
    begin
        store_data_out <= store_data;
        reg_add_out <= regadd;
        reg_write_out <= regwrite;
        mem_address_out <= memadd;
        mem_write_out <= memwrite;
        control_data_out <= controldata;
		  opcode_out <= opcode;
		  imm9_out <= imm9;
        
        process(clk,rst)

            begin  
                if ( rst = '1') then
                    store_data <= (others=>'0');
                    regadd <= "001";
                    regwrite <= '0';
                    memadd <= (others=>'0');
                    memwrite <= '0';
                    controldata <= (others => '0');
						  imm9 <= (others => '0');


                 elsif(falling_edge(clk)) then 
						 if(flush_exmem = '1') then
							store_data <= (others=>'0');
                     regadd <= "001";
                     regwrite <= '0';
                     memadd <= (others=>'0');
                     memwrite <= '0';
                     controldata <= (others => '0');
							imm9 <= (others => '0');
						else
                    store_data <= store_data_in;
                    regadd <= reg_add_in;
                    regwrite <= reg_write_in;
                    memadd <= mem_address_in;
                    memwrite <= mem_write_in;
                    controldata <= control_data_in;
						  opcode <= opcode_in;
						  imm9 <= imm9_in;
						 end if;
                end if;
        end process;
        
end architecture p4bhev;
