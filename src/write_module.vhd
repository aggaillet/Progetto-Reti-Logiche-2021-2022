----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.02.2022 12:42:37
-- Design Name: 
-- Module Name: write_module - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity write_module is
    Port ( i_full : in STD_LOGIC;
           i_data : in STD_LOGIC_VECTOR (7 downto 0);
           i_clk : in STD_LOGIC;
           o_write_address : out STD_LOGIC_VECTOR (15 downto 0);
           o_data : out STD_LOGIC_VECTOR (7 downto 0);
           o_en : out STD_LOGIC;
           o_done : out STD_LOGIC;
           o_we : out STD_LOGIC);
end write_module;

architecture Behavioral of write_module is

begin
    process(i_clk)
        variable count : INTEGER := 0;
        variable current_address : INTEGER := 999;
    begin
        if i_clk = '1' and i_clk'event then
            if i_full = '1' then
                o_we <= '1';
                o_en <= '1';
                count := count + 1;
                current_address := current_address + 1;
                if count = 2 then
                    o_done <= '1';
                else
                    o_done <= '0';
                end if;
            else
                o_we <= '0';
                o_en <= '0';
                count := 0;
                o_done <= '0';
            end if;
            o_write_address <= std_logic_vector(to_unsigned(current_address, o_write_address'length));
            o_data <= i_data; 
        end if;
    end process;

end Behavioral;
