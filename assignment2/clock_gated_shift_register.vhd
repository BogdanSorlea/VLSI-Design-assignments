----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:38:59 03/09/2015 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_gated_shift_register is

    port ( 
        sin : in std_logic_vector(7 downto 0);
        pout : out std_logic_vector(31 downto 0);
        clk : in std_logic_vector(3 downto 0);
        rst : in std_logic
    );
    
end clock_gated_shift_register;

architecture Behavioral of clock_gated_shift_register is
    
    component regist is
        port (
            d : in std_logic_vector(7 downto 0);
            q : out std_logic_vector(7 downto 0);
            clk, rst : in std_logic
        );
    end component;

begin
    
    reg_0 : regist port map (sin, pout(7 downto 0), clk(0), rst);
    reg_1 : regist port map (sin, pout(15 downto 8), clk(1), rst);
    reg_2 : regist port map (sin, pout(23 downto 16), clk(2), rst);
    reg_3 : regist port map (sin, pout(31 downto 24), clk(3), rst);

end Behavioral;

