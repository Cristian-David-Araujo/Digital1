library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--This code implement a memory ROM with 8 addresses and 4 bits of data
--The information is stored in the constant memoryROM
--The ROM contains the next data
--address 0 -> data A
--address 1 -> data B
--address 2 -> data 7
--address 3 -> data 6
--address 4 -> data 5
--address 5 -> data 4
--address 6 -> data 3
--address 7 -> data 0

entity ROM_B is
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
           data : out STD_LOGIC_VECTOR (3 downto 0));
end ROM_B;

architecture Behavioral of ROM_B is

    --Here is the defition of the ROM memory
    subtype dataMemory is STD_LOGIC_VECTOR (3 downto 0);
    type memory is array (0 to 7) of dataMemory;

    --Information in the memory ROM
    constant memoryROM : memory := (
        x"A", x"B", x"7", x"6", x"5", x"4", x"3", x"0"
    );
begin
    data <= memoryROM(to_integer(unsigned(address)));
end Behavioral;