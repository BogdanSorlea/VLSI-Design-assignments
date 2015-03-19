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

entity loopback_mux_shift_register is

    port ( 
        sin : in std_logic_vector(7 downto 0);
        sel : in std_logic_vector(3 downto 0);
        pout : out std_logic_vector(31 downto 0);
        clk, rst : in std_logic
    );
    
end loopback_mux_shift_register;

architecture Behavioral of loopback_mux_shift_register is
    
    component regist is
        port (
            d : in std_logic_vector(7 downto 0);
            q : out std_logic_vector(7 downto 0);
            clk, rst : in std_logic
        );
    end component;
    
    signal d_0, d_1, d_2, d_3, q_0, q_1, q_2, q_3 : std_logic_vector(7 downto 0);

begin
    
    d_0 <= q_0 when sel(0) = '0' else sin;
    d_1 <= q_1 when sel(1) = '0' else sin;
    d_2 <= q_2 when sel(2) = '0' else sin;
    d_3 <= q_3 when sel(3) = '0' else sin;
    
    reg_0 : regist port map (d_0, q_0, clk, rst);
    reg_1 : regist port map (d_1, q_1, clk, rst);
    reg_2 : regist port map (d_2, q_2, clk, rst);
    reg_3 : regist port map (d_3, q_3, clk, rst);
    
    pout(31 downto 0) <= q_3 & q_2 & q_1 & q_0;

end Behavioral;

