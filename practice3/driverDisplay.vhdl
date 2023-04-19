library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--========================================================================
--This code is for a driver module that controls four 7-segment displays 
--The code is a driver module for four 7-segment displays that uses a process to
--update the position of the displays and an instance of a "decoDisplay" component
--that is used to decode and display the input value on each display.
--========================================================================
entity driverDisplay is
    Port (  binaryIn0, binaryIn1, binaryIn2 : in STD_LOGIC_VECTOR (3 downto 0);
            binaryIn3 : in STD_LOGIC_VECTOR (4 downto 0);
            clk : in STD_LOGIC; --Clock of 4ms
            displayActive : out STD_LOGIC_VECTOR (3 downto 0);
            displayOut : out STD_LOGIC_VECTOR (6 downto 0)
         );
end driverDisplay;

architecture Behavioral of driverDisplay is
    --Declaration of the component that decodes the input value and displays it on the 7-segment display
    component decoDisplay is
        Port (  binaryIn : in STD_LOGIC_VECTOR (4 downto 0);
                displayOut : out STD_LOGIC_VECTOR (6 downto 0)
             );
    end component decoDisplay;

    --Auxiliary signals for the process that updates the display position and the logic that selects the input to be displayed
    signal displayPosition : STD_LOGIC_VECTOR (1 downto 0);
    signal displayIn : STD_LOGIC_VECTOR (4 downto 0);
    
    --Auxiliary signals for adding leading zeros to the input signals
    signal binaryIn0Aux, binaryIn1Aux, binaryIn2Aux : STD_LOGIC_VECTOR (4 downto 0);

begin
    -- Process that updates display position based on the clock signal
    process (clk)
    begin
        if (clk'event and clk = '1') then
            if (displayPosition < 3) then
                displayPosition <= displayPosition + 1;
            else
                displayPosition <= "00";
            end if;
        end if;
    end process;
    
    --Logic for determining which 7-segment display is active
    displayActive <= "1110" when (displayPosition = "00") else
                     "1101" when (displayPosition = "01") else
                     "1011" when (displayPosition = "10") else
                     "0111";
    
    --Add leading zeros to the input signals and select the correct signal based on the display position
    binaryIn0Aux <= '0' & binaryIn0;
    binaryIn1Aux <= '0' & binaryIn1;
    binaryIn2Aux <= '0' & binaryIn2;
    
    --Logic for selecting the input to be displayed
    displayIn <=  binaryIn3 when (displayPosition = "00") else
                  binaryIn2Aux when (displayPosition = "01") else
                  binaryIn1Aux when (displayPosition = "10") else
                  binaryIn0Aux;
                       
    --After selecting the information that corresponds to each display,
    --it is decoded in the next component to display the binary information in BCD format.     
    decoDisplay1: decoDisplay port map (binaryIn  => displayIn, displayOut => displayOut);

end Behavioral;