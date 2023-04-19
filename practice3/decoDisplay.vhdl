library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--========================================================================
--This code in VHDL is for generate a decoder BCD to 7-segment of anode common
--========================================================================
entity decoDisplay is
    Port (  binaryIn : in STD_LOGIC_VECTOR (4 downto 0);
            displayOut : out STD_LOGIC_VECTOR (6 downto 0)
         );
end decoDisplay;

architecture Behavioral of decoDisplay is

begin
    displayOut <= "0000001" when binaryIn = "00000" else
                     "1001111" when binaryIn = "00001" else
                     "0010010" when binaryIn = "00010" else
                     "0000110" when binaryIn = "00011" else
                     "1001100" when binaryIn = "00100" else
                     "0100100" when binaryIn = "00101" else
                     "0100000" when binaryIn = "00110" else
                     "0001111" when binaryIn = "00111" else
                     "0000000" when binaryIn = "01000" else
                     "0000100" when binaryIn = "01001" else
                     "0001000" when binaryIn = "01010" else
                     "1100000" when binaryIn = "01011" else
                     "0110001" when binaryIn = "01100" else
                     "1000010" when binaryIn = "01101" else
                     "0110000" when binaryIn = "01110" else
                     "0111000" when binaryIn = "01111" else
                     "1111110" ;
    
    
end Behavioral;