-----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-----------------------------------------------------------
ENTITY VGA2 IS
	PORT 	(		clk				:	IN		STD_LOGIC;
					rst				:	IN		STD_LOGIC;
					btn1,btn2,btn3	:	IN		STD_LOGIC;
					Hsync				:	OUT	STD_LOGIC;
					Vsync				:	OUT	STD_LOGIC;
					ssega1			:	OUT   STD_LOGIC_VECTOR(6 DOWNTO 0);
					ssega2			:	OUT   STD_LOGIC_VECTOR(6 DOWNTO 0);
					R					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
					G					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
					B					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
					);
END ENTITY VGA2;
-----------------------------------------------------------
ARCHITECTURE rtl OF VGA2 IS
SIGNAL 	sem1,sem2:							STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL 	fondo:								STD_LOGIC_VECTOR(11 DOWNTO 0):="111100001111";
SIGNAL 	resto:								STD_LOGIC_VECTOR(11 DOWNTO 0):="000011110000";
SIGNAL	anclax :								INTEGER;
SIGNAL	anclay :								INTEGER;
SIGNAL 	clk1,btn1d,btn2d, btn3d:	 	STD_LOGIC;
SIGNAL	Vpos_S,Hpos_S:						INTEGER:=0;
SIGNAL	escenario	:						STD_LOGIC:='0';
SIGNAL	puntosL:				INTEGER:=0;
------------ HSYNC FP= 16, BP=48, SYNC= 96
------------ VSYNC FP=10, BP=33, SYNC=2
BEGIN

div_clk: PROCESS(clk)
	BEGIN
		IF(rising_edge(clk)) THEN
			clk1 <= NOT clk1;
		END IF;
	END PROCESS;

fondo<="000000000000";
resto<="111111111111";

PROCESS(clk1,rst,Hpos_S,Vpos_S,btn1d,btn2d,anclax,anclay) BEGIN

IF(rst = '1') THEN
	R<="0000";
	G<="0000";
	B<="0000";
	HPos_S<=0;
	Vpos_S<=0;

ELSIF(rising_edge(clk1))THEN


	IF(btn1d='1')THEN
	escenario<='1';
	END IF;

	IF(btn2d='1')THEN
	escenario<='0';
	END IF;
	
	
	IF(escenario='0')THEN
		IF(((240)>=Vpos_S AND Vpos_S>=200)AND(380>=Hpos_S AND Hpos_S>=360))THEN -- P
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);
			
			IF(((216)>=Vpos_S AND Vpos_S>=208)AND(373>=Hpos_S AND Hpos_S>=367))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			IF(((240)>=Vpos_S AND Vpos_S>=224)AND(380>=Hpos_S AND Hpos_S>=367))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
		
		ELSIF(((240)>=Vpos_S AND Vpos_S>=200)AND(410>=Hpos_S AND Hpos_S>=390))THEN -- A
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);
			
			IF(((216)>=Vpos_S AND Vpos_S>=208)AND(403>=Hpos_S AND Hpos_S>=397))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			IF(((240)>=Vpos_S AND Vpos_S>=224)AND(403>=Hpos_S AND Hpos_S>=397))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			
		ELSIF(((240)>=Vpos_S AND Vpos_S>=200)AND(440>=Hpos_S AND Hpos_S>=420))THEN -- U
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);
			IF(((232)>=Vpos_S AND Vpos_S>=200)AND(433>=Hpos_S AND Hpos_S>=427))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			
		ELSIF(((240)>=Vpos_S AND Vpos_S>=200)AND(470>=Hpos_S AND Hpos_S>=450))THEN -- S
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);
			
			IF(((216)>=Vpos_S AND Vpos_S>=208)AND(470>=Hpos_S AND Hpos_S>=457))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			IF(((232)>=Vpos_S AND Vpos_S>=224)AND(463>=Hpos_S AND Hpos_S>=450))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			
		ELSIF(((240)>=Vpos_S AND Vpos_S>=200)AND(500>=Hpos_S AND Hpos_S>=480))THEN -- E
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);
			IF(((216)>=Vpos_S AND Vpos_S>=208)AND(500>=Hpos_S AND Hpos_S>=487))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			IF(((232)>=Vpos_S AND Vpos_S>=224)AND(500>=Hpos_S AND Hpos_S>=487))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
		
		ELSIF(((300)>=Vpos_S AND Vpos_S>=260)AND(470>=Hpos_S AND Hpos_S>=450))THEN -- P
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);
			IF(((276)>=Vpos_S AND Vpos_S>=268)AND(463>=Hpos_S AND Hpos_S>=457))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			IF(((300)>=Vpos_S AND Vpos_S>=284)AND(470>=Hpos_S AND Hpos_S>=457))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			
		ELSIF(((300)>=Vpos_S AND Vpos_S>=260)AND(500>=Hpos_S AND Hpos_S>=480))THEN -- L
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);
			IF(((292)>=Vpos_S AND Vpos_S>=260)AND(500>=Hpos_S AND Hpos_S>=487))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			
		ELSIF(((300)>=Vpos_S AND Vpos_S>=260)AND(530>=Hpos_S AND Hpos_S>=510))THEN -- A
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);
			IF(((274)>=Vpos_S AND Vpos_S>=268)AND(523>=Hpos_S AND Hpos_S>=517))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			IF(((300)>=Vpos_S AND Vpos_S>=284)AND(523>=Hpos_S AND Hpos_S>=517))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			
		ELSIF(((300)>=Vpos_S AND Vpos_S>=260)AND(560>=Hpos_S AND Hpos_S>=540))THEN -- Y
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);
			IF(((276)>=Vpos_S AND Vpos_S>=260)AND(553>=Hpos_S AND Hpos_S>=547))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			IF(((300)>=Vpos_S AND Vpos_S>=284)AND(546>=Hpos_S AND Hpos_S>=540))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			IF(((300)>=Vpos_S AND Vpos_S>=284)AND(560>=Hpos_S AND Hpos_S>=554))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
			
		ELSE
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
	END IF;
	IF(escenario='1')THEN
		IF(((anclay+10)>=Vpos_S AND Vpos_S>=anclay)AND(anclax+10>=Hpos_S AND Hpos_S>=anclax))THEN
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);			
		ELSIF(((95)>=Vpos_S AND Vpos_S>=55)AND(350>=Hpos_S AND Hpos_S>=330))THEN--primer digito
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);			
			
		IF(sem1(3 DOWNTO 0)="0000")THEN--cero
			IF(((90)>=Vpos_S AND Vpos_S>=60)AND(345>=Hpos_S AND Hpos_S>=335))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
		END IF;
		
		IF(sem1(3 DOWNTO 0)="0001")THEN--uno
			IF(((95)>=Vpos_S AND Vpos_S>=55)AND(345>=Hpos_S AND Hpos_S>=330))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
		END IF;
		
		ELSIF(((95)>=Vpos_S AND Vpos_S>=55)AND(380>=Hpos_S AND Hpos_S>=360))THEN--segundo digito
			R	<=	resto(11 DOWNTO 8);
			G	<=	resto(7 DOWNTO 4);
			B	<=	resto(3 DOWNTO 0);
			
		IF(sem2(3 DOWNTO 0)="0000")THEN--cero
			IF(((90)>=Vpos_S AND Vpos_S>=60)AND(375>=Hpos_S AND Hpos_S>=365))THEN
				R	<=	fondo(11 DOWNTO 8);
				G	<=	fondo(7 DOWNTO 4);
				B	<=	fondo(3 DOWNTO 0);
			END IF;
		END IF;
	IF(sem2(3 DOWNTO 0)="0001")THEN--un0
		IF(((95)>=Vpos_S AND Vpos_S>=55)AND(375>=Hpos_S AND Hpos_S>=360))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
	END IF;
	IF(sem2(3 DOWNTO 0)="0010")THEN--dos
		IF(((70)>=Vpos_S AND Vpos_S>=60)AND(375>=Hpos_S AND Hpos_S>=360))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
		IF(((90)>=Vpos_S AND Vpos_S>=75)AND(380>=Hpos_S AND Hpos_S>=365))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
	END IF;
	
	IF(sem2(3 DOWNTO 0)="0011")THEN--tres
		IF(((70)>=Vpos_S AND Vpos_S>=60)AND(375>=Hpos_S AND Hpos_S>=360))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
		IF(((90)>=Vpos_S AND Vpos_S>=75)AND(375>=Hpos_S AND Hpos_S>=360))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
	END IF;
	
	IF(sem2(3 DOWNTO 0)="0100")THEN--cuatro
		IF(((70)>=Vpos_S AND Vpos_S>=55)AND(375>=Hpos_S AND Hpos_S>=365))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
		IF(((95)>=Vpos_S AND Vpos_S>=75)AND(375>=Hpos_S AND Hpos_S>=360))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
		
	END IF;
	IF(sem2(3 DOWNTO 0)="0101")THEN--cinco
		IF(((70)>=Vpos_S AND Vpos_S>=60)AND(380>=Hpos_S AND Hpos_S>=365))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
		IF(((90)>=Vpos_S AND Vpos_S>=75)AND(375>=Hpos_S AND Hpos_S>=360))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
	END IF;
	IF(sem2(3 DOWNTO 0)="0110")THEN--seis
		IF(((70)>=Vpos_S AND Vpos_S>=60)AND(380>=Hpos_S AND Hpos_S>=365))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
		IF(((90)>=Vpos_S AND Vpos_S>=75)AND(375>=Hpos_S AND Hpos_S>=365))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
	END IF;
	
	IF(sem2(3 DOWNTO 0)="0111")THEN--sIETE
		IF(((95)>=Vpos_S AND Vpos_S>=60)AND(375>=Hpos_S AND Hpos_S>=360))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
	END IF;
	
	IF(sem2(3 DOWNTO 0)="1000")THEN--OCHO
		IF(((70)>=Vpos_S AND Vpos_S>=60)AND(375>=Hpos_S AND Hpos_S>=365))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
		IF(((90)>=Vpos_S AND Vpos_S>=75)AND(375>=Hpos_S AND Hpos_S>=365))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
	END IF;
	
	IF(sem2(3 DOWNTO 0)="1001")THEN--NUEVE
		IF(((70)>=Vpos_S AND Vpos_S>=60)AND(375>=Hpos_S AND Hpos_S>=365))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
		IF(((95)>=Vpos_S AND Vpos_S>=75)AND(375>=Hpos_S AND Hpos_S>=360))THEN
			R	<=	fondo(11 DOWNTO 8);
			G	<=	fondo(7 DOWNTO 4);
			B	<=	fondo(3 DOWNTO 0);
		END IF;
	END IF;

	ELSIF((Hpos_S=473 OR Hpos_S=472 OR Hpos_S=487 OR Hpos_S=488) AND (Vpos_S mod 10 = 0))THEN
		R	<=	resto(11 DOWNTO 8);
		G	<=	resto(7 DOWNTO 4);
		B	<=	resto(3 DOWNTO 0);
		
	ELSE
		R	<=	fondo(11 DOWNTO 8);
		G	<=	fondo(7 DOWNTO 4);
		B	<=	fondo(3 DOWNTO 0);
	END IF;
END IF;
	--------------------------------------------------------------------------------------------------------------
	IF(HPos_S<800) THEN
		HPos_S<=Hpos_S+1;
	ELSE
		Hpos_S<=0;
		IF(VPos_S<525) THEN
			VPOs_S<=Vpos_S+1;
		ELSE
			Vpos_S<=0;
		END IF;
	END IF;
	--------------------------------------------------------------------------------------------------------------
	
	-- CONDICIONES PARA SENAL DE SINCRONIZACION EN H Y V
	IF(Hpos_S<112 AND hpos_S>16) THEN
		Hsync<= '0';
		ELSE
		Hsync<= '1';
	END IF;
			
	IF(Vpos_S>10 AND Vpos_S<12) THEN
		Vsync<= '0';
		ELSE
		Vsync<= '1';
	END IF;
END IF;
END PROCESS;

deboun1:ENTITY work.debouncing
						PORT MAP( clk    	=> clk1,
									 ena	  	=> '1',
									 rst 		=>rst,
									 sw		=>not(btn1),
									 debsw	=>btn1d);
deboun2:ENTITY work.debouncing
						PORT MAP( clk     => clk1,
									 ena	  	=> '1',
									 rst 		=>rst,
									 sw		=>not(btn2),
									 debsw	=>btn2d);
									
									 
deboun3:ENTITY work.debouncing
						PORT MAP( clk     => clk1,
									 ena	  	=> '1',
									 rst 		=>rst,
									 sw		=>not(btn3),
									 debsw	=>btn3d);
 
b0la:ENTITY work.ballcontroller
						PORT MAP( clk     => clk1,
									 esc		=>escenario,
									 btn1d   =>btn3d,
									 rst 		=>rst,
									 posix	=>anclax,
									 posiy	=>anclay,
									 puntosL	=>puntosL);	
									 
		sseg1a:ENTITY work.bin_to_sseg
						PORT MAP( bin     => sem1(3 DOWNTO 0),
									 sseg	  => ssega1);
		sseg2a:ENTITY work.bin_to_sseg
						PORT MAP( bin     => sem2(3 DOWNTO 0),
									 sseg	  => ssega2);
		
		sem1<=STD_LOGIC_VECTOR(to_unsigned(puntosL,13)/10);
		sem2<=STD_LOGIC_VECTOR((to_unsigned(puntosL,13)mod 10)/1);


							
END ARCHITECTURE rtl;
-----------------------------------------------------------