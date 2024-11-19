-- A DUT entity is used to wrap your design so that we can combine it with testbench.
-- This example shows how you can do this for the OR Gate

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
    port(input_vector: in std_logic_vector(1 downto 0);
			output_vector: out std_logic_vector(15 downto 0)
       	);
end entity;

architecture DutWrap of DUT is
  component main is
    port(rst : in std_logic;
         clk : in std_logic;
			wb_reg : out std_logic_vector(15 downto 0));
  end component main;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: main 
			port map (
				   rst => input_vector(1),
					clk => input_vector(0),
					wb_reg(0) => output_vector(0),
					wb_reg(1) => output_vector(1),
					wb_reg(2) => output_vector(2),
					wb_reg(3) => output_vector(3),
					wb_reg(4) => output_vector(4),
					wb_reg(5) => output_vector(5),
					wb_reg(6) => output_vector(6),
					wb_reg(7) => output_vector(7),
					wb_reg(8) => output_vector(8),
					wb_reg(9) => output_vector(9),
					wb_reg(10) => output_vector(10),
					wb_reg(11) => output_vector(11),
					wb_reg(12) => output_vector(12),
					wb_reg(13) => output_vector(13),
					wb_reg(14) => output_vector(14),
					wb_reg(15) => output_vector(15)

				);
end DutWrap;