library ieee;
use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_unsigned.ALL;

Entity selector is
	Port(	w1: in std_logic_vector(5 downto 0);
			w2: in std_logic_vector(5 downto 0);
			s:  in std_logic;
			Q: out std_logic_vector(5 downto 0));
end selector;

Architecture sol of selector is
BEGIN
	Q<=w2 when s='1'else w1;
end sol;
