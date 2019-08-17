LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY RELOJ IS 
	PORT(PB_SIN_REBOTE,CLOCK: IN STD_LOGIC;
			UN_PULSO: OUT STD_LOGIC);
	END RELOJ;

ARCHITECTURE sol OF RELOJ IS
	SIGNAL PB_debounced_delay, Power_on : STD_LOGIC;
	BEGIN
		PROCESS
		BEGIN
		WAIT UNTIL(CLOCK'EVENT) AND (CLOCK='1');
		IF Power_on= '0' then
			UN_PULSO <= '0';
			PB_debounced_delay <='1';
			Power_on <= '1';
		ELSE 
			IF PB_SIN_REBOTE= '1' AND PB_debounced_delay = '0' THEN
				UN_PULSO <= '1';
			ELSE
				UN_PULSO <= '0';
			END IF;
			PB_debounced_delay <= PB_SIN_REBOTE;
		END IF;
		END PROCESS;
END sol;