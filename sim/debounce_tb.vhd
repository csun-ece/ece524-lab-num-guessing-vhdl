library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity debounce_tb is
end debounce_tb;

architecture behavior of debounce_tb is
  signal clk : std_logic := '0';
  signal rst : std_logic := '1';
  signal button : std_logic := '0';
  signal result : std_logic;

  component debounce is
    generic
    (
      clk_freq    : integer := 50_000_000; --system clock frequency in Hz
      stable_time : integer := 10);        --time button must remain stable in ms
    port
    (
      clk     : in std_logic;   --input clock
      rst : in std_logic;   --asynchronous active low reset
      button  : in std_logic;   --input signal to be debounced
      result  : out std_logic); --debounced signal
  end component;

begin
  dut: debounce
    generic map (
      clk_freq    => 50_000_000,
      stable_time => 10)
    port map (
      clk     => clk,
      rst => rst,
      button  => button,
      result  => result);

  clk_gen: process
  begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process;

  stim_gen: process
  begin
    rst <= '1';
    button <= '0';
    wait for 10 ns;
    rst <= '0';
    wait for 10 ns;
    button <= '1';
    wait for 12 ms;
    button <= '0';
    wait for 50 ns;
    wait;
  end process;

end behavior;
