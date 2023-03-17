library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

use STD.textio.all;
use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;

--========================================================================
--This code in VHDL is for generate a testbench for the behavioral, structural and dataflow models of the circuit
-- F = (AB) + C'
--========================================================================

entity test is
end test;

architecture behavior of test is

    --This are the components of the testbench
    component behavioral
        port( A : in STD_LOGIC;
              B : in STD_LOGIC;
              C : in STD_LOGIC;
              Fout : out STD_LOGIC);
    end component;

    component structural
        port( A : in STD_LOGIC;
              B : in STD_LOGIC;
              C : in STD_LOGIC;
              Fout : out STD_LOGIC);
    end component;

    component dataFlow
        port( A : in STD_LOGIC;
              B : in STD_LOGIC;
              C : in STD_LOGIC;
              Fout : out STD_LOGIC);
    end component;

    --This are the signals of the testbench
    --The signals are the same for the three components because they are the same circuit
    --The orden of vector is [A,B,C]
    signal ABCinput : STD_LOGIC_VECTOR(2 downto 0) := "000";

    --Those signal are for the output of the three components
    signal Fbehavioral : STD_LOGIC;
    signal Fstructural : STD_LOGIC;
    signal FdataFlow : STD_LOGIC;

    --This are the signals for the expected output
    signal Fexpected : STD_LOGIC;

    --This part generates the expected output
    procedure expectedOutput (
        signal ABCinput : in STD_LOGIC_VECTOR(2 downto 0);
        signal Fout : out STD_LOGIC) is
        
    begin
        --This is the expected output for the three components
        Fout <= (ABCinput(2) and ABCinput(1)) or (not ABCinput(0));
    end expectedOutput;

    begin
        --Instance of the three components
        uut_behavioral : behavioral port map(
            A => ABCinput(2),
            B => ABCinput(1),
            C => ABCinput(0),
            Fout => Fbehavioral);

        uut_structural : structural port map(
            A => ABCinput(2),
            B => ABCinput(1),
            C => ABCinput(0),
            Fout => Fstructural);

        uut_dataFlow : dataFlow port map(
            A => ABCinput(2),
            B => ABCinput(1),
            C => ABCinput(0),
            Fout => FdataFlow);
        
        --This part generates the expected output
        expectedOutput(ABCinput,Fexpected);
        
        --Here is the testbench, we test the three components with the same input
        --Probe all posible inputs
        process is
            variable i : integer := 0;
        begin

            for i in 0 to 7 loop
                --This is the input for the components
                --to_unsigned get out a number i in vector std logic vector with 3 bits
                ABCinput <= std_logic_vector(to_unsigned(i,3));
                
                if (Fexpected = Fbehavioral) and (Fexpected = Fstructural) and (Fexpected = FdataFlow) then
                    report "Test passed" severity note;
                else
                    report "Test failed" severity error;
                end if;
                
                wait for 10 ns;
            end loop;

        end process;
end behavior;
