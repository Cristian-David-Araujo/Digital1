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

architecture Behavioural of test is
    component completeAssembly is
        Port(add_A: in STD_LOGIC_VECTOR(2 downto 0);
            add_B : in STD_LOGIC_VECTOR(1 downto 0);
            FA, FB, en0, en1, en2 : in STD_LOGIC;
            sel_ALU : in STD_LOGIC_VECTOR (2 downto 0);
            dataA, dataB : in STD_LOGIC_VECTOR (3 downto 0);
            clk : in STD_LOGIC;

            totalOut : out STD_LOGIC_VECTOR (5 downto 0);                
            cout : out STD_LOGIC;
            displayOut : out STD_LOGIC_VECTOR(6 downto 0);
            activeDisplay : out STD_LOGIC_VECTOR(3 downto 0)
            );
    end component;

    signal add_A, sel_ALU : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal add_B : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal FA, FB, en0, en1, en2, cout_test : STD_LOGIC := '0';
    signal dataA, dataB : STD_LOGIC_VECTOR(3 downto 0) := "0000";

    signal totalOut_test : STD_LOGIC_VECTOR(5 downto 0);
    signal displayOut_test : STD_LOGIC_VECTOR(6 downto 0);
    signal activeDisplay_test : STD_LOGIC_VECTOR(3 downto 0);

    signal clktest : STD_LOGIC := '0';


begin
    uut_completeAssembly: completeAssembly
    Port map(
        add_A => add_A,
        add_B => add_B,
        FA => FA,
        FB => FB,
        en0 => en0,
        en1 => en1,
        en2 => en2,
        sel_ALU => sel_ALU,
        dataA => dataA,
        dataB => dataB,
        clk => clk_test,

        totalOut => totalOut_test,
        cout => cout_test,
        displayOut => displayOut_test,
        activeDisplay => activeDisplay_test
    );

    process
        variable i, j, k, l, count : integer := '0';
        variable FandEn : std_logic_vector(4 downto 0) := '00000';
        variable add : std_logic_vector(4 downto 0) := '00000';
        variable data : std_logic_vector(7 downto 0) := '00000000';
    begin
        clktest <= not clktest after 5ns;

        if count = 2 then
        --sel_ALI
        for i in 0 to 7 loop
            --FA, FB, en0, en1, en2
            for j in 0 to 31 loop
                --add_A, add_B
                for k in 0 to 31 loop
                    --dataA, dataB
                    for l in 0 to 255 loop
                    sel_ALU <= std_logic_vector(to_unsigned(i, 3));

                    FandEn <= std_logic_vector(to_unsigned(j, 5));
                    FA <= FandEn(4);
                    FB <= FandEn(3);
                    en0 <= FandEn(2);
                    en1 <= FandEn(1);
                    en2 <= FandEn(0);

                    add <= std_logic_vector(to_unsigned(k,5));
                    add_A <= add(4 downto 2);
                    add_B <= add(1 downto 0);

                    data <= std_logic_vector(to_unsigned(l,8));
                    dataA <= data(7 downto 4);
                    dataB <= data(3 downto 0);
                    end loop;
                end loop;
            end loop;
        end loop;

        count := 0;

        else
            count := count + 1;
        end if;

    end process;
end Behavioural;