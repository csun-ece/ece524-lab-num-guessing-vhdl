library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce_tb is
end debounce_tb;

architecture Behavioral of debounce_tb is

  signal clk, rst, button : std_logic := '0';
  signal result : std_logic := '0';

  component debounce is
    generic
    (
      clk_freq    : integer := 50_000_000; --system clock frequency in Hz
      stable_time : integer := 10          --time button must remain stable in ms
    );
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           button : in  STD_LOGIC;
           result : out STD_LOGIC);
  end component;

  constant CP: time := 10 ns;

begin

  uut : debounce
    generic map (clk_freq => 1000, stable_time => 5)
    port map (clk => clk, rst => rst, button => button, result => result);

  clk_process : process
  begin
    clk <= '1';
    wait for CP/2;
    clk <= '0';
    wait for CP/2;
  end process;

  reset_process : process
  begin
    rst <= '1';
    wait for CP;
    rst <= '0';
    wait;
  end process;
 
  stimulus_process: process
    begin
    wait for 10*CP;
    button <= '1';
    wait for CP;
    button <= '0';
    wait for 4*CP;
    button <= '1';
    wait for CP;
    button <= '0';
    wait for 2*CP;
    button <= '1';
    wait for 20*CP;
    button <= '0';
  end process;

end architecture;
