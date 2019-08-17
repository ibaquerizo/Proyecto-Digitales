library ieee;
use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_unsigned.ALL;

Entity comparador is
	Port(	w1: in std_logic_vector(5 downto 0);
			w2: in std_logic_vector(5 downto 0);
			igual: out std_logic);
end comparador;

Architecture sol of comparador is
BEGIN
		igual<='1' when w1=w2 else '0';
		
end sol;
