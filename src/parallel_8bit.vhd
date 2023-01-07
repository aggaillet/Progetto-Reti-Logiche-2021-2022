----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2022 16:37:27
-- Design Name: 
-- Module Name: parallel_8bit - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity parallel_8bit is
    Port ( i_data : in STD_LOGIC_VECTOR (1 downto 0);
           o_data : out STD_LOGIC_VECTOR (7 downto 0);
           o_full : out STD_LOGIC;
           clk, rst, start : in STD_LOGIC);
end parallel_8bit;

architecture Behavioral of parallel_8bit is
    
begin
    process(clk, rst)
        variable count : INTEGER := 0;
    begin
        if rst = '1' then
            count := 0;
            o_full <= '0';
            o_data <= "00000000";
        elsif clk = '1' and clk'event then
            if start = '1' then
                o_data(7 - count) <= i_data(1);
                o_data(7 - (count + 1)) <= i_data(0);
                if count = 6 then
                    o_full <= '1';
                    count := 0;
                else
                    o_full <= '0';
                    count := count + 2;
                end if;
            else 
                o_full <= '0';
            end if;
        end if;
    end process;

end Behavioral;
