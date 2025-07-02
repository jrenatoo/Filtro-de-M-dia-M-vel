library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
    port(CLK, RST, NEW_DATA_VALID : in  std_logic;
        DATA_OUT_VALID, SHIFT_EN : out std_logic);
end entity control_unit;

architecture rtl of control_unit is
    type state_type is (S_IDLE, S_UPDATE, S_VALID);
    signal current_state : state_type := S_IDLE;
	 
begin
    process(CLK, RST)
    begin
        if RST = '1' then
            current_state <= S_IDLE;
        elsif rising_edge(CLK) then
            case current_state is
                when S_IDLE =>
                    if NEW_DATA_VALID = '1' then
                        current_state <= S_UPDATE;
                    else
                        current_state <= S_IDLE;
                    end if;
                when S_UPDATE =>
                    current_state <= S_VALID;
                when S_VALID =>
                    current_state <= S_IDLE;
                when others =>
                    current_state <= S_IDLE;
            end case;
        end if;
    end process;
	 
    process(current_state)
    begin
        SHIFT_EN <= '0';
        DATA_OUT_VALID <= '0';
        
        case current_state is
            when S_IDLE =>
                
            when S_UPDATE =>

                SHIFT_EN <= '1';
                
            when S_VALID =>

                DATA_OUT_VALID <= '1';
        end case;
    end process;
    
end architecture rtl;