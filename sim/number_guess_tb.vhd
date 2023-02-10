library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity number_guess_tb is
end entity;

architecture behavior of number_guess_tb is
    signal clk, rst, enter, show, capture: std_logic;
    signal switches: std_logic_vector(3 downto 0);
    signal leds: std_logic_vector(3 downto 0);
    signal red_led, blue_led, green_led: std_logic;
    
    constant clk_period: time := 10 ns;
    constant answer: integer := 12; -- this number is only true with the seed 0000_00001
    
    component number_guess is
        generic
        (
            clk_freq    : integer := 125_000_000;
            stable_time : integer := 10;
            seed        : std_logic_vector(7 downto 0) := b"0000_0001"
        );
        port
        (
            clk       : in std_logic;
            rst       : in std_logic;
            enter     : in std_logic;
            show      : in std_logic;
            capture   : in std_logic;
            switches  : in std_logic_vector (3 downto 0);
            leds      : out std_logic_vector (3 downto 0);
            red_led   : out std_logic;
            blue_led  : out std_logic;
            green_led : out std_logic
        );
    end component;
    begin
    -- instantiate the component under test (cut)
    component_instance: number_guess
    generic map
    (
        clk_freq => 1000,
        stable_time => 10,
        seed => "10110110"
    )
    port map
    (
        clk => clk,
        rst => rst,
        enter => enter,
        show => show,
        capture => capture,
        switches => switches,
        leds => leds,
        red_led => red_led,
        blue_led => blue_led,
        green_led => green_led
    );
    
    -- clock process
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    rst_process: process
    begin
        -- initial reset
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait;
    end process;    
    -- test scenario process
    scenario_process: process
        begin
        switches <= (others => '0');
        wait for 5*clk_period;        
        -- test scenario
        enter <= '1';
        wait for 20*clk_period;
        enter <= '0';
        wait for clk_period;
        show <= '1';
        wait for 20*clk_period;
        show <= '0';
        wait for clk_period;
        switches <= "0100";
        wait for clk_period;
        enter <= '1';
        wait for 20*clk_period;
        enter <= '0';
        wait for clk_period;
        switches <= "1111";
        wait for clk_period;
        enter <= '1';
        wait for 20*clk_period;
        enter <= '0';
        wait for clk_period;
        switches <= "1100";
        wait for clk_period;
        enter <= '1';
        wait for 20*clk_period;
        enter <= '0';
        wait for clk_period;
        -- additional test scenarios can be added here
        wait;
    end process;
end architecture;
