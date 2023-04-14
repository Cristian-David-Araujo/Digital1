library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--========================================================================
--This code in VHDL is for implement of a ALU and an 7 segments display with next operation
-- if operationSelect = "000" then operationOut <= A or B
-- if operationSelect = "001" then operationOut <= A + B
-- if operationSelect = "010" then operationOut <= not B
-- if operationSelect = "011" then operationOut <= A + 2
-- if operationSelect = "100" then operationOut <= A - 2, but if A < 2 then operationOut <= 0;
-- if operationSelect = "101" then operationOut <= show an "-" in the display
-- if operationSelect = "110" then operationOut <= B*2
-- if operationSelect = "111" then operationOut <= A + B, but if A + B > 24 then operationOut <= 0;
--========================================================================

entity completeAssembly is
    Port ( add_A, add_B : in STD_LOGIC_VECTOR(2 downto 0);
           FA, FB : in STD_LOGIC;
           sel_ALU : in STD_LOGIC_VECTOR (2 downto 0);
           en, dataA : in STD_LOGIC_VECTOR (3 downto 0);
           CLK : in STD_LOGIC;

           displayOut : out STD_LOGIC_VECTOR(6 downto 0);
           activeDisplay : out STD_LOGIC_VECTOR(3 downto 0));
end completeAssembly;

architecture Behavioral of completeAssembly is

    -- Declare the components used in the architecture
    component ROM_A is
        Port (  address : in STD_LOGIC_VECTOR (2 downto 0);
                data : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    component ROM_B is
        Port (  address : in STD_LOGIC_VECTOR (2 downto 0);
                data : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    component FFD is
        Port (  CLK : in STD_LOGIC;
                Data : in STD_LOGIC_VECTOR (3 downto 0);
                Enable : in STD_LOGIC;
                Q : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    component MUX2to1 is
        Port (  in0, in1 : in STD_LOGIC_VECTOR (3 downto 0);
                selection : in STD_LOGIC;
                MUXout : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    component ALU is
        Port (  A, B : in STD_LOGIC_VECTOR(3 downto 0);
                operationSelect : in STD_LOGIC_VECTOR (2 downto 0);
                operationOut : out STD_LOGIC_VECTOR (3 downto 0);
                Cout : out STD_LOGIC);
    end component;

    component driverDisplay is
        Port (  binaryIn : in STD_LOGIC_VECTOR (3 downto 0);
                clk : in STD_LOGIC;
                displayActive : out STD_LOGIC_VECTOR (3 downto 0);
                displayOut : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    -- Declare an internal signal used in the architecture
    signal outROM_A, outROM_B : STD_LOGIC_VECTOR (3 downto 0);

begin

     -- Instantiate component "ALU" and assign values to its input and output ports
    ALU1 : ALU Port map (A => A, B => B, operationSelect => XYZ, operationOut => S, Cout => Cout);

    -- Assign a constant value to output port "activeDisplay", this indicate the display to be active
    activeDisplay <= "1110";
    -- Assign a constant value to output port "alternativeDisplay" for show the caracter "-" in the display
    alternativeDiplayOut <= "1111110";
 
    -- Instantiate component "decoHEX" and assign values to its input and output ports
    decoHEX1 : decoHEX Port map (binaryIn => S, displayOut => displayOutAux);
    -- Select the display to be active
    displayOut <= alternativeDiplayOut when XYZ = "101" else displayOutAux;

end Behavioral;