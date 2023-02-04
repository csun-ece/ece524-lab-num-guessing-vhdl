library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library ieee;
use ieee.std_logic_1164.all;

entity rand_gen_tb is
end rand_gen_tb;

architecture Behavioral of rand_gen_tb is
  component rand_gen is
    port (
      clk, rst : in std_logic;
      seed : in std_logic_vector(7 downto 0);
      output   : out std_logic_vector (3 downto 0));
  end component;

  signal clk_tb, rst_tb : std_logic;
  signal output_tb     : std_logic_vector(3 downto 0);
  constant seed_tb: std_logic_vector(7 downto 0) := "10010101";
begin
  uut : rand_gen port map(clk=>clk_tb, rst=>rst_tb, seed=>seed_tb, output => output_tb);

  clk_proc : process
  begin
    clk_tb <= '1';
    wait for 10 ns;
    clk_tb <= '0';
    wait for 10 ns;
  end process clk_proc;

  vector_proc : process
  begin
    rst_tb <= '1';
    wait for 5 ns;
    rst_tb <= '0';
    wait for 20 ns;
    wait;
  end process vector_proc;

end Behavioral;