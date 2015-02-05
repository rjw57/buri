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
LIBS:IC_raspberry
EELAYER 24 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 2
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L RASPBERRY_IO P1
U 1 1 54D3AE92
P 2000 1800
F 0 "P1" H 2000 2500 60  0000 C CNN
F 1 "RASPBERRY_IO" V 2000 1800 50  0000 C CNN
F 2 "" H 2000 1800 60  0000 C CNN
F 3 "" H 2000 1800 60  0000 C CNN
	1    2000 1800
	1    0    0    -1  
$EndComp
NoConn ~ 1600 1200
Text Label 2650 1400 2    60   ~ 0
GND
Wire Wire Line
	2400 1400 2650 1400
NoConn ~ 1600 1300
NoConn ~ 1600 1400
NoConn ~ 1600 1500
NoConn ~ 1600 1800
NoConn ~ 1600 1900
NoConn ~ 1600 2100
NoConn ~ 1600 2200
NoConn ~ 1600 2300
NoConn ~ 2400 2400
NoConn ~ 2400 2300
NoConn ~ 2400 2200
NoConn ~ 2400 2000
NoConn ~ 2400 1900
NoConn ~ 2400 1600
NoConn ~ 2400 1500
Text Label 2650 1200 2    60   ~ 0
VCC
Wire Wire Line
	2400 1200 2650 1200
Text Label 3550 1950 0    60   ~ 0
GND
Wire Wire Line
	3550 1950 4050 1950
Wire Wire Line
	4050 1950 4450 1950
Wire Wire Line
	4450 1950 4650 1950
Text Label 3550 1350 0    60   ~ 0
VCC
Wire Wire Line
	3550 1350 4050 1350
Wire Wire Line
	4050 1350 4450 1350
Wire Wire Line
	4450 1350 4650 1350
$Comp
L CP1 C1
U 1 1 54D3AF68
P 4050 1650
F 0 "C1" H 4100 1750 50  0000 L CNN
F 1 "100uF" H 4100 1550 50  0000 L CNN
F 2 "" H 4050 1650 60  0000 C CNN
F 3 "" H 4050 1650 60  0000 C CNN
	1    4050 1650
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 54D3AF8F
P 4450 1650
F 0 "C2" H 4450 1750 40  0000 L CNN
F 1 "10nF" H 4456 1565 40  0000 L CNN
F 2 "" H 4488 1500 30  0000 C CNN
F 3 "" H 4450 1650 60  0000 C CNN
	1    4450 1650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 54D3AFAF
P 4650 2000
F 0 "#PWR01" H 4650 2000 30  0001 C CNN
F 1 "GND" H 4650 1930 30  0001 C CNN
F 2 "" H 4650 2000 60  0000 C CNN
F 3 "" H 4650 2000 60  0000 C CNN
	1    4650 2000
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR02
U 1 1 54D3AFC3
P 4650 1300
F 0 "#PWR02" H 4650 1390 20  0001 C CNN
F 1 "+5V" H 4650 1390 30  0000 C CNN
F 2 "" H 4650 1300 60  0000 C CNN
F 3 "" H 4650 1300 60  0000 C CNN
	1    4650 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 1350 4650 1300
Wire Wire Line
	4650 1950 4650 2000
Wire Wire Line
	4050 1850 4050 1950
Connection ~ 4050 1950
Wire Wire Line
	4450 1850 4450 1950
Connection ~ 4450 1950
Wire Wire Line
	4450 1350 4450 1450
Connection ~ 4450 1350
Wire Wire Line
	4050 1350 4050 1450
Connection ~ 4050 1350
$Sheet
S 8400 1450 900  500 
U 54D3B1AE
F0 "Single cycling" 50
F1 "single-cycle.sch" 50
F2 "HALT" I L 8400 1600 60 
F3 "STEP" I L 8400 1800 60 
$EndSheet
Text GLabel 1450 1700 0    60   Output ~ 0
PHI2
Wire Wire Line
	1450 1700 1600 1700
Text GLabel 2550 1700 2    60   BiDi ~ 0
RDY
Wire Wire Line
	2400 1700 2550 1700
Text Notes 3550 1100 0    60   ~ 0
AT P1
$Comp
L GND #PWR03
U 1 1 54D3C2C2
P 8200 2000
F 0 "#PWR03" H 8200 2000 30  0001 C CNN
F 1 "GND" H 8200 1930 30  0001 C CNN
F 2 "" H 8200 2000 60  0000 C CNN
F 3 "" H 8200 2000 60  0000 C CNN
	1    8200 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	8400 1600 8200 1600
Wire Wire Line
	8200 1600 8200 1800
Wire Wire Line
	8200 1800 8200 2000
Wire Wire Line
	8400 1800 8200 1800
Connection ~ 8200 1800
Text GLabel 1150 1800 0    60   Output ~ 0
SYNC
Wire Wire Line
	1150 1800 1600 1800
$EndSCHEMATC
