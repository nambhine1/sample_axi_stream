----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.06.2024 07:58:24
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
use ieee.numeric_std.all;

entity inverter is
  generic (
    data_width : integer := 32
  );
  Port (
        clk : in std_logic;
        reset : in std_logic;
        -- axi slave 
        s_axis_data : in std_logic_vector (data_width - 1 downto 0); 
        s_axis_valid : in std_logic;
        s_axis_ready : out std_logic;
        
        -- axi master
        m_axis_data : out std_logic_vector (data_width - 1 downto 0);
        m_axis_valid : out std_logic;
        m_axis_ready : in std_logic
  );
end inverter;

architecture Behavioral of inverter is
begin

-- ready handling 
    s_axis_ready <= m_axis_ready;

-- valid handling 
   valid_data: process (clk)
      begin
        if rising_edge (clk) then
            m_axis_valid <= s_axis_valid;
        end if;
      end process valid_data;
      
  data_handling : process (clk)
    begin
        if rising_edge (clk) then
            if (s_axis_valid = '1' and m_axis_ready = '1') then
              for i in 0 to (data_width / 8) - 1 loop
                m_axis_data((i*8 + 7) downto i*8) <= std_logic_vector (to_unsigned(255 - to_integer(unsigned(s_axis_data((i*8 + 7) downto i*8))), 8));
              end loop;
            end if;
        end if;
    end process data_handling;

end Behavioral;
