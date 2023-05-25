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
        "0001111000000000", "0010000110001110", "0100100001010001", "1000000000100010",
        "0111001000011100", "0001000100001000", "0000110010001000", "0000001110001000",
        "0000000010001000", "0000000010010000", "0000000010010000", "0000000001100000"
    );

begin
    data <= memoryROM(to_integer(unsigned(address)));
end Behavioral;