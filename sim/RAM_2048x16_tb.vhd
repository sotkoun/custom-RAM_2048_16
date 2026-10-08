library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM_2048x16_tb is
--  Port ( );
end RAM_2048x16_tb;

architecture Behavioral of RAM_2048x16_tb is
signal t_w_r, t_CE, t_Clk : std_logic := '0';
signal t_Addr : std_logic_vector(10 downto 0) := (others=>'0');
signal t_Data_in, t_Data_out : std_logic_vector(15 downto 0) := (others=>'0');

component RAM_2048x16 is
    port( w_r, CE, Clk : in std_logic ;
        Addr : in std_logic_vector(10 downto 0);
        Data_in : in std_logic_vector(15 downto 0);
        Data_out : out std_logic_vector(15 downto 0));
end component;

begin

DUT: RAM_2048x16 
    port map (
        w_r => t_w_r,
        CE => t_CE,
        Clk => t_Clk,
        Addr => t_Addr,
        Data_in => t_Data_in,
        Data_out => t_Data_out
        );
        
clock: process
begin
    t_clk <= '0';
    wait for 40 ns;
    loop 
        t_clk <='0';
        wait for 10 ns;
        t_clk <= '1';
        wait for 10 ns;
    end loop;
end process;
        
CE: process
begin
    t_CE <= '0';
    wait for 45 ns;
    t_CE <= '1';
    wait for 300 ns;
end process;

W_R: process
begin
    t_w_r <= '0';
    wait for 45 ns;
    t_w_r <= '1';
    wait for 45 ns;
end process;

Addr:process
begin
    for i in 0 to 2047 loop
        t_Addr <= std_logic_vector(unsigned(t_Addr) + to_unsigned(i, 11));
        wait for 60 ns;
    end loop;
end process;

process
begin
    for i in 0 to 65535 loop
        t_Data_in <= std_logic_vector(unsigned(t_Data_in) + to_unsigned(i, 16));
        wait for 35 ns;
    end loop;
end process;
    
        
end Behavioral;
