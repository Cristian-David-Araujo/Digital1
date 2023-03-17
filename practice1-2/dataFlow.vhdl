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
--This code in VHDL is for generate the next funtional combinational circuit with 3 inputs and 1 output

-- F = (AB) + C'
-- F = ((AB)'C)'
--========================================================================
entity dataFlow is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           Fout : out STD_LOGIC);
end dataFlow;

architecture Behavioral of dataFlow is

begin
    Fout <= (A and B) or (not C); 
end Behavioral;
