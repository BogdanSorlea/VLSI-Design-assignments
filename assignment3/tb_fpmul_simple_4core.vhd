library IEEE;
	use IEEE.std_logic_1164.all;
	use STD.textio.all;
	use IEEE.std_logic_textio.all;

entity E4s is
end E4s;

architecture A4s of E4s is

	 signal A1 : std_logic_vector(32*4-1 downto 0) := (others => '0');
	 signal A2 : std_logic_vector(32*4-1 downto 0) := (others => '0');
	 signal CLOCK : std_logic_vector(3 downto 0) := "1111";
     signal clk: std_logic;
	 signal RESET : std_logic;
	 signal  Z, S1 : std_logic_vector(32*4-1 downto 0);
     signal noOperations: integer := 4; -- 1,2,3,4

   component fpmul1_4core
        Port (  A1 : In std_logic_vector (32*4-1 downto 0);
                A2 : In std_logic_vector (32*4-1 downto 0);
                CLOCK : In std_logic_vector(3 downto 0);
                RESET : In std_logic;
                Z : Out std_logic_vector (32*4-1 downto 0) );
   end component;

begin
   
   CLOCK(0) <= clk;
   CLOCK(1) <= clk;
   CLOCK(2) <= clk;
   CLOCK(3) <= clk;

   UUT : fpmul1_4core
	 Port Map ( A1, A2, CLOCK, RESET, Z );

   TB : block
   begin
   process
	file cmdfile: TEXT; 		 -- Define the file 'handle'
	variable line_in,line_out: Line; -- Line buffers
	variable good: boolean;   	 -- Status of the read operations
	variable A,B: std_logic_vector(32-1 downto 0);
    variable A4,B4,S4 : std_logic_vector(32*4-1 downto 0);
	variable AP,BP: std_logic_vector(32*4-1 downto 0);
    variable tmpz,tmpsp: std_logic_vector(32*noOperations-1 downto 0);
	variable S: std_logic_vector(32-1 downto 0);
	variable operation: std_logic;
	variable opp: std_logic;
	variable c: integer;
    variable iterat : integer := 0;
    variable SP: std_logic_vector(32*4-1 downto 0);
	-- constant TEST_PASSED: string := "Test passed:";
	-- constant TEST_FAILED: string := "Test FAILED:";

	begin


  SP := (others => '0');
  AP := (others => '0');
  BP := (others => '0');
  A4 := (others => '0');
  B4 := (others => '0');
  S4 := (others => '0');
  A1 <= (others => '0');
  A2 <= (others => '0');
  S1 <= (others => '0');
  tmpz := (others => '0');
  tmpsp := (others => '0');
  reset <= '0';
  wait for  5 ns;
  reset <= '1';
  clk <= '0';
  wait for 5 ns;
  c := 1;
-- -------------------------------------------------------------------------
  FILE_OPEN(cmdfile,"testvecs9996.in",READ_MODE);
  
  loop
  
    if (c > 1) then
        
        tmpz := (others => '0');
        tmpsp := (others => '0');
        for iterat in 0 to 3 loop
            if iterat < noOperations then
                tmpz(32*(iterat+1)-1 downto 32*iterat) := Z(32*(iterat+1)-1 downto 32*iterat);
                tmpsp(32*(iterat+1)-1 downto 32*iterat) := SP(32*(iterat+1)-1 downto 32*iterat);
            end if;
        end loop;
    
        write(line_out, string'("Test "));
        write(line_out,c-1);
        if (tmpz = tmpsp) then
            write(line_out, string'(" passed:"));
        else
            write(line_out, string'(" FAILED:"));
        end if;
        hwrite(line_out, AP, RIGHT,9);
        write(line_out, string'(" * "));
        hwrite(line_out, BP, RIGHT,9);
        write(line_out, string'(" -> "));
        hwrite(line_out, tmpsp, RIGHT,9);
        if (tmpz = tmpsp) then
            write(line_out, string'(" == "));
        else
            write(line_out, string'(" <> "));
        end if;
        hwrite(line_out,Z,RIGHT,9);
        writeline(OUTPUT,line_out);     -- write the message
        assert (tmpz = tmpsp) report "Z does not match in pattern " severity error;
        
        SP := S4;
        AP := A4;
        BP := B4;
    end if;
    
    for iterat in 0 to 3 loop
        if endfile(cmdfile) then  -- Check EOF
            assert false
               report "End of file encountered; exiting."
               severity NOTE;
            exit;
        end if;

        readline(cmdfile,line_in);     -- Read a line from the file
        next when line_in'length = 0;  -- Skip empty lines
        hread(line_in,A,good);         -- Read the A argument as hex value
        assert good report "Text I/O read error" severity ERROR;
        hread(line_in,B,good);         -- Read the B argument as hex value
        assert good report "Text I/O read error" severity ERROR;
        hread(line_in,S,good);         -- Read the S argument as hex value
        assert good report "Text I/O read error" severity ERROR;
        
        if iterat < noOperations then
            write(line_out, "  EN - ( ");
        else
            write(line_out, " DIS - ( ");
        end if;
        write(line_out, c);
        write(line_out, " | ");
        write(line_out, iterat);
        write(line_out, " ) - ");
        hwrite(line_out, A, RIGHT,9);
        write(line_out, " * ");
        hwrite(line_out, B, RIGHT,9);
        write(line_out, " -> ");
        hwrite(line_out, S, RIGHT,9);
        writeline(OUTPUT,line_out);       
        
        if iterat < noOperations then
            A4((iterat+1)*32-1 downto iterat*32) := A;
            B4((iterat+1)*32-1 downto iterat*32) := B;
            S4((iterat+1)*32-1 downto iterat*32) := S;   
        end if;
        
    end loop;
    
    A1 <= A4;
    A2 <= B4;
    
    if (c = 1) then
        SP := S4;
        AP := A4;
        BP := B4;
        
        for iterat in 0 to 3 loop
            if endfile(cmdfile) then  -- Check EOF
                assert false
                   report "End of file encountered; exiting."
                   severity NOTE;
                exit;
            end if;

            readline(cmdfile,line_in);     -- Read a line from the file
            next when line_in'length = 0;  -- Skip empty lines
            hread(line_in,A,good);         -- Read the A argument as hex value
            assert good report "Text I/O read error" severity ERROR;
            hread(line_in,B,good);         -- Read the B argument as hex value
            assert good report "Text I/O read error" severity ERROR;
            hread(line_in,S,good);         -- Read the S argument as hex value
            assert good report "Text I/O read error" severity ERROR;
            
            if iterat < noOperations then
                write(line_out, "  EN - ( ");
            else
                write(line_out, " DIS - ( ");
            end if;
            write(line_out, c);
            write(line_out, " | ");
            write(line_out, iterat);
            write(line_out, " ) - ");
            hwrite(line_out, A, RIGHT,9);
            write(line_out, " * ");
            hwrite(line_out, B, RIGHT,9);
            write(line_out, " -> ");
            hwrite(line_out, S, RIGHT,9);
            writeline(OUTPUT,line_out);       
            
            if iterat < noOperations then
                A4((iterat+1)*32-1 downto iterat*32) := A;
                B4((iterat+1)*32-1 downto iterat*32) := B;
                S4((iterat+1)*32-1 downto iterat*32) := S;
            end if;
            
        end loop;
        
        clk <= '1'; wait for 5 ns; clk <= '0'; wait for 5 ns;
        A1 <= A4;
        A2 <= B4;
    end if;
    
    clk <= '1'; wait for 5 ns; clk <= '0'; wait for 5 ns;
    c := c + 1;

  end loop;
-- -------------------------------------------------------------------------

  clk <= '1'; wait for  5 ns; clk <= '0'; wait for  5 ns;
  clk <= '1'; wait for  5 ns; clk <= '0'; wait for  5 ns;
  write(line_out, string'("-- END OF SIMULATION -------------------------"));
  writeline(OUTPUT,line_out); 


   end process;
 end block;
end A4s;

configuration CFG_TB_fpmul1_4core_nogating_BEHAVIORAL of E4s is
   for A4s
	 for UUT : fpmul1_4core
	   use configuration WORK.cfg_fpmul1_4core_schematic;
	 end for;

	 for TB
	 end for;

   end for;
end CFG_TB_fpmul1_4core_nogating_BEHAVIORAL;
