library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--========================================================================
--This code in VHDL is for implement of a ALU with the next operations:
-- if operationSelect = "000" then operationOut <= A or B
-- if operationSelect = "001" then operationOut <= A + B
-- if operationSelect = "010" then operationOut <= not B
-- if operationSelect = "011" then operationOut <= A + 2
-- if operationSelect = "100" then operationOut <= A - 2, but if A < 2 then operationOut <= 0;
-- if operationSelect = "101" then operationOut <= show an "-" in the display
-- if operationSelect = "110" then operationOut <= B*2
-- if operationSelect = "111" then operationOut <= A + B, but if A + B > 24 then operationOut <= 0;
--========================================================================

entity ALU is
    Port ( A : in std_logic_vector(3 downto 0);
           B : in std_logic_vector(3 downto 0);
           opcode : in std_logic_vector(2 downto 0);
           S : out std_logic_vector(3 downto 0);
           CarryOut : out STD_LOGIC
           );
end ALU;

architecture Behavioral of ALU is
    signal ALUout : std_logic_vector(4 downto 0);

begin
    process(A, B, opcode)
    begin
        case opcode is
            when "000" => -- OR operation
                ALUout <= "0" & (A or B);
            when "001" => -- ADD operation
                ALUout <= ("0" &  A) + ("0" & B);
            when "010" => -- NOT operation
                ALUout <= "0" & not B;
            when "011" => -- ADD 2 operation   
                ALUout <= "0" & A + 2;
            when "100" => -- SUB 2 operation
                if A < "0010" then
                    ALUout <= "00000";
                else
                    ALUout <= "0" & A - 2;
                end if;
            when "101" => -- SET operation
                ALUout <= "01111";
            when "110" => -- MUL by 2 operation
                ALUout <= B & "0";
            when "111" => -- ADD and check for overflow operation
                if ("0" &  A) + ("0" & B) > "11000" then
                    ALUout <= "10100";
                else
                    ALUout <=("0" &  A) + ("0" & B);
                end if;
            when others => -- default operation
                ALUout <= "00000";
        end case;
    end process;

    S <= ALUout(3 downto 0);
    CarryOut <= ALUout(4);
end Behavioral;