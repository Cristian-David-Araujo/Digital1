library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


--This code implements a register of 4 bits, with a clock and an enable signal.
entity FFD is
    Port ( CLK : in STD_LOGIC;
           Data : in STD_LOGIC_VECTOR (3 downto 0);
           Enable : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0) --Output of register
           --nQ : out STD_LOGIC_VECTOR (3 downto 0)
           );
end FFD;

architecture Behavioral of FFD is
begin
    --Declaration of flip-flop type D active on the rising edge of the clock
    process (CLK, Enable)
    begin
        if (CLK'event and CLK = '1') then
            if (Enable = '1') then
                Q <= Data;
                --nQ <= not Data;
            end if;
        end if;
    end process;
end Behavioral;
