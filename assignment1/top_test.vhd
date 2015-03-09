--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:46:16 03/09/2015
-- Design Name:   
-- Module Name:   D:/work/vlsi/VLSI-Design-assignments/assignment1/top_test.vhd
-- Project Name:  adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
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
 
ENTITY top_test IS
END top_test;
 
ARCHITECTURE behavior OF top_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         a : IN  std_logic_vector(23 downto 0);
         b : IN  std_logic_vector(23 downto 0);
         sum : OUT  std_logic_vector(23 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(23 downto 0) := (others => '0');
   signal b : std_logic_vector(23 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal sum : std_logic_vector(23 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          a => a,
          b => b,
          sum => sum,
          clk => clk,
          rst => rst
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

        rst <= '0';

        a <= (others => '0');
        b <= (others => '0');
        wait for clk_period*2;	
        
        a <= (others => '1');
        b <= (others => '1');
        wait for clk_period*2;	
        
        a <= "011111111111111111111111";
        b <= "000000000000000000000001";
        wait for clk_period*2;	
        
        a <= "000000000000000000000001";
        b <= "000000000000000000000001";
        wait for clk_period*2;
        
        rst <= '1';
        wait for clk_period*2;

      -- insert stimulus here 

      wait;
   end process;

END;
