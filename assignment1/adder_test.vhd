--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:31:21 03/09/2015
-- Design Name:   
-- Module Name:   D:/work/vlsi/VLSI-Design-assignments/assignment1/adder_test.vhd
-- Project Name:  adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY adder_test IS
END adder_test;
 
ARCHITECTURE behavior OF adder_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder
    PORT(
         a : IN  std_logic_vector(23 downto 0);
         b : IN  std_logic_vector(23 downto 0);
         sum : OUT  std_logic_vector(23 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(23 downto 0) := (others => '0');
   signal b : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal sum : std_logic_vector(23 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder PORT MAP (
          a => a,
          b => b,
          sum => sum
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
        a <= (others => '0');
        b <= (others => '0');
        wait for 100 ns;	
        
        a <= (others => '1');
        b <= (others => '1');
        wait for 100 ns;	
        
        a <= "011111111111111111111111";
        b <= "000000000000000000000001";
        wait for 100 ns;	
        
        a <= "000000000000000000000001";
        b <= "000000000000000000000001";
        wait for 100 ns;
        
      wait;
   end process;

END;
