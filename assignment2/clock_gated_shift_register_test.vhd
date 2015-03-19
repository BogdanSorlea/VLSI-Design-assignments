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
 
ENTITY clock_gated_shift_register_test IS
END clock_gated_shift_register_test;
 
ARCHITECTURE behavior OF clock_gated_shift_register_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock_gated_shift_register
    port ( 
        sin : in std_logic_vector(7 downto 0);
        pout : out std_logic_vector(31 downto 0);
        clk : in std_logic_vector(3 downto 0);
        rst : in std_logic
    );
    END COMPONENT;
    

   --Inputs
   signal sin : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic_vector(3 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 	--Outputs
   signal pout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clock_gated_shift_register PORT MAP (
          sin => sin,
          pout => pout,
          clk => clk,
          rst => rst
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

        rst <= '0';

        sin <= (others => '1');
        clk <= "1000";
        wait for clk_period;	
        
        sin <= (others => '0');
        clk <= "0100";
        wait for clk_period;	
        
        sin <= "11110000";
        clk <= "0010";
        wait for clk_period;	
        
        sin <= "00001111";
        clk <= "0001";
        wait for clk_period;	

      -- insert stimulus here 

      wait;
   end process;

END;
