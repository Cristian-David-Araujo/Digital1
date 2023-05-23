library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM_Bird2 is
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (15 downto 0));
end ROM_Bird2;

architecture Behavioral of ROM_Bird2 is
--Here is the defition of the ROM memory
    subtype dataMemory is STD_LOGIC_VECTOR (15 downto 0);
    type memory is array (0 to 15) of dataMemory;

    --Information in the memory ROM
    constant memoryROM : memory := (
        x"0000", x"0000", x"0000", x"0000",
        "0000000001111000", "0111011110000100", "1000100000010010", "0111000000000001",
        "1000000001001110", "1000000010001000", "0110000100110000", "0001111111000000",
        x"0000", x"0000", x"0000", x"0000"
    );

begin
    data <= memoryROM(to_integer(unsigned(address)));
end Behavioral;