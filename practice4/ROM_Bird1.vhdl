library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM_Bird1 is
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (15 downto 0));
end ROM_Bird1;

architecture Behavioral of ROM_Bird1 is
--Here is the defition of the ROM memory
    subtype dataMemory is STD_LOGIC_VECTOR (15 downto 0);
    type memory is array (0 to 15) of dataMemory;

    --Information in the memory ROM
    constant memoryROM : memory := (
        x"0000", x"0000", x"0000", x"0000",
        "0000000001111000", "0111000110000100", "1000101000010010", "0100010000000001",
        "0011100001001110", "0001000010001000", "0001000100110000", "0001000111000000",
        "0001000100000000", "0000100100000000", "0000100100000000", "0000011000000000"
    );

begin
    data <= memoryROM(to_integer(unsigned(address)));
end Behavioral;