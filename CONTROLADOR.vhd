--By macaagui
LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;
ENTITY CONTROLADOR IS
	PORT(clock,On_Off,Run_Prog,P,TA_TR,T60,TA,TR,sum: IN STD_LOGIC;
		 --Verde_Vehiculo,Amarillo_Vehiculo,Rojo_Vehiculo,Rojo_Peaton,Verde_Peaton: OUT STD_LOGIC;
		 semaforo: OUT STD_LOGIC_VECTOR (4 downto 0);
		 resets: OUT STD_LOGIC_VECTOR(2 downto 0);
		 enables: OUT STD_LOGIC_VECTOR(4 downto 0));
END CONTROLADOR;
Architecture sol of CONTROLADOR is
Type estado is (A,B,B2,C,D,E,F,G,H,I,J,K,L,M);
SIGNAL y:estado;
SIGNAL datain:std_logic_vector (6 downto 0);
BEGIN
	--En60<=enables(6);EnTa<=enables(5);EnTr<=enables(4);EnAc<=enables(3);EnTaR<=enables(2);EnTrR<=enables(1);EnDisplay<=enables(0);
	--Reset60<=resets(2);ResetAc<=resets(1);ResetR<=resets(0);
	PROCESS(clock,On_Off)
		BEGIN
			if On_Off='0' then y<=A;
			elsif (clock'event and clock='1')then
				case y is
					when A=>
						if Run_Prog='1' then y<=G;
						else y<=B;end if;
					when B=>
						if Run_Prog='1' then y<=A;
						elsif P='1' or T60='1' then y<=B2;
						else y<=B;end if;
					when B2=> y<=c;
					when C=>
						if Run_Prog='1' then y<=G;
						elsif TA='1' then y<=D;
						else y<=C;end if;
					when D=> y<=E;
					when E=>
						if Run_Prog='1' then y<=G;
						elsif TR='1' then y<=F;
						else y<=E;end if;
					when F=> y<=B;
					
					when G=>
						if Run_Prog='0' then y<=A;
						elsif TA_TR='0' then y<=H;
						elsif TA_TR='1' then y<=I;
						else y<=G;end if;
						
					when H=>						
						if Run_Prog='0' then y<=A;
						elsif TA_TR='1' then y<=I;
						elsif P='1' then y<=J;
						else y<=H;end if;
					when I=>
						if Run_Prog='0' then y<=A;
						elsif P='1' then y<=K;
						elsif TA_TR='0' and P='0' then y<=H;
						else y<=I;end if;
					
					when J=>	if P='0' then y<=L;else y<=J;end if;
					when K=>	if P='0' then y<=M;else y<=K;end if;
					
					when L=> if sum='1' then y<=H;else y<=L;end if;
					when M=> if sum='1' then y<=I;else y<=M;end if;
				end case;
			end if;
	END PROCESS;
	PROCESS(y,Run_Prog,TA,TR,TA_TR,P,sum)
	BEGIN
	semaforo<="00000";
	enables<="00000";
	resets<="000";
	case y is
		when A=>semaforo<="11111";
			if Run_Prog = '0' then resets<="100";end if;
		when B=>
			semaforo<="10010";
			enables<="10000";
		when B2=> resets<="100";semaforo<="10010";enables<="10000";
		when C=>
			semaforo<="01010";
			enables<="10000";
		when D=>semaforo<="01010";resets<="100";enables<="10000";
		when E=>
			semaforo<="00101";
			enables<="10000";
		when F=>semaforo<="00101";resets<="100";enables<="10001";
		when G=>resets<="111";semaforo<="11111";
		when H=>enables<="00001";semaforo<="11100";
			if TA_TR='1' and P='0' then resets<="010";end if;
		when I=>enables<="00001";semaforo<="00011";
			if TA_TR='0' and P='0' then resets<="010";end if;
		when J=>enables<="00001";semaforo<="11100";
		when K=>enables<="00001";semaforo<="00011";
		when L=>enables<="01101";semaforo<="11100";
			if sum='1' then enables<="00101";end if;
		when M=>enables<="01011";semaforo<="00011";
			if sum='1' then enables<="00011";end if;
	end case;
	END PROCESS;
end sol;
