LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-----------------------------------------------------------
ENTITY ballcontroller IS

	PORT 	(		esc										:	IN		STD_LOGIC;
					clk											:	IN		STD_LOGIC;
					btn1d										:	IN		STD_LOGIC;
					rst											:	IN		STD_LOGIC;
					posix,posiy,puntosL			:	OUT		INTEGER
					
					);
END ENTITY ballcontroller;
-----------------------------------------------------------
ARCHITECTURE rtl OF ballcontroller IS
SIGNAL	anclax   	:	INTEGER:=480;
SIGNAL	anclay   	:	INTEGER:=280;
SIGNAL	aux   		:	INTEGER:=1;
SIGNAL	puntosLS 	:	INTEGER:=0;
SIGNAL	mxt,escenario   :	STD_LOGIC;
SIGNAL	tiempo   	: INTEGER:=130944;
SIGNAL	temp   		:	INTEGER:=0;


------------ HSYNC FP= 16, BP=48, SYNC= 96
------------ VSYNC FP=10, BP=33, SYNC=2
BEGIN
posix<=anclax;
posiy<=anclay;
puntosL<=puntosLS;
escenario<=esc;

PROCESS(clk,mxt,anclax,anclay,aux) BEGIN

IF(rising_edge(clk))THEN	
	
  IF(mxt='1')THEN
		anclax<=anclax+aux;
		anclay<=anclay;
	END IF;

	IF((Anclax > 474 AND Anclax < 486) AND (btn1d = '1') AND (temp = 0)) THEN
		aux<=0;
    temp<=1;
		puntosLS<=puntosLS+1;
		tiempo<=tiempo-4000;

	ELSIF((Anclax < 473 OR Anclax > 487	) AND (btn1d = '1') AND (temp = 0)) THEN
		aux<=0;
		anclax<=160;
		puntosLS<=0;
		tiempo<=130944;
		
	ELSIF(anclax<800 AND btn1d = '0')THEN
		aux<=1;
	END IF;

	IF(puntosLS=13)THEN
		puntosLS<=0;
		anclax<=160;
		anclay<=280;
		tiempo<=130944;
	END IF;
	
	IF(anclax=795)THEN
		anclax<=160;
		anclay<=280;
		temp<=0;
	END IF;
	
	END IF;
	
END PROCESS;
    
timerRY1: ENTITY work.univ_bin_counter
		GENERIC MAP(N=> 19)
		PORT MAP	(rst			=>	rst OR not(escenario),
					 ena			=>	'1',
					 clk			=>	clk,
					 load			=> '0',
					 num_in		=>	"0000000000000000000",
					 max			=>	STD_LOGIC_VECTOR(to_unsigned(tiempo,19)),
					 syn_clr		=>	'0',
					 up			=> '1',
					 max_tick	=>	mxt);
	 
END ARCHITECTURE rtl;
-----------------------------------------------------------