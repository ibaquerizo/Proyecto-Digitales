LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY contador_60seg IS
	PORT(clock,enable,reset : IN STD_LOGIC;
		 sesenta_seg : OUT STD_LOGIC;
		 Q : Buffer STD_LOGIC_VECTOR (5 downto 0));
END contador_60seg;

ARCHITECTURE sol OF contador_60seg IS
BEGIN

	PROCESS(clock,reset)
	BEGIN
		if reset='1' then 
			Q<="000000"; 
  		elsif (clock'event and clock='1') then
			if enable='1' then
				if (Q="111100") then 
					Q<="000000";
				else 
					Q<=Q+1;
				end if;
			end if;
		end if;
	END PROCESS;
	sesenta_seg<='1'when Q="111100" else '0';
END sol;
