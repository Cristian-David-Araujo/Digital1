library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity draw_Bird is
    Port ( clk : in  STD_LOGIC;
           posX : in  STD_LOGIC_VECTOR (10 downto 0);
           posY : in  STD_LOGIC_VECTOR (10 downto 0);
           Hcount : in  STD_LOGIC_VECTOR (10 downto 0);
           Vcount : in  STD_LOGIC_VECTOR (10 downto 0);
           draw : out  STD_LOGIC);
end draw_Bird;

architecture Behavioral of draw_Bird is

    component ROM_Bird1 is
    port(
        address : in STD_LOGIC_VECTOR (3 downto 0);
        data : out STD_LOGIC_VECTOR (15 downto 0)
    );
    end component;

    component ROM_Bird2 is
    port(
        address : in STD_LOGIC_VECTOR (3 downto 0);
        data : out STD_LOGIC_VECTOR (15 downto 0)
    );
    end component;

    component ROM_Bird3 is
    port(
        address : in STD_LOGIC_VECTOR (3 downto 0);
        data : out STD_LOGIC_VECTOR (15 downto 0)
    );
    end component;

    signal frame : STD_LOGIC_VECTOR (1 downto 0);
    
    signal addressX_aux, addressY_aux : STD_LOGIC_VECTOR (10 downto 0);
    signal addressX, addressY : STD_LOGIC_VECTOR (3 downto 0);
    signal dataROM1, dataROM2, dataROM3, data : STD_LOGIC_VECTOR (15 downto 0);
begin


    --Instans of ROMs
    ROM_Bird1_1 : ROM_Bird1
    port map(
        address => addressY,
        data => dataROM1
    );

    ROM_Bird2_1 : ROM_Bird2
    port map(
        address => addressY,
        data => dataROM2
    );

    ROM_Bird3_1 : ROM_Bird3
    port map(
        address => addressY,
        data => dataROM3
    );

    --Count for multiplex the frame of bird
    process(clk)
    begin
        if clk'event and clk = '1' then
            if frame = "10" then
                frame <= "00";
            else
                frame <= frame + 1;
            end if;            
        end if;
    end process;

    addressY_aux <= Vcount - posY;
    addressY <= addressY_aux(3 downto 0);
    addressX_aux <= Hcount - posX;
    addressX <= addressX_aux(3 downto 0);

    data <= dataROM1 when frame = "00" else
            dataROM2 when frame = "01" else
            dataROM3;
    
    draw <= data(to_integer(unsigned(addressX(3 downto 0))));
    
end Behavioral;