library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--========================================================================
--This code in VHDL is for implement in the FPGA with the Xilinx module Basys3
--Here we implement the commbinational funtion F = (AB) + C'
--This implementation have 3 inputs and 3 output
--The three outputs  are for the 3 LEDs of the FPGA, the first output is for the LED 0, the second for the LED 1 and the third for the LED 2
--The led 2 is the output of the function with behavioral implementation
--The led 1 is the output of the function with dataFlow implementation
--The led 0 is the output of the function with structural implementation
--========================================================================
entity completeAssembly is
    Port ( ABCinput : in STD_LOGIC_VECTOR(2 downto 0);
           Fbehavioral : out STD_LOGIC;
           FdataFlow : out STD_LOGIC;
           Fstructural : out STD_LOGIC);
end completeAssembly;

architecture Behavioral of completeAssembly is

    --Those are components for the implementation of the function with the 3 different methods
    component behavioral
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               C : in STD_LOGIC; 
               Fout : out STD_LOGIC);
    end component;

    component dataFlow
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               C : in STD_LOGIC;
               Fout : out STD_LOGIC);
    end component;

    component structural
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               C : in STD_LOGIC;
               Fout : out STD_LOGIC);
    end component;

begin
    behavioral1 : behavioral
        Port map (A => ABCinput(2), B => ABCinput(1), C => ABCinput(0), Fout => Fbehavioral);

    dataFlow1 : dataFlow
        Port map (A => ABCinput(2), B => ABCinput(1), C => ABCinput(0), Fout => FdataFlow);

    structural1 : structural
        Port map (A => ABCinput(2), B => ABCinput(1), C => ABCinput(0), Fout => Fstructural);

end Behavioral;