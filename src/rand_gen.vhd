library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity rand_gen is
    port
    (
        clk, rst : in std_logic;
        seed     : in std_logic_vector(7 downto 0);
        output   : out std_logic_vector (3 downto 0)
    );
end rand_gen;

architecture Behavioral of rand_gen is
    signal currstate, nextstate : std_logic_vector (7 downto 0);
    signal feedback             : std_logic;
begin
    StateReg : process (clk, rst)
    begin
        if (rst = '1') then
            currstate <= seed;
        elsif rising_edge(clk) then
            currstate <= nextstate;
        end if;
    end process;

    feedback  <= currstate(4) xor currstate(3) xor currstate(2) xor currstate(0);
    nextstate <= feedback & currstate(7 downto 1);
    output    <= currstate(7 downto 4);

end Behavioral;