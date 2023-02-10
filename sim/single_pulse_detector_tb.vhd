library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity single_pulse_detector_tb is
end single_pulse_detector_tb;

architecture Behavioral of single_pulse_detector_tb is
    signal clk          : std_logic := '0';
    signal rst          : std_logic := '1';
    signal input_signal : std_logic := '0';
    signal output_pulse_rising : std_logic;
    signal output_pulse_falling : std_logic;
    signal output_pulse_both : std_logic;
    signal output_pulse_none : std_logic;
  constant CP: time := 10 ns;

begin
    -- instantiate the design under test
    dut_rising_edge : entity work.single_pulse_detector
        generic map 
        (
        detect_type => "00"
        )
        port map
        (
            clk          => clk,
            rst          => rst,
            input_signal => input_signal,
            output_pulse => output_pulse_rising
        );

    dut_fall_edge : entity work.single_pulse_detector
        generic map 
        (
        detect_type => "01"
        )
        port map
        (
            clk          => clk,
            rst          => rst,
            input_signal => input_signal,
            output_pulse => output_pulse_falling
        );


    dut_rise_and_falling_edge : entity work.single_pulse_detector
        generic map 
        (
        detect_type => "10"
        )
        port map
        (
            clk          => clk,
            rst          => rst,
            input_signal => input_signal,
            output_pulse => output_pulse_both
        );

    dut_no_edge : entity work.single_pulse_detector
        generic map 
        (
        detect_type => "11"
        )
        port map
        (
            clk          => clk,
            rst          => rst,
            input_signal => input_signal,
            output_pulse => output_pulse_none
        );

    -- clock generation process
    clk_gen : process
    begin
        clk <= '0';
        wait for CP/2;
        clk <= '1';
        wait for CP/2;
    end process;

    rst_gen: process
    begin
        rst <= '1';
        wait for CP;
        rst <= '0';
        wait;   
    end process;

    -- input signal generation process
    input_gen : process
    begin
        wait for 3*CP;
        input_signal <= '1';
        wait for 5*CP;
        input_signal <= '0';
        wait for 4*CP;
        input_signal <= '1';
        wait for 8*CP;
        input_signal <= '0';
    end process;
end Behavioral;