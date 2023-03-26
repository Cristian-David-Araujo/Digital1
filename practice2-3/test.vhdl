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
--This code in VHDL is for generate a testbench for the completeAssembly
--========================================================================

entity test is
end test;

architecture Behavioral of test is
    component completeAssembly is
        port(
            A, B : in STD_LOGIC_VECTOR(3 downto 0);
            XYZ : in STD_LOGIC_VECTOR(2 downto 0);
            Cout : out STD_LOGIC;
            displayOut : out STD_LOGIC_VECTOR(6 downto 0);
            activeDisplay : out STD_LOGIC_VECTOR(3 downto 0)
            );
    end component;

    signal Ainput, Binput : STD_LOGIC_VECTOR(3 downto 0);
    signal XYZinput : STD_LOGIC_VECTOR(2 downto 0);
    signal coutExpected : STD_LOGIC;
    signal displayOutexpected : STD_LOGIC_VECTOR(6 downto 0);
    signal activeDisplayexpected : STD_LOGIC_VECTOR(3 downto 0);

    signal coutTest : STD_LOGIC;
    signal displayOutTest : STD_LOGIC_VECTOR(6 downto 0);
    signal activeDisplayTest : STD_LOGIC_VECTOR(3 downto 0);

    --Procedure to generate the expected output for the completeAssembly
    procedure generateExpectedOutput(
        signal A, B : in STD_LOGIC_VECTOR(3 downto 0);
        signal operationSelect : in STD_LOGIC_VECTOR(2 downto 0);
        signal Cout : out STD_LOGIC;
        signal displayOut : out STD_LOGIC_VECTOR(6 downto 0)) is
        
        variable ALUout : STD_LOGIC_VECTOR(4 downto 0) := "00000";
        variable A1, B1 : STD_LOGIC_VECTOR(4 downto 0) := "00000";
        
    begin
        A1 := "0" & A;
        B1 := "0" & B;

        
        --All operation of the ALU
        case operationSelect is
            when "000" => ALUout := "0" & (A or B);
            when "001" => ALUout := A1 + B1;
            when "010" => ALUout := "0" & (not B);
            when "011" => ALUout := A1 + 2;
            when "100" => if A1 < "00010" then ALUout := "00000"; else ALUout := A1 - "00010"; end if;
            when "101" => ALUout := "01111";
            when "110" => ALUout := B1 and "00010";
            when "111" => if (A1 + B1) > "11000" then ALUout := "00000"; else ALUout := A1 + B1; end if;
            when others => ALUout := "11111";
        end case;
        Cout <= ALUout(4);

        --Generate displayOut with the result of ALU
        case ALUout(3 downto 0) is
            when "0000" => displayOut <= "0000001";
            when "0001" => displayOut <= "1001111";
            when "0010" => displayOut <= "0010010";
            when "0011" => displayOut <= "0000110";
            when "0100" => displayOut <= "1001100";
            when "0101" => displayOut <= "0100100";
            when "0110" => displayOut <= "0100000";
            when "0111" => displayOut <= "0001111";
            when "1000" => displayOut <= "0000000";
            when "1001" => displayOut <= "0000100";
            when "1010" => displayOut <= "0001000";
            when "1011" => displayOut <= "1100000";
            when "1100" => displayOut <= "0110001";
            when "1101" => displayOut <= "1000010";
            when "1110" => displayOut <= "0110000";
            when "1111" => if operationSelect = "101" then displayOut <= "1111110"; else displayOut <= "0111000"; end if;
            when others => displayOut <= "1111110";
        end case;

    end  generateExpectedOutput;

begin
    uut_completeAssembly : completeAssembly port map(
        A => Ainput,
        B => Binput,
        XYZ => XYZinput,
        Cout => coutTest,
        displayOut => displayOutTest,
        activeDisplay => activeDisplayTest
        );

    --Process to generate the expected output for the completeAssembly
    generateExpectedOutput(Ainput, Binput, XYZinput, coutExpected, displayOutexpected);
    
    --Process to test all possible inputs for the completeAssembly and compare the output with the expected output
    process
        variable i, j, k : integer := 0;
    begin
        for i in 8 to 15 loop
            for j in 8 to 15 loop
                for k in 0 to 7 loop
                    Ainput <= std_logic_vector(to_unsigned(i, 4));
                    Binput <= std_logic_vector(to_unsigned(j, 4));
                     XYZinput <= std_logic_vector(to_unsigned(k, 3));
                    assert coutTest = coutExpected report "Cout is not correct" severity error;
                    assert displayOutTest = displayOutexpected report "displayOut is not correct" severity error;
                    wait for 100 ns;
                end loop;
            end loop;
        end loop;
    end process;
    
end architecture behavioral;