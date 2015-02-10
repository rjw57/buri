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
LIBS:IHE
LIBS:monitor-board-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title "6502 Computer - Compute Board"
Date "10 feb 2015"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 9300 4950 0    60   ~ 0
GND
Wire Wire Line
	9300 4950 10400 4950
Text Label 9300 4350 0    60   ~ 0
VCC
Wire Wire Line
	9300 4350 10400 4350
$Comp
L CP1 C1
U 1 1 54D64A77
P 9800 4650
F 0 "C1" H 9850 4750 50  0000 L CNN
F 1 "100uF" H 9850 4550 50  0000 L CNN
F 2 "" H 9800 4650 60  0000 C CNN
F 3 "" H 9800 4650 60  0000 C CNN
	1    9800 4650
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 54D64A78
P 10200 4650
F 0 "C2" H 10200 4750 40  0000 L CNN
F 1 "10nF" H 10206 4565 40  0000 L CNN
F 2 "" H 10238 4500 30  0000 C CNN
F 3 "" H 10200 4650 60  0000 C CNN
	1    10200 4650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 54D64A79
P 10400 5000
F 0 "#PWR01" H 10400 5000 30  0001 C CNN
F 1 "GND" H 10400 4930 30  0001 C CNN
F 2 "" H 10400 5000 60  0000 C CNN
F 3 "" H 10400 5000 60  0000 C CNN
	1    10400 5000
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR02
U 1 1 54D64A7A
P 10400 4300
F 0 "#PWR02" H 10400 4390 20  0001 C CNN
F 1 "+5V" H 10400 4390 30  0000 C CNN
F 2 "" H 10400 4300 60  0000 C CNN
F 3 "" H 10400 4300 60  0000 C CNN
	1    10400 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	10400 4350 10400 4300
Wire Wire Line
	10400 4950 10400 5000
Wire Wire Line
	9800 4850 9800 4950
Connection ~ 9800 4950
Wire Wire Line
	10200 4850 10200 4950
Connection ~ 10200 4950
Wire Wire Line
	10200 4350 10200 4450
Connection ~ 10200 4350
Wire Wire Line
	9800 4350 9800 4450
Connection ~ 9800 4350
Text Notes 9300 4100 0    60   ~ 0
AT P2
Text Label 9100 2150 0    60   ~ 0
A0
Text Label 9100 2050 0    60   ~ 0
A1
Text Label 9100 1950 0    60   ~ 0
A2
Text Label 9100 1850 0    60   ~ 0
A3
Text Label 9100 1750 0    60   ~ 0
A4
Text Label 9100 1650 0    60   ~ 0
A5
Text Label 9100 1550 0    60   ~ 0
A6
Text Label 9100 1450 0    60   ~ 0
A7
Text Label 10700 2150 2    60   ~ 0
A8
Text Label 10700 2050 2    60   ~ 0
A9
Text Label 10700 1950 2    60   ~ 0
A10
Text Label 10700 1850 2    60   ~ 0
A11
Text Label 10700 1750 2    60   ~ 0
A12
Text Label 10700 1650 2    60   ~ 0
A13
Text Label 10700 1450 2    60   ~ 0
A15
Text Label 10700 1550 2    60   ~ 0
A14
Wire Wire Line
	9500 950  9100 950 
Wire Wire Line
	9350 1050 9500 1050
Wire Wire Line
	9500 1150 9100 1150
Wire Wire Line
	9350 1250 9500 1250
Wire Wire Line
	10300 1250 10450 1250
Wire Wire Line
	10700 1150 10300 1150
Wire Wire Line
	10300 1050 10450 1050
Wire Wire Line
	10700 950  10300 950 
Wire Wire Line
	9100 2150 9500 2150
Wire Wire Line
	9500 2050 9100 2050
Wire Wire Line
	9100 1950 9500 1950
Wire Wire Line
	9500 1850 9100 1850
Wire Wire Line
	9100 1750 9500 1750
Wire Wire Line
	9500 1650 9100 1650
Wire Wire Line
	9100 1550 9500 1550
Wire Wire Line
	9500 1450 9100 1450
Wire Wire Line
	10300 2050 10700 2050
Wire Wire Line
	10700 1650 10300 1650
Wire Wire Line
	10300 2150 10700 2150
Wire Wire Line
	10700 1750 10300 1750
Wire Wire Line
	10700 1950 10300 1950
Wire Wire Line
	10300 1850 10700 1850
Wire Wire Line
	10700 1550 10300 1550
Wire Wire Line
	10300 1450 10700 1450
Wire Wire Line
	9500 3200 9400 3200
Wire Wire Line
	10300 3000 10400 3000
Text GLabel 9100 3100 0    60   Output ~ 0
SYNC
Text GLabel 10400 3500 2    60   Output ~ 0
R/~W
Text GLabel 9400 3000 0    60   Output ~ 0
PHI2
Text GLabel 9400 3200 0    60   Output ~ 0
~RST
Text GLabel 10600 3300 2    60   Input ~ 0
~IRQ
Text GLabel 10400 3000 2    60   Input ~ 0
RDY
Text GLabel 10400 3200 2    60   Input ~ 0
BE
Wire Wire Line
	9400 3000 9500 3000
Wire Wire Line
	9100 3100 9500 3100
$Comp
L CONN_13X2 P1
U 1 1 54D63EF4
P 9900 1550
F 0 "P1" H 9900 2250 60  0000 C CNN
F 1 "BUS" V 9900 1550 50  0000 C CNN
F 2 "" H 9900 1550 60  0000 C CNN
F 3 "" H 9900 1550 60  0000 C CNN
	1    9900 1550
	1    0    0    -1  
$EndComp
NoConn ~ 10300 1350
NoConn ~ 9500 1350
$Comp
L RASPBERRY_IO P2
U 1 1 54D64276
P 9900 3100
F 0 "P2" H 9900 3800 60  0000 C CNN
F 1 "CTRL (RPi)" V 9900 3100 50  0000 C CNN
F 2 "" H 9900 3100 60  0000 C CNN
F 3 "" H 9900 3100 60  0000 C CNN
	1    9900 3100
	1    0    0    -1  
$EndComp
NoConn ~ 9500 2500
Text Label 10700 2700 2    60   ~ 0
GND
Text Label 10700 2500 2    60   ~ 0
VCC
Wire Wire Line
	10700 2500 10300 2500
Wire Wire Line
	10300 2700 10700 2700
NoConn ~ 10300 2800
NoConn ~ 10300 2900
NoConn ~ 9500 2600
NoConn ~ 9500 2700
NoConn ~ 9500 2800
NoConn ~ 9500 3400
NoConn ~ 9500 3500
NoConn ~ 9500 3600
NoConn ~ 10300 3700
NoConn ~ 10300 3600
Wire Wire Line
	10300 3200 10400 3200
Wire Wire Line
	10400 3500 10300 3500
Wire Wire Line
	10300 3300 10600 3300
$Comp
L ARDUINO_SHIELD ARDUINO1
U 1 1 54D6538E
P 6800 1900
F 0 "ARDUINO1" H 6450 2850 60  0000 C CNN
F 1 "ARDUINO" H 6850 950 60  0000 C CNN
F 2 "" H 6800 1900 60  0000 C CNN
F 3 "" H 6800 1900 60  0000 C CNN
	1    6800 1900
	1    0    0    -1  
$EndComp
NoConn ~ 7750 2700
NoConn ~ 7750 2600
NoConn ~ 5850 2200
NoConn ~ 5850 2300
NoConn ~ 5850 2400
NoConn ~ 5850 2500
NoConn ~ 5850 2600
NoConn ~ 5850 2700
Wire Wire Line
	5850 1800 5450 1800
Text Label 5450 1800 0    60   ~ 0
GND
Wire Wire Line
	5850 1900 5450 1900
Text Label 5450 1900 0    60   ~ 0
GND
NoConn ~ 5850 1600
Wire Wire Line
	5850 1700 5450 1700
Text Label 5450 1700 0    60   ~ 0
VCC
NoConn ~ 5850 1500
NoConn ~ 5850 2000
NoConn ~ 7750 1100
Wire Wire Line
	7750 1200 8150 1200
Text Label 8150 1200 2    60   ~ 0
GND
Wire Wire Line
	7750 2500 8150 2500
Wire Wire Line
	7750 2300 8150 2300
Text Label 8150 2300 2    60   ~ 0
SCLK
NoConn ~ 7750 1300
NoConn ~ 7750 1400
NoConn ~ 7750 1500
NoConn ~ 7750 1800
$Sheet
S 2600 2050 900  400 
U 54D656E3
F0 "Single cycling" 50
F1 "single-cycle.sch" 50
F2 "HALT" I L 2600 2200 60 
F3 "STEP" I L 2600 2300 60 
$EndSheet
Wire Wire Line
	7750 2100 8150 2100
Text Label 8150 2100 2    60   ~ 0
HALT
Wire Wire Line
	7750 2000 8150 2000
Text Label 8150 2000 2    60   ~ 0
STEP
Wire Wire Line
	2600 2200 2200 2200
Text Label 2200 2200 0    60   ~ 0
HALT
Wire Wire Line
	2600 2300 2200 2300
Text Label 2200 2300 0    60   ~ 0
STEP
Wire Wire Line
	7750 1600 8150 1600
Text Label 8150 1600 2    60   ~ 0
~ILOAD
NoConn ~ 7750 2200
NoConn ~ 7750 1700
Wire Wire Line
	7750 2400 8150 2400
Text Label 8150 2400 2    60   ~ 0
MOSI
Text Label 8150 2500 2    60   ~ 0
MISO
Wire Wire Line
	4350 1350 4850 1350
Text Label 4850 1350 2    60   ~ 0
MOSI
NoConn ~ 4350 1350
$Sheet
S 2600 2700 900  700 
U 54DA56CE
F0 "Input Stage" 50
F1 "input-stage.sch" 50
F2 "~CE" I L 2600 2850 60 
F3 "SDIN" I L 2600 2950 60 
F4 "SDOUT" O L 2600 3050 60 
F5 "SCLK" I L 2600 3150 60 
F6 "~LOAD" I L 2600 3250 60 
$EndSheet
Wire Wire Line
	2600 3050 2200 3050
Text Label 2200 3050 0    60   ~ 0
MISO
Wire Wire Line
	2600 2950 2200 2950
Text Label 2200 2950 0    60   ~ 0
VCC
Wire Wire Line
	2600 2850 2200 2850
Text Label 2200 2850 0    60   ~ 0
GND
Wire Wire Line
	2600 3150 2200 3150
Text Label 2200 3150 0    60   ~ 0
SCLK
Wire Wire Line
	2600 3250 2200 3250
Text Label 2200 3250 0    60   ~ 0
~ILOAD
Text GLabel 9100 950  0    60   BiDi ~ 0
D0
Text GLabel 9350 1050 0    60   BiDi ~ 0
D1
Text GLabel 9100 1150 0    60   BiDi ~ 0
D2
Text GLabel 9350 1250 0    60   BiDi ~ 0
D3
Text GLabel 10700 950  2    60   BiDi ~ 0
D7
Text GLabel 10450 1050 2    60   BiDi ~ 0
D6
Text GLabel 10700 1150 2    60   BiDi ~ 0
D5
Text GLabel 10450 1250 2    60   BiDi ~ 0
D4
$EndSCHEMATC
