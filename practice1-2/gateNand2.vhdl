library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--========================================================================
--This code in VHDL is for generate a Nand gate with 2 inputs
--========================================================================
entity gateNand2 is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Fout : out STD_LOGIC);
end gateNand2;

architecture Behavioral of gateNand2 is

begin
    Fout <= X nand Y;
end Behavioral;
