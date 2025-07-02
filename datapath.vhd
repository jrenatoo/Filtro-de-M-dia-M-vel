library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
    port(CLK, RST, SHIFT_EN : in  std_logic;
			DATA_IN : in  std_logic_vector(7 downto 0);
			DATA_OUT : out std_logic_vector(7 downto 0));
end entity datapath;

architecture rtl of datapath is
    signal sample_0 : std_logic_vector(7 downto 0) := (others => '0');
    signal sample_1 : std_logic_vector(7 downto 0) := (others => '0');
    signal sample_2 : std_logic_vector(7 downto 0) := (others => '0');
    signal sample_3 : std_logic_vector(7 downto 0) := (others => '0');

    signal sum_stage1_a : unsigned(8 downto 0);
    signal sum_stage1_b : unsigned(8 downto 0);
    signal sum_total : unsigned(9 downto 0);
    
    signal average : std_logic_vector(7 downto 0);

begin
    process(CLK, RST)
    begin
        if RST = '1' then
            sample_0 <= (others => '0');
            sample_1 <= (others => '0');
            sample_2 <= (others => '0');
            sample_3 <= (others => '0');
        elsif rising_edge(CLK) then
            if SHIFT_EN = '1' then
                sample_0 <= DATA_IN;
                sample_1 <= sample_0;
                sample_2 <= sample_1;
                sample_3 <= sample_2;
            end if;
        end if;
    end process;

    sum_stage1_a <= unsigned('0' & sample_0) + unsigned('0' & sample_1);
    sum_stage1_b <= unsigned('0' & sample_2) + unsigned('0' & sample_3);

    sum_total <= unsigned('0' & sum_stage1_a) + unsigned('0' & sum_stage1_b);

    average <= std_logic_vector(sum_total(9 downto 2));
  
    DATA_OUT <= average;

end architecture rtl;