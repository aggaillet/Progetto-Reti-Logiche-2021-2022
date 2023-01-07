----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2022 10:34:25
-- Design Name: 
-- Module Name: Flip-Flop D - Behavioral
-- Project Name: Progetto di Reti Logiche
-- Target Devices: 
-- Tool Versions: 
-- Description: flip flop type D
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

entity FlipFlopD is
    port ( i_D, clk, rst : in STD_LOGIC;
           o_D : out STD_LOGIC);
end FlipFlopD;

architecture Behavioral of FlipFlopD is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            o_D <= '0';
        elsif clk = '1' and clk'event then 
            o_D <= i_D;
        end if;
    end process;

end Behavioral;