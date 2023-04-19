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
--This code is for a driver module that controls four 7-segment displays to show a 14-bit binary number.
--The binary number is divided into units, tens, hundreds, and thousands and then sent to a decoder that
--converts the value into a displayable format. The displays are multiplexed and updated every 4ms based on a clock signal
--========================================================================
entity driverDisplay is
    Port (  binaryIn0, binaryIn1, binaryIn2, binaryIn3 : in STD_LOGIC_VECTOR (3 downto 0);
            clk : in STD_LOGIC; --Clock of 4ms
            displayActive : out STD_LOGIC_VECTOR (3 downto 0);
            displayOut : out STD_LOGIC_VECTOR (6 downto 0)
         );
end driverDisplay;

architecture Behavioral of driverDisplay is
    component decoDisplay is
        Port (  binaryIn : in STD_LOGIC_VECTOR (3 downto 0);
                displayOut : out STD_LOGIC_VECTOR (6 downto 0)
             );
    end component decoDisplay;

    signal displayPosition : STD_LOGIC_VECTOR (1 downto 0);
    signal displayIn : STD_LOGIC_VECTOR (3 downto 0);
    signal displayOutAux : STD_LOGIC_VECTOR (6 downto 0);

begin

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

    displayActive <= "1110" when (displayPosition = "00") else
                        "1101" when (displayPosition = "01") else
                        "1011" when (displayPosition = "10") else
                        "0111";

    displayIn <=  binaryIn3 when (displayPosition = "00") else
                  binaryIn2 when (displayPosition = "01") else
                  binaryIn1 when (displayPosition = "10") else
                  binaryIn0;
                       
          
    decoDisplay1: decoDisplay port map (binaryIn  => displayIn, displayOut => displayOutAux);
     -- Select the display to be active
    --- Assign a constant value to output port "alternativeDisplay" for show the caracter "-" in the display
    displayOut <= "1111110" when (binaryIn0 = "0101" and displayPosition = "00") else displayOutAux;
end Behavioral;