library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity number_guess is
    port
    (
        clk       : in std_logic;
        rst       : in std_logic;
        enter     : in std_logic;
        show      : in std_logic;
        switches  : in std_logic_vector (3 downto 0);
        leds      : out std_logic_vector (3 downto 0);
        red_led   : out std_logic;
        blue_led  : out std_logic;
        green_led : out std_logic
    );
end number_guess;

architecture behavioral of number_guess is
    signal secret_number : integer range 0 to 15 := 0;
    signal guess         : integer range 0 to 15 := 0;
    signal game_start    : std_logic             := '0';
begin
    process (rst, enter)
    begin
        if (rst = '1') then
            game_start    <= '1';
            secret_number <= (others => '0') & to_unsigned(round(rand), 4);
        elsif (enter = '1') then
            game_start <= '0';
            guess      <= to_integer(unsigned(switches));
            if (guess = secret_number) then
                green_led <= '1';
                blue_led  <= '0';
                red_led   <= '0';
            elsif (guess > secret_number) then
                green_led <= '0';
                blue_led  <= '0';
                red_led   <= '1';
            else
                green_led <= '0';
                blue_led  <= '1';
                red_led   <= '0';
            end if;
        end if;
    end process;

    leds <= std_logic_vector(secret_number) when (game_start = '0' and show = '1');
end behavioral;