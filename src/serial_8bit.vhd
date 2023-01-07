----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2022 12:00:08
-- Design Name: 
-- Module Name: serial_8bit - Behavioral
-- Project Name: Progetto di Reti Logiche
-- Target Devices: 
-- Tool Versions: 
-- Description: concatenates an 8 bit signal from MSB to LSB to a 1 bit stream
-- 
-- Dependencies: FlipFlopD
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

entity serial_8bit is
    Port ( i_data : in STD_LOGIC_VECTOR (7 downto 0);
           clk, rst : in STD_LOGIC;
           o_data, comm_start : out STD_LOGIC;
           in_start : in STD_LOGIC);
end serial_8bit;

architecture Behavioral of serial_8bit is
    component FlipFlopD
        port ( i_D, clk, rst : in STD_LOGIC;
               o_D : out STD_LOGIC);
    end component;
    
    
begin
    process(clk, rst)
        variable count : INTEGER := 7;
    begin
        if clk = '1' and clk'event then
            if rst = '1' then
                count := 7;
                o_data <= '0';
                comm_start <= '0';
            else
                if in_start = '1' then
                    o_data <= i_data(count);
                    comm_start <= '1';
                    if count = 0 then
                        count := 7;
                    else
                        count := count - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
