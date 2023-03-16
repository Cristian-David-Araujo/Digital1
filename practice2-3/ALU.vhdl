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
--This code in VHDL is for implement of a ALU with the next operations:
-- 0000: AND
--========================================================================
entity ALU is
    Port (  A, B : in STD_LOGIC_VECTOR (4 downto 0);
            operationSelect : in STD_LOGIC_VECTOR (2 downto 0);
            operationOut : out STD_LOGIC_VECTOR (4 downto 0);
            Cout : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is

begin
    
end Behavioral;