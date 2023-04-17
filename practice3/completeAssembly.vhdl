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
           en, dataA, dataB : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;

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
        Port (  binaryIn : in STD_LOGIC_VECTOR (13 downto 0);
                clk : in STD_LOGIC;
                displayActive : out STD_LOGIC_VECTOR (3 downto 0);
                displayOut : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    component clkDivider is
        generic (countLimit : integer);
        Port (  clk : in STD_LOGIC;
                newClk : out STD_LOGIC
             );
    end component clkDivider;

    -- Declare an internal signal used in the architecture
    signal outROM_A, outROM_B : STD_LOGIC_VECTOR (3 downto 0);

    --Declaration of clocks
    signal clk1ms, clk4ms, clk1s : STD_LOGIC;

    signal BA, BB, inALU1, inALU2: STD_LOGIC_VECTOR (3 downto 0);
    signal outALU : STD_LOGIC_VECTOR (4 downto 0);


    signal activeDisplayAux : STD_LOGIC_VECTOR (3 downto 0);
    signal displayOutAux : STD_LOGIC_VECTOR (6 downto 0);

begin
    --Instans of clock 
    --Clock 1ms
    clkDivider1ms : clkDivider
                generic map (countLimit => 100000)
                Port map (clk => clk,
                         newClk => clk1ms);

    --Clock 4ms
    clkDivider4ms : clkDivider
                generic map (countLimit => 4)
                Port map (clk => clk1ms,
                         newClk => clk4ms);

    --Clock 1s
    clkDivider1s : clkDivider
                generic map (countLimit => 1000)
                Port map (clk => clk1ms,
                         newClk => clk1s);

    --Instastion of ROM_A and ROM_B
    ROM_A1 : ROM_A Port map (address => add_A, data => outROM_A);
    ROM_B1 : ROM_B Port map (address => add_B, data => outROM_B);


    MUX2x1_1 : MUX2to1 Port map (in0 => outROM_A, in1 => dataA, selection => FA, MUXout => BA);
    FFD1 : FFD Port map (CLK => clk1ms, Data => BA, Enable => en0, Q => inALU1);


    MUX2x1_2 : MUX2to2 Port map (in0 => dataB, in1 => outROM_B, selection => FB, MUXout => BB);
    FFD2 : FFD Port map (CLK => clk1ms, Data => BB, Enable => en1, Q => inALU2);


     -- Instantiate component "ALU" and assign values to its input and output ports
    ALU1 : ALU Port map (A => inALU1, B => inALU2, operationSelect => sel_ALU, operationOut => outALU(3 downto 0), Cout => outALU(4));
    FFD3 : FFD Port map (CLK => clk1ms, Data => outALU(3 downto 0), Enable => en2, Q => outALU(3 downto 0));

    
 
    -- Instantiate component "decoHEX" and assign values to its input and output ports
    driverDisplay1 : driverDisplay Port map (binaryIn => "0000000000"&outALU, clk => clk4ms, displayActive => activeDisplay, displayOut => displayOutAux);
    -- Select the display to be active
    --- Assign a constant value to output port "alternativeDisplay" for show the caracter "-" in the display
    displayOut <= "1111110" when XYZ = "101" else displayOutAux;
    activeDisplay <= "0000" when XYZ = "101" else activeDisplayAux;

end Behavioral;