# VHDL Inverter Module

## Overview

This project contains a VHDL implementation of an inverter module, which inverts the input data received over an AXI-stream interface. The module is accompanied by a testbench to verify its functionality.

## Files

- `inverter.vhdl`: The VHDL file containing the inverter module implementation.
- `tb_inverter.vhdl`: The testbench for the inverter module to simulate and verify its behavior.

## Inverter Module

### Description

The `inverter` module reads 32-bit data from the AXI-stream slave interface, inverts each byte, and outputs the result through the AXI-stream master interface.

### Entity

```vhdl
entity inverter is
  generic (
    data_width : integer := 32
  );
  Port (
        clk : in std_logic;
        reset : in std_logic;
        -- AXI slave 
        s_axis_data : in std_logic_vector (data_width - 1 downto 0); 
        s_axis_valid : in std_logic;
        s_axis_ready : out std_logic;
        
        -- AXI master
        m_axis_data : out std_logic_vector (data_width - 1 downto 0);
        m_axis_valid : out std_logic;
        m_axis_ready : in std_logic
  );
end inverter;
