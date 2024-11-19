--Making 1 bit one;history table/correlation vaala bologe toh bana dunga ..or if something new toh vo bhi sochke bana sakta
entity branch_predictor is 
port(PC_regular,PC_Imm:in std_logic_vector(15 downto 0);
		taken_or_not:std_logic_vector;
		PC_out:out std_logic_vector(15 downto 0));
end entity branch_predictor;

architecture behav of branch_predictor is
signal hist:std_logic:='1';
signal predict:std_logic_vector(15 downto 0);

begin 
process(PC_regular,PC_Imm)
begin
if (hist='1') then
predict<=PC_Imm;
else
predict<=PC_regular;
end if;
end process;

process(taken_or_not)
begin
if(hist='1' and taken_or_not='1') then
hist='1';
elsif(hist='1' and taken_or_not='0') then
hist='0';
elsif(hist='0' and taken_or_not='1') then
hist='1';
else
hist='0';
end if;
end process;

process(predict)
begin
PC_out<=predict;
end process;
end architecture branch_predictor;
