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

entity top is

    port ( 
        a, b : in  std_logic_vector(23 downto 0);
        sum : out std_logic_vector(23 downto 0);
        clk, rst : in std_logic
    );
    
end top;

architecture Behavioral of top is

    component adder is
        port (
            a, b : in std_logic_vector(23 downto 0);
            sum : out std_logic_vector(23 downto 0)
        );
    end component;
    
    component regist is
        port (
            d : in std_logic_vector(23 downto 0);
            q : out std_logic_vector(23 downto 0);
            clk, rst : in std_logic
        );
    end component;
    
    signal a_in, b_in, sum_in : std_logic_vector(23 downto 0);

begin

    a_in_reg : regist port map (a, a_in, clk, rst);
    b_in_reg : regist port map (b, b_in, clk, rst);
    sum_in_reg : regist port map (sum_in, sum, clk, rst);
    adder_block : adder port map (a_in, b_in, sum_in);

end Behavioral;

