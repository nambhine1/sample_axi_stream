----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.06.2024 15:13:04
-- Design Name: 
-- Module Name: inverter - Behavioral
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

entity inverter is
  generic (
    data_width : integer := 32
  );
  Port (
    axi_clk : in std_logic;
    axi_reset_n : in std_logic;
    -- input axi s 
    s_axis_valid : in std_logic;
    s_axis_data : in std_logic_vector (data_width -1 downto 0);
    s_axis_ready : out std_logic;
    -- output axi_master
    m_axis_valid : out std_logic;
    m_axis_data : out std_logic_vector (data_width -1 downto 0);
    m_axis_ready : in std_logic
   );
end inverter;

architecture Behavioral of inverter is
signal i : integer;
-- assing ready from master to slave 
begin

    s_axis_ready <= m_axis_ready;
    
    valid_data: process (axi_clk) 
      begin
        if rising_edge (axi_clk) then
            m_axis_valid <= s_axis_valid;
        end if;
      end process valid_data;
     
     
    
    data_pass : process 
      begin
        if rising_edge (axi_clk) then
            if s_axis_valid = '1' and m_axis_ready = '1' then
                for i  in 0 to data_width/8 -1 loop
                    m_axis_data(i*8+7 downto i*8) <= s_axis_data(i*8+7 downto i*8);
                end loop;
            end if;
        end if;
      end process data_pass;
end Behavioral;
