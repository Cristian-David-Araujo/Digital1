

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

entity behavioral is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           Fout : out STD_LOGIC);
end behavioral;

architecture Behavioral of behavioral is

begin
    process(A,B,C)
    begin
        if (A='1' and B='1' and C='1') then
            Fout <= '1';
        elsif (A='1' and B='1' and C='0') then
            Fout <= '1';
        elsif (A='1' and B='0' and C='1') then
            Fout <= '0';
        elsif (A='1' and B='0' and C='0') then
            Fout <= '1';
        elsif (A='0' and B='1' and C='1') then
            Fout <= '0';
        elsif (A='0' and B='1' and C='0') then
            Fout <= '1';
        elsif (A='0' and B='0' and C='1') then
            Fout <= '0';
        else
            Fout <= '1';
        end if;
    end process;

end Behavioral;
