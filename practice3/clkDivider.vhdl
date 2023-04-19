library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


--This code is an implementation of a clock divider circuit in VHDL.
--It takes an input clock signal (clk) and produces an output 
--clock signal (newClk) with a frequency equal to countLimit/frecuency(clk).
entity clkDivider is
    generic(
        countLimit : integer := 100000000
    );
    Port ( clk : in std_logic;
           newClk : out std_logic);
end clkDivider;

architecture hehavioral of clkDivider is
    signal actualCount : integer := 0;
    signal newClkAux : STD_LOGIC;
begin
    newClk <= newClkAux;
    process(clk)
    begin
        if clk'event and clk='1' then
            if actualCount < countLimit then
                actualCount <= actualCount + 1;
            else
                actualCount <= 0;
                newClkAux <= not newClkAux;
            end if;
        end if;
    end process;
end hehavioral;