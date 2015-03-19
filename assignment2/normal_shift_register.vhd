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

entity normal_shift_register is

    port ( 
        sin : in  std_logic_vector(7 downto 0);
        pout : out std_logic_vector(31 downto 0);
        clk, rst : in std_logic
    );
				    
end normal_shift_register;

architecture Behavioral of normal_shift_register is
				        
    component regist is
        port (
            d : in std_logic_vector(7 downto 0);
            q : out std_logic_vector(7 downto 0);
            clk, rst : in std_logic
        );
    end component;
												        
    signal q_0, q_1, q_2 : std_logic_vector(7 downto 0);

begin
													        
    reg_0 : regist port map (sin, q_0, clk, rst);
    reg_1 : regist port map (q_0, q_1, clk, rst);
    reg_2 : regist port map (q_1, q_2, clk, rst);
    reg_3 : regist port map (q_2, pout(31 downto 24), clk, rst);
																    
    pout(23 downto 0) <= q_2 & q_1 & q_0;

end Behavioral;