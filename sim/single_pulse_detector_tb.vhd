library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity single_pulse_detector_tb is
end single_pulse_detector_tb;

architecture Behavioral of single_pulse_detector_tb is
    signal clk          : std_logic := '0';
    signal rst          : std_logic := '1';
    signal input_signal : std_logic := '0';
    signal output_pulse : std_logic;

begin
    -- instantiate the design under test
    dut : entity work.single_pulse_detector
        port map
        (
            clk          => clk,
            rst          => rst,
            input_signal => input_signal,
            output_pulse => output_pulse
        );

    -- clock generation process
    clk_gen : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    -- input signal generation process
    input_gen : process
    begin
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait for 20 ns;
        input_signal <= '1';
        wait for 20 ns;
        input_signal <= '0';
        wait;
    end process;
end Behavioral;