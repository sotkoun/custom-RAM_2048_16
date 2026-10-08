library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM_2048x16 is
    port( w_r, CE, Clk : in std_logic ;
        Addr : in std_logic_vector(10 downto 0);
        Data_in : in std_logic_vector(15 downto 0);
        Data_out : out std_logic_vector(15 downto 0));
end RAM_2048x16;
    
architecture Behavioral of RAM_2048x16 is

type ram_array is array (0 to 2047) of std_logic_vector (15 downto 0);
signal ram : ram_array;
-- := (others => (others => '0'));
signal output : std_logic_vector (15 downto 0):=(others=>'0');
signal index : std_logic_vector (10 downto 0):="00000000001";

begin

    rising_proc:process(clk,CE)
    begin
        if CE = '0' then
            index <= (others=>'0');
        elsif rising_edge(clk) then
            index <= Addr;
        end if;
    end process;
        
    falling_proc:process(clk,CE)
    begin    
        if CE = '0' then
            output <= (others=>'0');
        elsif (falling_edge(Clk)) then
            if (w_r = '1') then
                ram(to_integer(unsigned(index))) <= Data_in;
            else 
                output <= ram(to_integer(unsigned(index)));
            end if;
        end if;
    end process;   
         
Data_out <= output;
        

end Behavioral;
