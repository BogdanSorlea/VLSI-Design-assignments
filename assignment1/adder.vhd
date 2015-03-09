----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:28:21 03/09/2015 
-- Design Name: 
-- Module Name:    adder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
    
    -- this adder ignores any carry in or carry out, as per. Figure 1 in 02205 Assignment 1
    port (
        a, b : in std_logic_vector(23 downto 0);
        sum : out std_logic_vector(23 downto 0)
    );

end adder;

architecture Behavioral of adder is

    signal tmp_sum : std_logic_vector(23 downto 0);

begin

    tmp_sum <= std_logic_vector(unsigned(a) + unsigned(b));
    sum <= tmp_sum(23 downto 0);

end Behavioral;
