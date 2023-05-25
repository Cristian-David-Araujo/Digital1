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
        "0000000000111000", "0000000001000100", "0000000001000100", "0000000010000100",
        "0001111010001000", "0010000100001110", "0100100000001001", "1000000000010010",
        "0111000001100010", "0001000000000100", "0000110000011000", "0000001111100000",
        x"0000", x"0000", x"0000", x"0000"
    );

begin
    data <= memoryROM(to_integer(unsigned(address)));
end Behavioral;