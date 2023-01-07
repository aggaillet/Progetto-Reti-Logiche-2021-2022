----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2022 10:21:33
-- Design Name: 
-- Module Name: project_reti_logiche - Behavioral
-- Project Name: Progetto di Reti Logiche
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

entity project_reti_logiche is
    Port ( i_clk : in STD_LOGIC;
           i_rst : in STD_LOGIC;
           i_start : in STD_LOGIC;
           i_data : in STD_LOGIC_VECTOR (7 downto 0);
           o_address : out STD_LOGIC_VECTOR (15 downto 0);
           o_done : out STD_LOGIC;
           o_en : out STD_LOGIC;
           o_we : out STD_LOGIC;
           o_data : out STD_LOGIC_VECTOR (7 downto 0)--;
--           o_serin : out STD_LOGIC;
--           o_conv : out STD_LOGIC_VECTOR (1 downto 0);
--           o_parallel : out STD_LOGIC_VECTOR (7 downto 0);
--           o_readOUT : out STD_LOGIC_VECTOR (7 downto 0);
--           o_serialStart, o_serialOut : out STD_LOGIC
           );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is
    component serial_8bit
        port ( i_data : in STD_LOGIC_VECTOR (7 downto 0);
               clk, rst : in STD_LOGIC;
               o_data, comm_start : out STD_LOGIC;
               in_start : in STD_LOGIC);
    end component;
    
    component parallel_8bit
        port ( i_data : in STD_LOGIC_VECTOR (1 downto 0);
               o_data : out STD_LOGIC_VECTOR (7 downto 0);
               o_full : out STD_LOGIC;
               clk, rst, start : in STD_LOGIC);
    end component;
    
    component blocco_convoluzionale
        port (u0, clk, rst : in  STD_LOGIC;
              y : out STD_LOGIC_VECTOR (1 downto 0);
              comm_start : out STD_LOGIC;
              in_start : in STD_LOGIC);
    end component;

    component memory_module
        port ( from_memory : in STD_LOGIC_VECTOR (7 downto 0);
               from_system : in STD_LOGIC_VECTOR (7 downto 0);
               clk, rst , start, write: in STD_LOGIC;
               to_memory : out STD_LOGIC_VECTOR (7 downto 0);
               to_system : out STD_LOGIC_VECTOR (7 downto 0);
               we : out STD_LOGIC;
               en : out STD_LOGIC;
               mem_address : out STD_LOGIC_VECTOR (15 downto 0);
               done, started : out STD_LOGIC
);
    end component;
    
    
    signal read_data : STD_LOGIC_VECTOR (7 downto 0);
    signal read_add : STD_LOGIC_VECTOR (15 downto 0);
    signal read_en, read_we, read_start : STD_LOGIC;
    signal read_serial : STD_LOGIC_VECTOR (7 downto 0);
    signal serial_conv : STD_LOGIC;
    signal conv_par2x8 : STD_LOGIC_VECTOR (1 downto 0);
    signal parOut : STD_LOGIC_VECTOR (7 downto 0);
    signal parFull : STD_LOGIC;
    signal write_add : STD_LOGIC_VECTOR (15 downto 0);
    signal write_data : STD_LOGIC_VECTOR (7 downto 0);
    signal write_en, write_we, write_done, doneOut : STD_LOGIC;
    signal clk, rst : STD_LOGIC;
    signal start_parallel, start_conv, start_serial : STD_LOGIC;
begin
    read_start <= i_start;
    clk <= i_clk;
    rst <= i_rst or write_done;
    o_done <= write_done;
    
--    o_conv <= conv_par2x8;
--    o_serin <= serial_conv;
--    o_parallel <= parOut;
--    o_readOUT <= read_serial;
--    o_serialStart <= start_serial;
--    o_serialOut <= serial_conv;
    
    SER8 : serial_8bit
        port map(read_serial, clk, rst, serial_conv, start_conv, start_serial);
    CONV : blocco_convoluzionale
        port map(serial_conv, clk, rst, conv_par2x8, start_parallel, start_conv);
    PAR2x8 : parallel_8bit
        port map(conv_par2x8, parOut, parFull, clk, rst, start_parallel);
    MEMMOD : memory_module
        port map(i_data, parOut, clk, rst, read_start, parFull, o_data, read_serial, o_we, o_en, o_address, write_done, start_serial);

end Behavioral;
