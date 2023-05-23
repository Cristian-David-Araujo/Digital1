library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity main is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end main;

architecture Behavioral of main is
    component vga_ctrl_640x480_60Hz is
    port(
        rst         : in std_logic;
        clk   : in std_logic;
        rgb_in     : in std_logic_vector(11 downto 0);     
        HS          : out std_logic;
        VS          : out std_logic;
        hcount      : out std_logic_vector(10 downto 0);
        vcount      : out std_logic_vector(10 downto 0);
        rgb_out     : out std_logic_vector(11 downto 0);
        blank       : out std_logic
    );
    end component;

    component draw_Bird is
    port(
        clk : in  STD_LOGIC;
        posX : in  STD_LOGIC_VECTOR (10 downto 0);
        posY : in  STD_LOGIC_VECTOR (10 downto 0);
        Hcount : in  STD_LOGIC_VECTOR (10 downto 0);
        Vcount : in  STD_LOGIC_VECTOR (10 downto 0);
        draw : out  STD_LOGIC
    );
    end component;
begin

end Behavioral;