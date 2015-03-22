EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:65xx
LIBS:cpu-board
LIBS:IC_raspberry
LIBS:cpu-board-cache
EELAYER 24 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 4
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 7600 1400 0    60   ~ 0
A0
Text Label 7600 1500 0    60   ~ 0
A1
Text Label 7600 1600 0    60   ~ 0
A2
Text Label 7600 1700 0    60   ~ 0
A3
Text Label 7600 1800 0    60   ~ 0
A4
Text Label 7600 1900 0    60   ~ 0
A5
Text Label 7600 2000 0    60   ~ 0
A6
Text Label 7600 2100 0    60   ~ 0
A7
Text Label 7600 2300 0    60   ~ 0
A8
Text Label 7600 2400 0    60   ~ 0
A9
Text Label 7600 2500 0    60   ~ 0
A10
Text Label 7600 2600 0    60   ~ 0
A11
Text Label 7600 2700 0    60   ~ 0
A12
Text Label 7600 2800 0    60   ~ 0
A13
Text Label 7600 3000 0    60   ~ 0
A15
Text Label 5950 1400 0    60   ~ 0
D0
Text Label 5950 1500 0    60   ~ 0
D1
Text Label 5950 1600 0    60   ~ 0
D2
Text Label 5950 1700 0    60   ~ 0
D3
Text Label 5950 1800 0    60   ~ 0
D4
Text Label 5950 1900 0    60   ~ 0
D5
Text Label 5950 2000 0    60   ~ 0
D6
Text Label 5950 2100 0    60   ~ 0
D7
Text Label 7600 2900 0    60   ~ 0
A14
Text GLabel 4650 1900 0    60   Input ~ 0
SYNC
Text GLabel 4450 2400 0    60   Input ~ 0
R/~W
Text GLabel 4450 2200 0    60   Input ~ 0
PHI2
Text GLabel 4700 2100 0    60   Input ~ 0
~RST
Text GLabel 4650 1700 0    60   Output ~ 0
~IRQ
Text GLabel 4300 1600 0    60   Output ~ 0
RDY
Text GLabel 4700 2300 0    60   Output ~ 0
BE
$Comp
L CONN_8 P3
U 1 1 550DBACF
P 6700 1750
F 0 "P3" V 6650 1750 60  0000 C CNN
F 1 "DATA" V 6750 1750 60  0000 C CNN
F 2 "" H 6700 1750 60  0000 C CNN
F 3 "" H 6700 1750 60  0000 C CNN
	1    6700 1750
	1    0    0    -1  
$EndComp
$Comp
L CONN_8 P5
U 1 1 550DBAD5
P 8350 1750
F 0 "P5" V 8300 1750 60  0000 C CNN
F 1 "ADDR1" V 8400 1750 60  0000 C CNN
F 2 "" H 8350 1750 60  0000 C CNN
F 3 "" H 8350 1750 60  0000 C CNN
	1    8350 1750
	1    0    0    -1  
$EndComp
$Comp
L CONN_8 P6
U 1 1 550DBADB
P 8350 2650
F 0 "P6" V 8300 2650 60  0000 C CNN
F 1 "ADDR2" V 8400 2650 60  0000 C CNN
F 2 "" H 8350 2650 60  0000 C CNN
F 3 "" H 8350 2650 60  0000 C CNN
	1    8350 2650
	1    0    0    -1  
$EndComp
$Comp
L CONN_6 P1
U 1 1 550DBAE1
P 5150 1650
F 0 "P1" V 5100 1650 60  0000 C CNN
F 1 "CTRL1" V 5200 1650 60  0000 C CNN
F 2 "" H 5150 1650 60  0000 C CNN
F 3 "" H 5150 1650 60  0000 C CNN
	1    5150 1650
	1    0    0    -1  
$EndComp
$Comp
L CONN_6 P2
U 1 1 550DBAE7
P 5150 2350
F 0 "P2" V 5100 2350 60  0000 C CNN
F 1 "CTRL2" V 5200 2350 60  0000 C CNN
F 2 "" H 5150 2350 60  0000 C CNN
F 3 "" H 5150 2350 60  0000 C CNN
	1    5150 2350
	1    0    0    -1  
$EndComp
NoConn ~ 4800 2500
NoConn ~ 4800 2600
Wire Wire Line
	6350 1400 5950 1400
Wire Wire Line
	5950 1500 6350 1500
Wire Wire Line
	6350 1600 5950 1600
Wire Wire Line
	5950 1700 6350 1700
Wire Wire Line
	6350 1800 5950 1800
Wire Wire Line
	5950 1900 6350 1900
Wire Wire Line
	6350 2000 5950 2000
Wire Wire Line
	5950 2100 6350 2100
Wire Wire Line
	7600 1400 8000 1400
Wire Wire Line
	8000 1500 7600 1500
Wire Wire Line
	7600 1600 8000 1600
Wire Wire Line
	8000 1700 7600 1700
Wire Wire Line
	7600 1800 8000 1800
Wire Wire Line
	8000 1900 7600 1900
Wire Wire Line
	7600 2000 8000 2000
Wire Wire Line
	8000 2100 7600 2100
Wire Wire Line
	8000 2400 7600 2400
Wire Wire Line
	7600 2800 8000 2800
Wire Wire Line
	8000 2300 7600 2300
Wire Wire Line
	7600 2700 8000 2700
Wire Wire Line
	7600 2500 8000 2500
Wire Wire Line
	8000 2600 7600 2600
Wire Wire Line
	7600 2900 8000 2900
Wire Wire Line
	8000 3000 7600 3000
Wire Wire Line
	4800 2100 4700 2100
Wire Wire Line
	4800 1600 4300 1600
Wire Wire Line
	4450 2200 4800 2200
Wire Wire Line
	4650 1900 4800 1900
Wire Wire Line
	4800 2300 4700 2300
Wire Wire Line
	4450 2400 4800 2400
Wire Wire Line
	4800 1700 4650 1700
Wire Wire Line
	4800 1800 4300 1800
Wire Wire Line
	4000 1500 4800 1500
Text Label 1950 900  2    60   ~ 0
A0
Text Label 1950 1000 2    60   ~ 0
A1
Text Label 1950 1100 2    60   ~ 0
A2
Text Label 1950 1200 2    60   ~ 0
A3
Text Label 1950 1300 2    60   ~ 0
A4
Text Label 1950 1400 2    60   ~ 0
A5
Text Label 1950 1500 2    60   ~ 0
A6
Text Label 1950 1600 2    60   ~ 0
A7
Text Label 1950 1700 2    60   ~ 0
A8
Text Label 1950 1800 2    60   ~ 0
A9
Text Label 1950 1900 2    60   ~ 0
A10
Text Label 1950 2000 2    60   ~ 0
A11
Text Label 1950 2200 2    60   ~ 0
A13
Text Label 1950 2300 2    60   ~ 0
A14
Text Label 1950 2400 2    60   ~ 0
A15
Text Label 1950 2100 2    60   ~ 0
A12
Text GLabel 1400 900  0    60   BiDi ~ 0
A0
Text GLabel 1650 1000 0    60   BiDi ~ 0
A1
Text GLabel 1400 1100 0    60   BiDi ~ 0
A2
Text GLabel 1650 1200 0    60   BiDi ~ 0
A3
Text GLabel 1400 1300 0    60   BiDi ~ 0
A4
Text GLabel 1650 1400 0    60   BiDi ~ 0
A5
Text GLabel 1400 1500 0    60   BiDi ~ 0
A6
Text GLabel 1650 1600 0    60   BiDi ~ 0
A7
Text GLabel 1400 1700 0    60   BiDi ~ 0
A8
Text GLabel 1650 1800 0    60   BiDi ~ 0
A9
Text GLabel 1400 1900 0    60   BiDi ~ 0
A10
Text GLabel 1650 2000 0    60   BiDi ~ 0
A11
Text GLabel 1400 2100 0    60   BiDi ~ 0
A12
Text GLabel 1650 2200 0    60   BiDi ~ 0
A13
Text GLabel 1400 2300 0    60   BiDi ~ 0
A14
Text GLabel 1650 2400 0    60   BiDi ~ 0
A15
Wire Wire Line
	1950 2400 1650 2400
Wire Wire Line
	1400 2300 1950 2300
Wire Wire Line
	1950 2200 1650 2200
Wire Wire Line
	1400 2100 1950 2100
Wire Wire Line
	1950 2000 1650 2000
Wire Wire Line
	1400 1900 1950 1900
Wire Wire Line
	1950 1800 1650 1800
Wire Wire Line
	1400 1700 1950 1700
Wire Wire Line
	1950 1600 1650 1600
Wire Wire Line
	1400 1500 1950 1500
Wire Wire Line
	1950 1400 1650 1400
Wire Wire Line
	1950 1300 1400 1300
Wire Wire Line
	1650 1200 1950 1200
Wire Wire Line
	1950 1100 1400 1100
Wire Wire Line
	1650 1000 1950 1000
Wire Wire Line
	1950 900  1400 900 
Text Label 1950 2700 2    60   ~ 0
D0
Text Label 1950 2800 2    60   ~ 0
D1
Text Label 1950 2900 2    60   ~ 0
D2
Text Label 1950 3000 2    60   ~ 0
D3
Text Label 1950 3100 2    60   ~ 0
D4
Text Label 1950 3200 2    60   ~ 0
D5
Text Label 1950 3300 2    60   ~ 0
D6
Text Label 1950 3400 2    60   ~ 0
D7
Text GLabel 1400 2700 0    60   BiDi ~ 0
D0
Text GLabel 1650 2800 0    60   BiDi ~ 0
D1
Text GLabel 1400 2900 0    60   BiDi ~ 0
D2
Text GLabel 1650 3000 0    60   BiDi ~ 0
D3
Text GLabel 1400 3100 0    60   BiDi ~ 0
D4
Text GLabel 1650 3200 0    60   BiDi ~ 0
D5
Text GLabel 1400 3300 0    60   BiDi ~ 0
D6
Text GLabel 1650 3400 0    60   BiDi ~ 0
D7
Wire Wire Line
	1950 3400 1650 3400
Wire Wire Line
	1400 3300 1950 3300
Wire Wire Line
	1950 3200 1650 3200
Wire Wire Line
	1950 3100 1400 3100
Wire Wire Line
	1650 3000 1950 3000
Wire Wire Line
	1950 2900 1400 2900
Wire Wire Line
	1650 2800 1950 2800
Wire Wire Line
	1950 2700 1400 2700
Wire Wire Line
	4700 3900 4500 3900
Wire Wire Line
	4700 4100 4500 4100
$Comp
L BARREL_JACK CON1
U 1 1 550DC86C
P 5000 4000
F 0 "CON1" H 5000 4250 60  0000 C CNN
F 1 "BARREL_JACK" H 5000 3800 60  0000 C CNN
F 2 "" H 5000 4000 60  0000 C CNN
F 3 "" H 5000 4000 60  0000 C CNN
	1    5000 4000
	-1   0    0    -1  
$EndComp
$Comp
L CONN_8 P4
U 1 1 550DDF61
P 6700 2900
F 0 "P4" V 6650 2900 60  0000 C CNN
F 1 "IO" V 6750 2900 60  0000 C CNN
F 2 "" H 6700 2900 60  0000 C CNN
F 3 "" H 6700 2900 60  0000 C CNN
	1    6700 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 2550 5950 2550
Wire Wire Line
	6350 2650 6200 2650
Wire Wire Line
	6350 2750 5950 2750
Wire Wire Line
	6350 2850 6200 2850
Wire Wire Line
	6350 2950 5950 2950
Wire Wire Line
	6350 3050 6200 3050
Wire Wire Line
	6350 3150 5950 3150
Wire Wire Line
	6350 3250 6200 3250
Text GLabel 5950 2550 0    60   Output ~ 0
~IO0
Text GLabel 6200 2650 0    60   Output ~ 0
~IO1
Text GLabel 5950 2750 0    60   Output ~ 0
~IO2
Text GLabel 6200 2850 0    60   Output ~ 0
~IO3
Text GLabel 5950 2950 0    60   Output ~ 0
~IO4
Text GLabel 6200 3050 0    60   Output ~ 0
~IO5
Text GLabel 5950 3150 0    60   Output ~ 0
~IO6
Text GLabel 6200 3250 0    60   Output ~ 0
~IO7
Text GLabel 4300 1800 0    60   UnSpc ~ 0
VIN
$Comp
L +5V #PWR49
U 1 1 550DF30D
P 4650 1350
F 0 "#PWR49" H 4650 1440 20  0001 C CNN
F 1 "+5V" H 4650 1440 30  0000 C CNN
F 2 "" H 4650 1350 60  0000 C CNN
F 3 "" H 4650 1350 60  0000 C CNN
	1    4650 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 1350 4650 1400
Wire Wire Line
	4650 1400 4800 1400
Text GLabel 4450 3850 0    60   UnSpc ~ 0
VIN
$Comp
L GND #PWR48
U 1 1 550DF532
P 4000 1550
F 0 "#PWR48" H 4000 1550 30  0001 C CNN
F 1 "GND" H 4000 1480 30  0001 C CNN
F 2 "" H 4000 1550 60  0000 C CNN
F 3 "" H 4000 1550 60  0000 C CNN
	1    4000 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 1500 4000 1550
Wire Wire Line
	4450 3850 4500 3850
Wire Wire Line
	4500 3850 4500 3900
Wire Wire Line
	4500 4100 4500 4150
Wire Wire Line
	4500 4150 4450 4150
Text GLabel 4450 4150 0    60   UnSpc ~ 0
GND
NoConn ~ 4700 4000
$Comp
L PWR_FLAG #FLG1
U 1 1 550E4BE7
P 4600 3850
F 0 "#FLG1" H 4600 3945 30  0001 C CNN
F 1 "PWR_FLAG" H 4600 4030 30  0000 C CNN
F 2 "" H 4600 3850 60  0000 C CNN
F 3 "" H 4600 3850 60  0000 C CNN
	1    4600 3850
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG2
U 1 1 550E4BF9
P 4600 4150
F 0 "#FLG2" H 4600 4245 30  0001 C CNN
F 1 "PWR_FLAG" H 4600 4330 30  0000 C CNN
F 2 "" H 4600 4150 60  0000 C CNN
F 3 "" H 4600 4150 60  0000 C CNN
	1    4600 4150
	-1   0    0    1   
$EndComp
Wire Wire Line
	4600 4100 4600 4150
Connection ~ 4600 4100
Wire Wire Line
	4600 3850 4600 3900
Connection ~ 4600 3900
$EndSCHEMATC
