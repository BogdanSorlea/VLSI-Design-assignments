----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:35:14 03/09/2015 
-- Design Name: 
-- Module Name:    register - Behavioral 
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

entity regist is
    
    port (
        d : in std_logic_vector(7 downto 0);
        q : out std_logic_vector(7 downto 0);
        clk, rst : in std_logic
    );

end regist;

architecture Behavioral of regist is
begin

    process(d, clk, rst)
    begin
        if rst = '1' then
            q <= (others => '0');
        else
            if rising_edge(clk) then
                q <= d;
            end if;
        end if;
    end process;

end Behavioral;

