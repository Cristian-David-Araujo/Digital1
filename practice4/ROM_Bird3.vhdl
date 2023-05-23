library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM_Bird3 is
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (15 downto 0));
end ROM_Bird3;

architecture Behavioral of ROM_Bird3 is
--Here is the defition of the ROM memory
    subtype dataMemory is STD_LOGIC_VECTOR (15 downto 0);
    type memory is array (0 to 15) of dataMemory;

    --Information in the memory ROM
    constant memoryROM : memory := (
        "0001110000000000", "0010001000000000", "0010001000000000", "0010000100000000",
        "0001000101111000", "0111000010000100", "1001000000010010", "0100100000000001",
        "0100011000001110", "0010000000001000", "0001100000110000", "0000011111000000",
        x"0000", x"0000", x"0000", x"0000"
    );

begin
    data <= memoryROM(to_integer(unsigned(address)));
end Behavioral;