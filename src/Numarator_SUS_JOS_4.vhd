----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 06:29:46 PM
-- Design Name: 
-- Module Name: Numarator_SUS_JOS_4 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Numarator_SUS_JOS_4 is
    Port (
        CE_WR : in  STD_LOGIC;
        CE_RD : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Numarator_SUS_JOS_4;

architecture Behavioral of Numarator_SUS_JOS_4 is
    signal cnt : unsigned(3 downto 0) := (others => '0');
begin

    process(CLK, RESET)
    begin
        if RESET = '1' then
            cnt <= (others => '0'); -- Resetare imediat?
        elsif rising_edge(CLK) then
            if CE_WR = '1' and CE_RD = '0' then
                cnt <= cnt + 1;
            elsif CE_RD = '1' and CE_WR = '0' then
                cnt <= cnt - 1;
            end if;
        end if;
    end process;

    Q <= std_logic_vector(cnt);

end Behavioral;
