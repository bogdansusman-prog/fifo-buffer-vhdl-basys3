----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2025 02:13:13 PM
-- Design Name: 
-- Module Name: MPG - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
 
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
 
entity MPG is
    Port (btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : out STD_LOGIC );
end MPG;
 
architecture Behavioral of MPG is
    signal count : std_logic_vector (15 downto 0) := (others => '0');
    signal t : std_logic;
    signal q1, q2, q3 : std_logic;
 
begin
 
process (clk)
begin
    if (rising_edge(clk)) then
       --count <= std_logic_vector(unsigned(count) + 1);
       count <= count + 1;
    end if;
end process;
t <= '1' when count = x"FFFF" else '0';
process(clk)
begin
    if (rising_edge(clk)) then
        if(t = '1') then
            q1 <= btn;
        end if;
    end if;
end process;
process(clk)
begin
    if (rising_edge(clk)) then
        q2 <= q1;
   	    q3 <= q2;
    end if;
end process;
en <= q2 and not q3;
 
end Behavioral;