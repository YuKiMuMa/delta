library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity delta2 is

    Port ( Pul : in std_logic;
           CLK : in std_logic;
           CE : out std_logic);
end delta2;

architecture Behavioral of delta2 is

	signal Count1 : std_logic_vector(10 downto 0);
	signal Count2 : std_logic_vector(10 downto 0);
	signal ans : std_logic_vector(21 downto 0);
	signal C1 : std_logic;
	
begin

process (Pul)	 
begin
   if Pul'event and Pul='1' then
        Count1 <= Count1 + '1';
   end if;  
end process;

process (Count1)	 
begin
	ans <= Count1 * Count1*;
end process;


process (CLK)	 
begin
	if CLK'event and CLK='1' then
		if ans>Count2 then
			C1<= '1';
			Count2 <= Count2 + '1';
		else
			C1 <= '0';
		end if;
	end if;
end process;

process (CLK)	 
begin
	CE<=CLK and C1;
end process;


end Behavioral;
