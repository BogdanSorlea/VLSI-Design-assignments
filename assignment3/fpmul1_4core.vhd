----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:57:14 05/11/2015 
-- Design Name: 
-- Module Name:    fpmul1_4core - Behavioral 
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

entity fpmul1_4core is

    port(A1, A2: in std_logic_vector(32*4-1 downto 0);
         CLOCK : in std_logic_vector(3 downto 0); 
         RESET : in std_logic;
         Z: out std_logic_vector(32*4-1 downto 0));

end fpmul1_4core;

architecture SCHEMATIC of fpmul1_4core is

    component fpmul1 is
        Port (	A1 : In std_logic_vector (31 downto 0);
            A2 : In std_logic_vector (31 downto 0);
            CLOCK : In std_logic;
            RESET : In std_logic;
            Z : Out std_logic_vector (31 downto 0) );
    end component;

begin

    CORE_GEN: for I in 0 to 3 generate
        CORE: fpmul1 port map(
            A1(32*(I+1)-1 downto 32*I), 
            A2(32*(I+1)-1 downto 32*I), 
            CLOCK(I), 
            RESET,
            Z(32*(I+1)-1 downto 32*I)
        );
    end generate;

end SCHEMATIC;

configuration CFG_FPMUL1_4CORE_SCHEMATIC of FPMUL1_4CORE is

   for SCHEMATIC
      for CORE_GEN
          for CORE: fpmul1
             use configuration WORK.CFG_fpmul1_SCHEMATIC;
          end for;
      end for;
   end for;

end CFG_FPMUL1_4CORE_SCHEMATIC;