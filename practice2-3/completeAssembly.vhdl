library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity completeAssembly is
    Port ( A, B : in STD_LOGIC_VECTOR(4 downto 0);
           XYZ : in STD_LOGIC_VECTOR(2 downto 0);
           Cout : out STD_LOGIC;
           displayOut : out STD_LOGIC_VECTOR(6 downto 0));
end completeAssembly;

architecture Behavioral of completeAssembly is

    component ALU is
        Port (  A, B : in STD_LOGIC_VECTOR(4 downto 0);
                operationSelect : in STD_LOGIC_VECTOR (2 downto 0);
                operationOut : out STD_LOGIC_VECTOR (4 downto 0);
                Cout : out STD_LOGIC);
    end component;

    component decoHEX is
        Port (  binaryIn : in STD_LOGIC_VECTOR(3 downto 0);
                displayOut : out STD_LOGIC_VECTOR(6 downto 0));
    end component;

    signal S : STD_LOGIC_VECTOR(4 downto 0);
begin
    
    ALU1 : ALU Port map (A => A, B => B, operationSelect => XYZ, operationOut => S, Cout => Cout);

    decoHEX1 : decoHEX Port map (binaryIn => S, displayOut => displayOut);

end Behavioral;