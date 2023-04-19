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
    Port ( add_A: in STD_LOGIC_VECTOR(2 downto 0);
           add_B : in STD_LOGIC_VECTOR(1 downto 0);
           FA, FB, en0, en1, en2 : in STD_LOGIC;
           sel_ALU : in STD_LOGIC_VECTOR (2 downto 0);
           dataA, dataB : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;

                      
           cout : out STD_LOGIC;
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
        Port (  A : in std_logic_vector(3 downto 0);
                B : in std_logic_vector(3 downto 0);
                opcode : in std_logic_vector(2 downto 0);
                S : out std_logic_vector(3 downto 0);
                CarryOut : out STD_LOGIC);
    end component;

    component driverDisplay is
        Port (  binaryIn0, binaryIn1, binaryIn2, binaryIn3 : in STD_LOGIC_VECTOR (3 downto 0);
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
    signal inROMB : STD_LOGIC_VECTOR (2 downto 0);

    --Declaration of clocks
    signal clk1ms, clk20ns : STD_LOGIC;

    signal BA, BB, inALU1, inALU2: STD_LOGIC_VECTOR (3 downto 0);
    signal sel_ALUAux : STD_LOGIC_VECTOR (3 downto 0);
    signal outALU : STD_LOGIC_VECTOR (4 downto 0);
    
    signal outFFD3 : STD_LOGIC_VECTOR (3 downto 0);

begin
    --Instans of clock
    --Clock 20ns
    clkDivider20ns : clkDivider
                generic map (countLimit => 2)
                Port map (clk => clk,
                         newClk => clk20ns);

    --Clock 1ms
    clkDivider1ms : clkDivider
                generic map (countLimit => 50000)
                Port map (clk => clk20ns,
                         newClk => clk1ms);

    --Instastion of ROM_A and ROM_B
    ROM_A1 : ROM_A Port map (address => add_A, data => outROM_A);
    inROMB <= '0'&add_B;
    ROM_B1 : ROM_B Port map (address => inROMB, data => outROM_B);


    MUX2x1_1 : MUX2to1 Port map (in0 => outROM_A, in1 => dataA, selection => FA, MUXout => BA);
    FFD1 : FFD Port map (CLK => clk, Data => BA, Enable => en0, Q => inALU1);


    MUX2x1_2 : MUX2to1 Port map (in0 => dataB, in1 => outROM_B, selection => FB, MUXout => BB);
    FFD2 : FFD Port map (CLK => clk, Data => BB, Enable => en1, Q => inALU2);


     -- Instantiate component "ALU" and assign values to its input and output ports
    ALU1 : ALU Port map (A => inALU1, B => inALU2, opcode => sel_ALU, S => outALU(3 downto 0), CarryOut => outALU(4));
    FFD3 : FFD Port map (CLK => clk, Data => outALU(3 downto 0), Enable => en2, Q => outFFD3);
    cout <= outALU(4);
    
    sel_ALUAux <= '0'&sel_ALU;

    -- Instantiate component "decoHEX" and assign values to its input and output ports
    driverDisplay1 : driverDisplay Port map (binaryIn0 => sel_ALUAux,
                                             binaryIn1 => inALU1,
                                             binaryIn2 => inALU2,
                                             binaryIn3 => outFFD3,
                                             clk => clk1ms,
                                             displayActive => activeDisplay,
                                             displayOut => displayOut);

end Behavioral;