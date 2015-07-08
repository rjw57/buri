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
LIBS:w_logic
LIBS:monitor-board-cache
EELAYER 24 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 5
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
Text Label 9300 4350 0    60   ~ 0
VCC
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
L GND #PWR5
U 1 1 54D64A79
P 10400 5000
F 0 "#PWR5" H 10400 5000 30  0001 C CNN
F 1 "GND" H 10400 4930 30  0001 C CNN
F 2 "" H 10400 5000 60  0000 C CNN
F 3 "" H 10400 5000 60  0000 C CNN
	1    10400 5000
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR4
U 1 1 54D64A7A
P 10400 4300
F 0 "#PWR4" H 10400 4390 20  0001 C CNN
F 1 "+5V" H 10400 4390 30  0000 C CNN
F 2 "" H 10400 4300 60  0000 C CNN
F 3 "" H 10400 4300 60  0000 C CNN
	1    10400 4300
	1    0    0    -1  
$EndComp
Text Notes 9300 4100 0    60   ~ 0
AT P2
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
$Comp
L ARDUINO_SHIELD ARDUINO1
U 1 1 54D6538E
P 5700 2650
F 0 "ARDUINO1" H 5350 3600 60  0000 C CNN
F 1 "ARDUINO" H 5750 1700 60  0000 C CNN
F 2 "" H 5700 2650 60  0000 C CNN
F 3 "" H 5700 2650 60  0000 C CNN
	1    5700 2650
	1    0    0    -1  
$EndComp
NoConn ~ 4750 3150
NoConn ~ 4750 3250
NoConn ~ 4750 3350
NoConn ~ 4750 3450
Text Label 4300 2550 0    60   ~ 0
GND
Text Label 4300 2650 0    60   ~ 0
GND
NoConn ~ 4750 2350
Text Label 4300 2750 0    60   ~ 0
VCC
NoConn ~ 4750 2250
NoConn ~ 6650 1850
Text Label 7100 1950 2    60   ~ 0
GND
Text Label 7100 3050 2    60   ~ 0
SCLK
$Sheet
S 2200 1750 900  400 
U 54D656E3
F0 "Single cycling" 50
F1 "single-cycle.sch" 50
F2 "HALT" I L 2200 1900 60 
F3 "STEP" I L 2200 2000 60 
$EndSheet
Text Label 7100 2850 2    60   ~ 0
HALT
Text Label 7100 2750 2    60   ~ 0
STEP
Text Label 1700 1900 0    60   ~ 0
HALT
Text Label 1700 2000 0    60   ~ 0
STEP
Text Label 7100 2950 2    60   ~ 0
~ILOAD
Text Label 7100 3250 2    60   ~ 0
MOSI
Text Label 7100 3150 2    60   ~ 0
MISO
$Sheet
S 2200 2550 900  700 
U 54DA56CE
F0 "Input Stage" 50
F1 "input-stage.sch" 50
F2 "~CE" I L 2200 2700 60 
F3 "SDIN" I L 2200 2800 60 
F4 "SDOUT" O L 2200 2900 60 
F5 "SCLK" I L 2200 3000 60 
F6 "~LOAD" I L 2200 3100 60 
$EndSheet
Text Label 1700 2900 0    60   ~ 0
MISO
Text Label 1700 2700 0    60   ~ 0
GND
Text Label 1700 3000 0    60   ~ 0
SCLK
Text Label 1700 3100 0    60   ~ 0
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
Text GLabel 9100 1450 0    60   BiDi ~ 0
A7
Text GLabel 9350 1550 0    60   BiDi ~ 0
A6
Text GLabel 9100 1650 0    60   BiDi ~ 0
A5
Text GLabel 9350 1750 0    60   BiDi ~ 0
A4
Text GLabel 9100 1850 0    60   BiDi ~ 0
A3
Text GLabel 9350 1950 0    60   BiDi ~ 0
A2
Text GLabel 9100 2050 0    60   BiDi ~ 0
A1
Text GLabel 9350 2150 0    60   BiDi ~ 0
A0
Text GLabel 10700 1450 2    60   BiDi ~ 0
A15
Text GLabel 10450 1550 2    60   BiDi ~ 0
A14
Text GLabel 10700 1650 2    60   BiDi ~ 0
A13
Text GLabel 10450 1750 2    60   BiDi ~ 0
A12
Text GLabel 10700 1850 2    60   BiDi ~ 0
A11
Text GLabel 10450 1950 2    60   BiDi ~ 0
A10
Text GLabel 10700 2050 2    60   BiDi ~ 0
A9
Text GLabel 10450 2150 2    60   BiDi ~ 0
A8
$Sheet
S 2200 3650 900  900 
U 54DA6F52
F0 "Output Stage" 50
F1 "output-stage.sch" 50
F2 "SDIN" I L 2200 3800 60 
F3 "SCLK" I L 2200 3900 60 
F4 "~MR" I L 2200 4000 60 
F5 "RCLK" I L 2200 4100 60 
F6 "SDOUT" O L 2200 4400 60 
F7 "~AOE" I L 2200 4200 60 
F8 "~DOE" I L 2200 4300 60 
$EndSheet
Text Label 1700 5100 0    60   ~ 0
MOSI
Text Label 1700 3900 0    60   ~ 0
SCLK
Text Label 1700 4200 0    60   ~ 0
~ADROE
Text Label 1700 4100 0    60   ~ 0
RCLK
$Comp
L +5V #PWR1
U 1 1 54DA9DF0
P 1000 3950
F 0 "#PWR1" H 1000 4040 20  0001 C CNN
F 1 "+5V" H 1000 4040 30  0000 C CNN
F 2 "" H 1000 3950 60  0000 C CNN
F 3 "" H 1000 3950 60  0000 C CNN
	1    1000 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	9300 4950 10400 4950
Wire Wire Line
	9300 4350 10400 4350
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
	9350 2150 9500 2150
Wire Wire Line
	9500 2050 9100 2050
Wire Wire Line
	9350 1950 9500 1950
Wire Wire Line
	9500 1850 9100 1850
Wire Wire Line
	9350 1750 9500 1750
Wire Wire Line
	9500 1650 9100 1650
Wire Wire Line
	9350 1550 9500 1550
Wire Wire Line
	9500 1450 9100 1450
Wire Wire Line
	10300 2050 10700 2050
Wire Wire Line
	10700 1650 10300 1650
Wire Wire Line
	10300 2150 10450 2150
Wire Wire Line
	10450 1750 10300 1750
Wire Wire Line
	10450 1950 10300 1950
Wire Wire Line
	10300 1850 10700 1850
Wire Wire Line
	10450 1550 10300 1550
Wire Wire Line
	10300 1450 10700 1450
Wire Wire Line
	9500 3200 9400 3200
Wire Wire Line
	10300 3000 10400 3000
Wire Wire Line
	9400 3000 9500 3000
Wire Wire Line
	9100 3100 9500 3100
Wire Wire Line
	10700 2500 10300 2500
Wire Wire Line
	10300 2700 10700 2700
Wire Wire Line
	10300 3200 10400 3200
Wire Wire Line
	10400 3500 10300 3500
Wire Wire Line
	10300 3300 10600 3300
Wire Wire Line
	4750 2550 4300 2550
Wire Wire Line
	4750 2650 4300 2650
Wire Wire Line
	4750 2750 4300 2750
Wire Wire Line
	6650 1950 7100 1950
Wire Wire Line
	6650 3150 7100 3150
Wire Wire Line
	6650 3050 7100 3050
Wire Wire Line
	6650 2850 7100 2850
Wire Wire Line
	6650 2750 7100 2750
Wire Wire Line
	2200 1900 1700 1900
Wire Wire Line
	2200 2000 1700 2000
Wire Wire Line
	6650 2950 7100 2950
Wire Wire Line
	6650 3250 7100 3250
Wire Wire Line
	2200 2900 1700 2900
Wire Wire Line
	2200 2700 1700 2700
Wire Wire Line
	2200 3000 1700 3000
Wire Wire Line
	2200 3100 1700 3100
Wire Wire Line
	2200 5100 1700 5100
Wire Wire Line
	2200 3900 1700 3900
Wire Wire Line
	2200 2800 1700 2800
Text Label 1700 2800 0    60   ~ 0
VCC
Text GLabel 4250 3050 0    60   3State ~ 0
BE
Wire Wire Line
	4750 3050 4250 3050
Text GLabel 4550 2950 0    60   3State ~ 0
~RST
Wire Wire Line
	4750 2950 4550 2950
$Sheet
S 2200 4950 900  600 
U 54DA84F7
F0 "Display" 50
F1 "display.sch" 50
F2 "SDIN" I L 2200 5100 60 
F3 "SDOUT" O L 2200 5200 60 
F4 "LOAD" I L 2200 5300 60 
F5 "SCLK" I L 2200 5400 60 
$EndSheet
Wire Wire Line
	2200 5200 1700 5200
NoConn ~ 1700 5200
Text Label 1700 5400 0    60   ~ 0
SCLK
Wire Wire Line
	2200 5400 1700 5400
Wire Wire Line
	2200 5300 1700 5300
Text Label 1700 5300 0    60   ~ 0
DPYLD
Wire Wire Line
	6650 2550 7100 2550
Text Label 7100 2550 2    60   ~ 0
DPYLD
NoConn ~ 6650 3350
NoConn ~ 6650 3450
Wire Wire Line
	2200 4400 1700 4400
NoConn ~ 1700 4400
Text Label 7100 2250 2    60   ~ 0
SELECT
Text Label 7100 2150 2    60   ~ 0
MODE
Wire Wire Line
	6650 2250 7100 2250
Wire Wire Line
	6650 2150 7100 2150
Text Label 6250 5350 2    60   ~ 0
SELECT
Wire Wire Line
	5850 5350 6250 5350
$Comp
L SW_PUSH SW2
U 1 1 54DFF030
P 5550 5350
F 0 "SW2" H 5700 5460 50  0000 C CNN
F 1 "TACT SWITCH" H 5550 5270 50  0000 C CNN
F 2 "" H 5550 5350 60  0000 C CNN
F 3 "" H 5550 5350 60  0000 C CNN
	1    5550 5350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR3
U 1 1 54DFF20D
P 5150 5450
F 0 "#PWR3" H 5150 5450 30  0001 C CNN
F 1 "GND" H 5150 5380 30  0001 C CNN
F 2 "" H 5150 5450 60  0000 C CNN
F 3 "" H 5150 5450 60  0000 C CNN
	1    5150 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 5350 5150 5350
Wire Wire Line
	5150 5350 5150 5450
Text Label 6250 5050 2    60   ~ 0
MODE
Wire Wire Line
	5850 5050 6250 5050
$Comp
L SW_PUSH SW1
U 1 1 54DFF7EC
P 5550 5050
F 0 "SW1" H 5700 5160 50  0000 C CNN
F 1 "TACT SWITCH" H 5550 4970 50  0000 C CNN
F 2 "" H 5550 5050 60  0000 C CNN
F 3 "" H 5550 5050 60  0000 C CNN
	1    5550 5050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR2
U 1 1 54DFF7F2
P 5150 5150
F 0 "#PWR2" H 5150 5150 30  0001 C CNN
F 1 "GND" H 5150 5080 30  0001 C CNN
F 2 "" H 5150 5150 60  0000 C CNN
F 3 "" H 5150 5150 60  0000 C CNN
	1    5150 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 5050 5150 5050
Wire Wire Line
	5150 5050 5150 5150
Text Notes 5000 4800 0    60   ~ 0
NB: Arduino has internal pullups
NoConn ~ 4750 2450
Wire Wire Line
	1000 3950 1000 4300
Wire Wire Line
	1000 4000 2200 4000
Text Label 1700 4300 0    60   ~ 0
~DTAOE
Wire Wire Line
	2200 4300 1600 4300
Wire Wire Line
	1600 4200 2200 4200
Wire Wire Line
	2200 4100 1700 4100
Wire Wire Line
	2200 3800 1700 3800
Text Label 1700 3800 0    60   ~ 0
MOSI
Text Label 7100 2350 2    60   ~ 0
~ADROE
Text Label 7100 2050 2    60   ~ 0
RCLK
Text Label 7100 2450 2    60   ~ 0
~DTAOE
Wire Wire Line
	6650 2450 7100 2450
Wire Wire Line
	7100 2350 6650 2350
Wire Wire Line
	6650 2050 7100 2050
$Comp
L R R3
U 1 1 54DFE917
P 1350 4300
F 0 "R3" V 1250 4300 40  0000 C CNN
F 1 "10K" V 1357 4301 40  0000 C CNN
F 2 "" V 1280 4300 30  0000 C CNN
F 3 "" H 1350 4300 30  0000 C CNN
	1    1350 4300
	0    -1   -1   0   
$EndComp
$Comp
L R R2
U 1 1 54DFEA59
P 1350 4200
F 0 "R2" V 1430 4200 40  0000 C CNN
F 1 "10K" V 1357 4201 40  0000 C CNN
F 2 "" V 1280 4200 30  0000 C CNN
F 3 "" H 1350 4200 30  0000 C CNN
	1    1350 4200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1000 4300 1100 4300
Connection ~ 1000 4000
Wire Wire Line
	1000 4200 1100 4200
Connection ~ 1000 4200
$EndSCHEMATC