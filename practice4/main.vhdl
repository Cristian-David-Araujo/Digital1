library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity main is
    Port ( clk, reset: in std_logic;
		   sw: in std_logic_vector(1 downto 0);
		   hsync, vsync: out std_logic;
		   rgb_out: out std_logic_vector(11 downto 0));
end main;

architecture Behavioral of main is

    component clkDivider is
        generic (countLimit : integer);
        Port (  clk : in STD_LOGIC;
                newClk : out STD_LOGIC
             );
    end component clkDivider;
    
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
    
    signal Hcount, Vcount, posX, posY:  std_logic_vector (10 downto 0);
	signal RGBin : STD_LOGIC_VECTOR (11 downto 0);
	signal clk20ns, clk60ms, drawBird : STD_LOGIC;
	
begin

    Inst_vga_ctrl_640x480_60Hz: vga_ctrl_640x480_60Hz 
    port map(
		rst => reset,
		clk => clk20ns,
		rgb_in => RGBin,
		HS => hsync,
		VS => vsync,
		hcount => Hcount,
		vcount => Vcount,
		rgb_out => rgb_out,
		blank => open
	);
	
	--Instans of clock
    --Clock 20ns
    -- generador de reloj de 50 MHZ
    process (clk)
        begin  
            if (clk'event and clk = '1') then
                clk20ns <= NOT clk20ns;
            end if;
        end process;
    
    --Clock 60ms
    clkDivider1ms : clkDivider
        generic map (countLimit => 3000000)
        Port map (clk => clk20ns,
                 newClk => clk60ms);
                         
    draw_Bird1: draw_Bird
        port map( clk => clk60ms,
                  posX => posX,
                  posY => posY,
                  Hcount => Hcount,
                  Vcount => Vcount,
                  draw => drawBird);
                          
    posX <= (others => '0');
    posY <= (others => '0');                  
    
    RGBin <= x"000" when (drawBird = '1' and posX + 15 >= Hcount and posY + 15 >= Vcount)  else
            x"FFF";
 
end Behavioral;