----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2022 16:55:25
-- Design Name: 
-- Module Name: memory_module - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_module is
    Port ( from_memory : in STD_LOGIC_VECTOR (7 downto 0);
           from_system : in STD_LOGIC_VECTOR (7 downto 0);
           clk, rst , start, write: in STD_LOGIC;
           to_memory : out STD_LOGIC_VECTOR (7 downto 0);
           to_system : out STD_LOGIC_VECTOR (7 downto 0);
           we : out STD_LOGIC;
           en : out STD_LOGIC;
           mem_address : out STD_LOGIC_VECTOR (15 downto 0);
           done, started : out STD_LOGIC--;
           --totW : out STD_LOGIC_VECTOR (7 downto 0)
           );
end memory_module;

architecture Behavioral of memory_module is
    signal word_totalSIG : STD_LOGIC_VECTOR (7 downto 0);
    
    component FlipFlopD
        port(i_D, clk, rst : in std_logic;
            o_D : out std_logic);
    end component;
begin
    process(clk, rst)
        variable read_address : INTEGER;
        variable write_address : INTEGER;
        variable bit_read : INTEGER;
        variable to_write : STD_LOGIC_VECTOR(7 downto 0);
        variable write_flag : STD_LOGIC;
        variable num_written : INTEGER;
        variable delay : INTEGER;
        variable rst_extender : INTEGER := 0;
    begin
        if clk = '1' and clk'event then
        if rst = '1' or rst_extender > 0 then
            if rst_extender = 0 then
                rst_extender := 10;
            else
                rst_extender := rst_extender - 1;
            end if;
            read_address := 0;
            write_address := 999;
            mem_address <= std_logic_vector(to_unsigned(read_address, mem_address'length));
            word_totalSIG <= from_memory;
            bit_read := 7;
            started <= '0';
            en <= '1';
            we <= '0';
            if start = '0' then
                done <= '0';
            end if;
            num_written := 0;
            delay := 0;
        else
            if start = '1' then
            if bit_read = 7 then
                bit_read := 0;
                if write = '1' then
                    write_flag := '1';
                    to_write := from_system;
                end if;
                read_address := read_address + 1;
                mem_address <= std_logic_vector(to_unsigned(read_address, mem_address'length));
                en <= '1';
                we <= '0';
            else
                if bit_read = 1 then
                    to_system <= from_memory;
                    started <= '1';
                end if;
                bit_read := bit_read + 1;
                if write_flag = '1' then
                    to_memory <= to_write;
                    write_address := write_address + 1;
                    mem_address <= std_logic_vector(to_unsigned(write_address, mem_address'length));
                    en <= '1';
                    we <= '1';
                    num_written := num_written + 1;
                    write_flag := '0';
                elsif write = '1' then
                    to_memory <= from_system;
                    write_address := write_address + 1;
                    mem_address <= std_logic_vector(to_unsigned(write_address, mem_address'length));
                    en <= '1';
                    we <= '1';
                    num_written := num_written + 1;
                else
                    en <= '0';
                    we <= '0';
                    mem_address <= std_logic_vector(to_unsigned(read_address, mem_address'length));
                end if;
            end if;
            if num_written >= 2*to_integer(unsigned(word_totalSIG)) then
                delay := delay + 1;
            end if;
            if delay = 2 then
                done <= '1';
            end if;
            end if;
        end if;
        end if;
        --totW <= word_totalSIG;
    end process;
end Behavioral;
