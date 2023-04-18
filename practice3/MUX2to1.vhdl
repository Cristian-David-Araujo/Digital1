library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--This code implements a MUX with 2 to 1
entity MUX2to1 is
    Port ( in0, in1 : in STD_LOGIC_VECTOR (3 downto 0);
            selection : in STD_LOGIC;
            MUXout : out STD_LOGIC_VECTOR (3 downto 0));
end MUX2to1;

architecture behavioral of MUX2to1 is
    signal MUXout_signal : STD_LOGIC_VECTOR (3 downto 0);
begin
    MUXout <= MUXout_signal;

    with selection select
    MUXout_signal <= in0 when '0',
                     in1 when others;
end behavioral;