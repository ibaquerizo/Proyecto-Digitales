LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY acumulador IS
	PORT(reset, en : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 sum: out STD_LOGIC;
		 Q : buffer STD_LOGIC_VECTOR (5 downto 0));
END acumulador;

ARCHITECTURE sol OF acumulador IS
SIGNAL temp: STD_LOGIC_VECTOR(5 downto 0);
BEGIN
	PROCESS(clock, reset)
	BEGIN
		if (reset='1') then temp<="000000";
		elsif (clock='1' and clock'event) then 
			if(en='1') then 
				temp<=temp+1;
				sum<='1';
			else 
				sum<='0';
			end if;
		end if;
	END PROCESS;
	Q<=temp;
END sol;
