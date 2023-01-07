----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2022 18:05:52
-- Design Name: 
-- Module Name: read_module - Behavioral
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

entity read_module is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           mem_add : out STD_LOGIC_VECTOR (15 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           mem_enable : out STD_LOGIC;
           mem_write : out STD_LOGIC;
           rst, start, clk : in STD_LOGIC;
           comm_start : out STD_LOGIC);
end read_module;

architecture Behavioral of read_module is

    component FlipFlopD is
        port ( i_D, clk, rst : in STD_LOGIC;
               o_D : out STD_LOGIC);
    end component;

    signal comm_startSIG1, comm_startSIG2, comm_startSIG3 : STD_LOGIC;
begin

    FF3: FlipFlopD
        port map(comm_startSIG1, clk, rst, comm_startSIG2);
    FF4 : FlipFlopD
        port map(comm_startSIG2, clk, rst, comm_startSIG3);
    FF5 : FlipFlopD
        port map(comm_startSIG3, clk, rst, comm_start);
     
    process (clk, rst)
        variable current_address : INTEGER := 1;
        variable check : INTEGER := 0;
        variable counter : INTEGER := 0;
    begin
        if clk = '1' and clk'event then
            if rst = '1' then
                    comm_startSIG1 <= '0';
                    mem_enable <= '0';
                    counter := 0;
            elsif start = '1' then
                mem_add <= std_logic_vector(to_unsigned(current_address, mem_add'length));
                data_out <= data_in;
                comm_startSIG1 <= '1';
                counter := counter + 1;
                mem_enable <= '1';
            else
                data_out <= "00000000";
                comm_startSIG1 <= '0';
            end if;
            
            if counter = 8 then
                counter := 0;
                current_address := current_address + 1;
            end if; 
            mem_write <= '0';
        end if;
    end process;

end Behavioral;
