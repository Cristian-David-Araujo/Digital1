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
        "0001111000000000", "0010000111101110", "0100100000010001", "1000000000001110",
        "0111001000000001", "0001000100000001", "0000110010000110", "0000001111111000",
        x"0000", x"0000", x"0000", x"0000"
    );

begin
    data <= memoryROM(to_integer(unsigned(address)));
end Behavioral;