library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--========================================================================
--This code is for a driver module that controls four 7-segment displays to show a 14-bit binary number.
--The binary number is divided into units, tens, hundreds, and thousands and then sent to a decoder that
--converts the value into a displayable format. The displays are multiplexed and updated every 4ms based on a clock signal
--========================================================================
entity driverDisplay is
    Port (  binaryIn : in STD_LOGIC_VECTOR (13 downto 0);
            clk : in STD_LOGIC; --Clock of 4ms
            displayActive : out STD_LOGIC_VECTOR (3 downto 0);
            displayOut : out STD_LOGIC_VECTOR (6 downto 0)
         );
end driverDisplay;

architecture Behavioral of driverDisplay is
    component decoDisplay is
        Port (  binaryIn : in STD_LOGIC_VECTOR (3 downto 0);
                displayOut : out STD_LOGIC_VECTOR (6 downto 0)
             );
    end component decoDisplay;

    signal displayPosition : STD_LOGIC_VECTOR (1 downto 0);
    --signal displayActiveAux : STD_LOGIC_VECTOR (3 downto 0);


    signal binaryInThousands : STD_LOGIC_VECTOR (13 downto 0);
    signal binaryInHundreds : STD_LOGIC_VECTOR (9 downto 0);
    signal binaryInTens : STD_LOGIC_VECTOR (6 downto 0);
    

    signal unity, tens, hundreds, thousands : STD_LOGIC_VECTOR (3 downto 0);

begin
    binaryInThousands <= binaryIn(3 downto 0);

    --divide units, tens, hundreds and thousands
    thousands <= "0000" when (binaryIn < 1000) else
                 "0001" when (binaryIn < 2000) else
                 "0010" when (binaryIn < 3000) else
                 "0011" when (binaryIn < 4000) else
                 "0100" when (binaryIn < 5000) else
                 "0101" when (binaryIn < 6000) else
                 "0110" when (binaryIn < 7000) else
                 "0111" when (binaryIn < 8000) else
                 "1000" when (binaryIn < 9000) else
                 "1001" when others;
    
    binaryINHundreds <= binaryIn - (thousands * 1000);

    hundreds <= "0000" when (binaryInHundreds < 100) else
                "0001" when (binaryInHundreds < 200) else
                "0010" when (binaryInHundreds < 300) else
                "0011" when (binaryInHundreds < 400) else
                "0100" when (binaryInHundreds < 500) else
                "0101" when (binaryInHundreds < 600) else
                "0110" when (binaryInHundreds < 700) else
                "0111" when (binaryInHundreds < 800) else
                "1000" when (binaryInHundreds < 900) else
                "1001" when others;

    binaryInTens <= binaryInHundreds - (hundreds * 100);

    tens <= "0000" when (binaryInTens < 10) else
            "0001" when (binaryInTens < 20) else
            "0010" when (binaryInTens < 30) else
            "0011" when (binaryInTens < 40) else
            "0100" when (binaryInTens < 50) else
            "0101" when (binaryInTens < 60) else
            "0110" when (binaryInTens < 70) else
            "0111" when (binaryInTens < 80) else
            "1000" when (binaryInTens < 90) else
            "1001" when others;

    unity <= binaryInTens - (tens * 10);
    

    process (clk)
    begin
        if (clk'event and clk = '1') then
            if (displayPosition < 3) then
                displayPosition <= displayPosition + 1;
            else
                displayPosition <= "00";
            end if;
        end if;
    end process;

    displayActive <= "1110" when (displayPosition = "00") else
                        "1101" when (displayPosition = "01") else
                        "1011" when (displayPosition = "10") else
                        "0111" when others;

    displayIn <= unity when (displayPosition = "00") else
                  tens when (displayPosition = "01") else
                  hundreds when (displayPosition = "10") else
                  thousands when others;
                  
    decoDisplay: decoDisplay port map (displayIn => displayIn, displayOut => displayOut);
end Behavioral;