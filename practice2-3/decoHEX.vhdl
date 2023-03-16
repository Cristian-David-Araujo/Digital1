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
--This code in VHDL is for generate a decoder hexa to 7-segment of anode common
--========================================================================
entity decoHex is
    Port ( binaryIn : in STD_LOGIC_VECTOR (3 downto 0);
           displayOut : out STD_LOGIC_VECTOR (6 downto 0)
         );
end decoHex;

architecture Behavioral of decoHex is

begin
    displayOut <= "0000001" when binaryIn = "0000" else
                     "1001111" when binaryIn = "0001" else
                     "0010010" when binaryIn = "0010" else
                     "0000110" when binaryIn = "0011" else
                     "1001100" when binaryIn = "0100" else
                     "0100100" when binaryIn = "0101" else
                     "0100000" when binaryIn = "0110" else
                     "0001111" when binaryIn = "0111" else
                     "0000000" when binaryIn = "1000" else
                     "0000100" when binaryIn = "1001" else
                     "0001000" when binaryIn = "1010" else
                     "1100000" when binaryIn = "1011" else
                     "0110001" when binaryIn = "1100" else
                     "1000010" when binaryIn = "1101" else
                     "0110000" when binaryIn = "1110" else
                     "0111000" when binaryIn = "1111" else
                     "1111111";
    
    
end Behavioral;