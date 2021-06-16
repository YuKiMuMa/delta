library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity delta is

    Port ( 	CLK : in std_logic;
			X_Pu_IN : in std_logic;
			X_Di_IN : in std_logic;
			Y_Pu_IN : in std_logic;
			Y_Di_IN : in std_logic;
			Z_Pu_IN : in std_logic;
			Z_Di_IN : in std_logic;
         A_Pu_OUT : out std_logic;
			A_Di_OUT : out std_logic;
			B_Pu_OUT : out std_logic;
			B_Di_OUT : out std_logic;
			C_Pu_OUT : out std_logic;
			C_Di_OUT : out std_logic);
end delta;

architecture Behavioral of delta is

	signal Adone : std_logic :='0';
	signal Adone2 : std_logic :='0';
	signal Abitt : std_logic_vector(36 downto 0);
	signal Bdone : std_logic :='0';
	signal Bdone2 : std_logic :='0';
	signal Bbitt : std_logic_vector(36 downto 0);
	signal Cdone : std_logic :='0';
	signal Cdone2 : std_logic :='0';
	signal Cbitt : std_logic_vector(36 downto 0);
	signal X_count_pos : std_logic_vector(18 downto 0);
	signal X_count_neg : std_logic_vector(18 downto 0);
	signal Y_count_pos : std_logic_vector(18 downto 0);
	signal Y_count_neg : std_logic_vector(18 downto 0);
	signal Z_count_pos : std_logic_vector(18 downto 0);
	signal A_count_pos : std_logic_vector(18 downto 0):="0000010111011110110";
	signal A_B : std_logic_vector(37 downto 0);
	signal A_res : std_logic_vector(36 downto 0);
	signal A_P : std_logic_vector(36 downto 0);
	signal A1 : std_logic;
	signal B_count_pos : std_logic_vector(18 downto 0):="0000010111011110110";
	signal B_B : std_logic_vector(37 downto 0);
	signal B_res : std_logic_vector(36 downto 0);
	signal B_P : std_logic_vector(36 downto 0);
	signal B1 : std_logic;
	signal C_count_pos : std_logic_vector(18 downto 0):="0000010111011110110";
	signal C_B : std_logic_vector(37 downto 0);
	signal C_res : std_logic_vector(36 downto 0);
	signal C_P : std_logic_vector(36 downto 0);
	signal C1 : std_logic;
	signal DD : std_logic_vector(13 downto 0);
	signal CLK100 : std_logic;
	
begin

process(CLK)
begin
	if CLK'event and CLK='1' then
		if DD < "10110001000000" then
			DD <= DD +'1';
		elsif DD = "10110001000000" then
			DD <= "00000000000000";
		end if;
	end if;
end process;

process(DD)
begin
	if DD="01011000100000" then
		CLK100 <= '1';
	elsif DD="00000000000000" then
		CLK100 <= '0';
	end if;
end process;


process (X_Pu_IN)	 
begin
   if X_Pu_IN'event and X_Pu_IN='1' then
		if X_count_pos="0000000000000000000" and X_count_neg="0000000000000000000" then
			if X_Di_IN = '1' then
				X_count_pos <= X_count_pos + '1';
			else
				X_count_neg <= X_count_neg + '1';
			end if;
		elsif X_count_pos > "0000000000000000000" then
			if X_Di_IN = '1' then
				X_count_pos <= X_count_pos + '1';
			else
				X_count_pos <= X_count_pos - '1';
			end if;
		elsif X_count_neg > "0000000000000000000" then
			if X_Di_IN = '0' then
				X_count_neg <= X_count_neg + '1';
			else
				X_count_neg <= X_count_neg - '1';
			end if;
		end if;
   end if;  
end process;

process (Y_Pu_IN)	 
begin
   if Y_Pu_IN'event and Y_Pu_IN='1' then
		if Y_count_pos="0000000000000000000" and Y_count_neg="0000000000000000000" then
			if Y_Di_IN = '1' then
				Y_count_pos <= Y_count_pos + '1';
			else
				Y_count_neg <= Y_count_neg + '1';
			end if;
		elsif Y_count_pos > "0000000000000000000" then
			if Y_Di_IN = '1' then
				Y_count_pos <= Y_count_pos + '1';
			else
				Y_count_pos <= Y_count_pos - '1';
			end if;
		elsif Y_count_neg > "0000000000000000000" then
			if Y_Di_IN = '0' then
				Y_count_neg <= Y_count_neg + '1';
			else
				Y_count_neg <= Y_count_neg - '1';
			end if;
		end if;
   end if;  
end process;

process (Z_Pu_IN)	 
begin
   if Z_Pu_IN'event and Z_Pu_IN='1' then
		if Z_Di_IN = '0' then
        	Z_count_pos <= Z_count_pos + '1';
		else
			Z_count_pos <= Z_count_pos - '1';
		end if;
   end if;  
end process;

process(CLK)
begin
	if CLK'event and CLK='1' then
		if Adone='0' then
			Abitt<= "1000000000000000000000000000000000000";
			A_res <= "0000000000000000000000000000000000000";
			Adone <='1';
			A_B <= (X_count_pos+X_count_neg)*(X_count_pos+X_count_neg)+("101011111100100000"-Y_count_pos+Y_count_neg)*("101011111100100000"-Y_count_pos+Y_count_neg)+("1010011000000100000"-Z_count_pos)*("1010011000000100000"-Z_count_pos);
		else
			if Adone2='0' then
				if Abitt > A_B then
					Abitt <= std_logic_vector(shift_right(unsigned(Abitt), 2));
				else
					Adone2 <= '1';
				end if;
			else
				if Abitt /= "0000000000000000000000000000000000000" then
					if A_B >= (A_res + Abitt) then
						A_B <= A_B - A_res - Abitt;
						A_res <= std_logic_vector(shift_right(unsigned(A_res), 1))+Abitt;
					else
						A_res <= std_logic_vector(shift_right(unsigned(A_res), 1));
					end if;
					Abitt <= std_logic_vector(shift_right(unsigned(Abitt), 2));
				else
					Adone <= '0';
					Adone2 <= '0';
					A_P <=std_logic_vector(shift_right(unsigned(A_res), 5));
				end if;
			end if;
		end if;
	end if;
end process;


process (CLK100)	 
begin
	if CLK100'event and CLK100='1' then
		if A_P>A_count_pos then
			A1<= '1';
			A_count_pos <= A_count_pos + '1';
			A_Di_OUT<='0';
		elsif A_P<A_count_pos then
			A1<= '1';
			A_count_pos <= A_count_pos - '1';
			A_Di_OUT<='1';
		else
			A1 <= '0';
		end if;
	end if;
end process;



process (CLK100,A1)	 
begin
	A_Pu_OUT<=CLK100 and A1;
end process;

process(CLK)
begin
	if CLK'event and CLK='1' then
		if Bdone='0' then
			Bbitt<= "1000000000000000000000000000000000000";
			B_res <= "0000000000000000000000000000000000000";
			Bdone <='1';
			B_B <= ("100110000011101100"+X_count_pos-X_count_neg)*("100110000011101100"+X_count_pos-X_count_neg)+("10101111110010000"+Y_count_pos-Y_count_neg)*("10101111110010000"+Y_count_pos-Y_count_neg)+("1010011000000100000"-Z_count_pos)*("1010011000000100000"-Z_count_pos);
		else
			if Bdone2='0' then
				if Bbitt > B_B then
					Bbitt <= std_logic_vector(shift_right(unsigned(Bbitt), 2));
				else
					Bdone2 <= '1';
				end if;
			else
				if Bbitt /= "0000000000000000000000000000000000000" then
					if B_B >= (B_res + Bbitt) then
						B_B <= B_B - B_res - Bbitt;
						B_res <= std_logic_vector(shift_right(unsigned(B_res), 1))+Bbitt;
					else
						B_res <= std_logic_vector(shift_right(unsigned(B_res), 1));
					end if;
					Bbitt <= std_logic_vector(shift_right(unsigned(Bbitt), 2));
				else
					Bdone <= '0';
					Bdone2 <= '0';
					B_P <=std_logic_vector(shift_right(unsigned(B_res), 5));
				end if;
			end if;
		end if;
	end if;
end process;


process (CLK100)	 
begin
	if CLK100'event and CLK100='1' then
		if B_P>B_count_pos then
			B1<= '1';
			B_count_pos <= B_count_pos + '1';
			B_Di_OUT<='0';
		elsif B_P<B_count_pos then
			B1<= '1';
			B_count_pos <= B_count_pos - '1';
			B_Di_OUT<='1';
		else
			B1 <= '0';
		end if;
	end if;
end process;

process (CLK100,B1)	 
begin
	B_Pu_OUT<=CLK100 and B1;
end process;

process(CLK)
begin
	if CLK'event and CLK='1' then
		if Cdone='0' then
			Cbitt<= "1000000000000000000000000000000000000";
			C_res <= "0000000000000000000000000000000000000";
			Cdone <='1';
			C_B <= ("100110000011101100"-X_count_pos+X_count_neg)*("100110000011101100"-X_count_pos+X_count_neg)+("10101111110010000"+Y_count_pos-Y_count_neg)*("10101111110010000"+Y_count_pos-Y_count_neg)+("1010011000000100000"-Z_count_pos)*("1010011000000100000"-Z_count_pos);
		else
			if Cdone2='0' then
				if Cbitt > C_B then
					Cbitt <= std_logic_vector(shift_right(unsigned(Cbitt), 2));
				else
					Cdone2 <= '1';
				end if;
			else
				if Cbitt /= "0000000000000000000000000000000000000" then
					if C_B >= (C_res + Cbitt) then
						C_B <= C_B - C_res - Cbitt;
						C_res <= std_logic_vector(shift_right(unsigned(C_res), 1))+Cbitt;
					else
						C_res <= std_logic_vector(shift_right(unsigned(C_res), 1));
					end if;
					Cbitt <= std_logic_vector(shift_right(unsigned(Cbitt), 2));
				else
					Cdone <= '0';
					Cdone2 <= '0';
					C_P <=std_logic_vector(shift_right(unsigned(C_res), 5));
				end if;
			end if;
		end if;
	end if;
end process;


process (CLK100)	 
begin
	if CLK100'event and CLK100='1' then
		if C_P>C_count_pos then
			C1<= '1';
			C_count_pos <= C_count_pos + '1';
			C_Di_OUT<='0';
		elsif C_P<C_count_pos then
			C1<= '1';
			C_count_pos <= C_count_pos - '1';
			C_Di_OUT<='1';
		else
			C1 <= '0';
		end if;
	end if;
end process;

process (CLK100,C1)	 
begin
	C_Pu_OUT<=CLK100 and C1;
end process;

end Behavioral;
