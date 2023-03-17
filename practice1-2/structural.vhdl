
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
--This code in VHDL is for generate the next funtional combinational circuit with 3 inputs and 1 output

-- F = (AB) + C'
-- F = ((AB)'C)'
--========================================================================

entity structural is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           Fout : out STD_LOGIC);
end structural;

architecture Behavioral of structural is

    component gateNand2
        Port ( X : in STD_LOGIC;
               Y : in STD_LOGIC;
               Fout : out STD_LOGIC);
    end component;

    --This is out of firts gate nand
    signal Fout1 : STD_LOGIC;
begin

    gateNand2_1 : gateNand2
        Port map (X => A, Y => B, Fout => Fout1);
    
    gateNand2_2 : gateNand2
        Port map (X => Fout1, Y => C, Fout => Fout);

end Behavioral;
