library ieee;
use ieee.std_logic_1164.all;

entity moving_average_filter is
    port(CLK, RST, NEW_DATA_VALID : in  std_logic;
        DATA_IN : in  std_logic_vector(7 downto 0);
        DATA_OUT : out std_logic_vector(7 downto 0);
        DATA_OUT_VALID : out std_logic);
end entity moving_average_filter;

architecture structural of moving_average_filter is
    component control_unit is
		port(CLK, RST, NEW_DATA_VALID : in  std_logic;
				DATA_OUT_VALID, SHIFT_EN : out std_logic);
    end component;

    component datapath is
    port(CLK, RST, SHIFT_EN : in  std_logic;
			DATA_IN : in  std_logic_vector(7 downto 0);
			DATA_OUT : out std_logic_vector(7 downto 0));
    end component;

    signal shift_enable_signal : std_logic;

begin
    U_Control: control_unit
        port map(CLK => CLK, RST => RST, NEW_DATA_VALID => NEW_DATA_VALID, DATA_OUT_VALID => DATA_OUT_VALID, SHIFT_EN => shift_enable_signal);

    U_Datapath: datapath
        port map(CLK => CLK, RST => RST, SHIFT_EN => shift_enable_signal, DATA_IN => DATA_IN, DATA_OUT => DATA_OUT);

end architecture structural;