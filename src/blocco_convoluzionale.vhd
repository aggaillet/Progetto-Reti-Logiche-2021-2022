----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2022 10:55:32
-- Design Name: 
-- Module Name: blocco_convoluzionale - Behavioral
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

entity blocco_convoluzionale is
    Port (u0, clk, rst : in  STD_LOGIC;
          y : out STD_LOGIC_VECTOR (1 downto 0);
          comm_start : out STD_LOGIC;
          in_start : in STD_LOGIC);
end blocco_convoluzionale;

architecture Structural of blocco_convoluzionale is
    component FlipFlopD
        port ( i_D, clk, rst : in STD_LOGIC;
               o_D : out STD_LOGIC);
    end component;
    
    signal u1, u2 : STD_LOGIC;
begin
    FF1: FlipFlopD
        port map(u0, clk, rst, u1);
    FF2: FlipFlopD
        port map(u1, clk, rst, u2);
    y(0) <= ((u0 xor u1) xor u2);
    y(1) <= (u0 xor u2);
    comm_start <= in_start;
end Structural;
