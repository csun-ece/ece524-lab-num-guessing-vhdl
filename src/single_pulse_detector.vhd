library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity single_pulse_detector is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           input_signal : in  STD_LOGIC;
           output_pulse : out  STD_LOGIC);
end single_pulse_detector;

architecture Behavioral of single_pulse_detector is
    signal state : std_logic := '0';
begin
    process (clk, rst)
    begin
        if rst = '1' then
            state <= '0';
        elsif rising_edge(clk) then
            if input_signal = '1' and state = '0' then
                state <= '1';
                output_pulse <= '1';
            elsif input_signal = '1' and state = '1' then
                output_pulse <= '0';
            else
                output_pulse <= '0';
            end if;
        end if;
    end process;
end Behavioral;
