----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.06.2024 08:04:43
-- Design Name: 
-- Module Name: tb_inverter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_inverter is
end tb_inverter;

architecture Behavioral of tb_inverter is

    signal clk : std_logic := '0';
    signal reset : std_logic;
    signal s_axis_data : std_logic_vector (31 downto 0) := "00000000000000000000000000000000";
    signal s_axis_valid : std_Logic;
    signal s_axis_ready : std_logic;
    
    signal m_axis_data : std_logic_vector (31 downto 0);
    signal m_axis_valid : std_logic;
    signal m_axis_ready :  std_Logic := '0';
    
    signal i : integer ;

begin



        inverter_instant: entity work.inverter
          generic map (
            data_width => 32
          )
          Port map (
                clk => clk,
                reset => reset,
                -- axi slave 
                s_axis_data  => s_axis_data,
                s_axis_valid => s_axis_valid,
                s_axis_ready => s_axis_ready,
                
                -- axi master
                m_axis_data => m_axis_data,
                m_axis_valid => m_axis_valid,
                m_axis_ready => m_axis_ready
          );
          
        clock_handling: process 
          begin
             clk <= not clk;
             wait for 5 ns;
          end process clock_handling ;
          
        stimulus: process
          begin
            for i in 0 to 4294967 -1 loop
                s_axis_data <= std_logic_vector (to_unsigned(i,32));
                s_axis_valid <= '1';
                m_axis_ready <= '1';
                wait for 10 ns;
                s_axis_data <= std_logic_vector (to_unsigned(i *2,32));
                m_axis_ready <= '0';
                wait for 10 ns;
            end loop;
            s_axis_valid <= '0';
            m_axis_ready <= '0';
            wait for 20 ns;
            std.env.stop;
          
        end process stimulus;
       
end Behavioral;
