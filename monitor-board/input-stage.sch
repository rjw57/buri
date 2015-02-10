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
EELAYER 24 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 4
Title "6502 Computer - Compute Board"
Date "10 feb 2015"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 2400 4950 0    60   Input ~ 0
SYNC
Text GLabel 2100 4650 0    60   Input ~ 0
R/~W
Text GLabel 2400 4750 0    60   Input ~ 0
~IRQ
Text GLabel 2100 4850 0    60   Input ~ 0
BE
Wire Wire Line
	2400 4950 2600 4950
Wire Wire Line
	2100 4650 2600 4650
Wire Wire Line
	2400 4750 2600 4750
Wire Wire Line
	2100 4850 2600 4850
Text GLabel 2100 5050 0    60   Input ~ 0
~RST
Wire Wire Line
	2100 5050 2600 5050
$Comp
L 74LS165 U7
U 1 1 54DA6366
P 5600 3250
F 0 "U7" H 5750 3200 60  0000 C CNN
F 1 "74LS165" H 5750 3000 60  0000 C CNN
F 2 "~" H 5600 3250 60  0000 C CNN
F 3 "~" H 5600 3250 60  0000 C CNN
	1    5600 3250
	1    0    0    -1  
$EndComp
$Comp
L 74LS165 U8
U 1 1 54DA6367
P 7900 3250
F 0 "U8" H 8050 3200 60  0000 C CNN
F 1 "74LS165" H 8050 3000 60  0000 C CNN
F 2 "~" H 7900 3250 60  0000 C CNN
F 3 "~" H 7900 3250 60  0000 C CNN
	1    7900 3250
	1    0    0    -1  
$EndComp
$Comp
L 74LS165 U5
U 1 1 54DA6368
P 3300 3250
F 0 "U5" H 3450 3200 60  0000 C CNN
F 1 "74LS165" H 3450 3000 60  0000 C CNN
F 2 "~" H 3300 3250 60  0000 C CNN
F 3 "~" H 3300 3250 60  0000 C CNN
	1    3300 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 2750 4100 2750
Wire Wire Line
	4100 2750 4100 2650
Wire Wire Line
	4100 2650 4900 2650
Wire Wire Line
	6300 2750 6400 2750
Wire Wire Line
	6400 2750 6400 2650
Wire Wire Line
	6400 2650 7200 2650
NoConn ~ 4000 2850
NoConn ~ 6300 2850
NoConn ~ 8600 2850
Wire Wire Line
	4150 4650 4000 4650
Text Label 2200 3600 0    60   ~ 0
~LOAD
Wire Wire Line
	2200 3600 2600 3600
Text Label 2200 3750 0    60   ~ 0
SCLK
Wire Wire Line
	2200 3750 2600 3750
Text Label 2200 3850 0    60   ~ 0
~CE
Wire Wire Line
	2200 3850 2600 3850
$Comp
L GND #PWR031
U 1 1 54DA6369
P 3000 4000
F 0 "#PWR031" H 3000 4000 30  0001 C CNN
F 1 "GND" H 3000 3930 30  0001 C CNN
F 2 "" H 3000 4000 60  0000 C CNN
F 3 "" H 3000 4000 60  0000 C CNN
	1    3000 4000
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR032
U 1 1 54DA636A
P 3000 2500
F 0 "#PWR032" H 3000 2590 20  0001 C CNN
F 1 "+5V" H 3000 2590 30  0000 C CNN
F 2 "" H 3000 2500 60  0000 C CNN
F 3 "" H 3000 2500 60  0000 C CNN
	1    3000 2500
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR033
U 1 1 54DA636B
P 5300 2500
F 0 "#PWR033" H 5300 2590 20  0001 C CNN
F 1 "+5V" H 5300 2590 30  0000 C CNN
F 2 "" H 5300 2500 60  0000 C CNN
F 3 "" H 5300 2500 60  0000 C CNN
	1    5300 2500
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR034
U 1 1 54DA636C
P 7600 2500
F 0 "#PWR034" H 7600 2590 20  0001 C CNN
F 1 "+5V" H 7600 2590 30  0000 C CNN
F 2 "" H 7600 2500 60  0000 C CNN
F 3 "" H 7600 2500 60  0000 C CNN
	1    7600 2500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR035
U 1 1 54DA636D
P 5300 4000
F 0 "#PWR035" H 5300 4000 30  0001 C CNN
F 1 "GND" H 5300 3930 30  0001 C CNN
F 2 "" H 5300 4000 60  0000 C CNN
F 3 "" H 5300 4000 60  0000 C CNN
	1    5300 4000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR036
U 1 1 54DA636E
P 7600 4000
F 0 "#PWR036" H 7600 4000 30  0001 C CNN
F 1 "GND" H 7600 3930 30  0001 C CNN
F 2 "" H 7600 4000 60  0000 C CNN
F 3 "" H 7600 4000 60  0000 C CNN
	1    7600 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 3900 7600 4000
Wire Wire Line
	5300 3900 5300 4000
Wire Wire Line
	3000 3900 3000 4000
Wire Wire Line
	3000 2500 3000 2600
Wire Wire Line
	5300 2500 5300 2600
Wire Wire Line
	7600 2500 7600 2600
$Comp
L 74LS165 U6
U 1 1 54DA636F
P 3300 5150
F 0 "U6" H 3450 5100 60  0000 C CNN
F 1 "74LS165" H 3450 4900 60  0000 C CNN
F 2 "~" H 3300 5150 60  0000 C CNN
F 3 "~" H 3300 5150 60  0000 C CNN
	1    3300 5150
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR037
U 1 1 54DA6370
P 3000 4400
F 0 "#PWR037" H 3000 4490 20  0001 C CNN
F 1 "+5V" H 3000 4490 30  0000 C CNN
F 2 "" H 3000 4400 60  0000 C CNN
F 3 "" H 3000 4400 60  0000 C CNN
	1    3000 4400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR038
U 1 1 54DA6371
P 3000 5900
F 0 "#PWR038" H 3000 5900 30  0001 C CNN
F 1 "GND" H 3000 5830 30  0001 C CNN
F 2 "" H 3000 5900 60  0000 C CNN
F 3 "" H 3000 5900 60  0000 C CNN
	1    3000 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 5800 3000 5900
Wire Wire Line
	3000 4400 3000 4500
NoConn ~ 2600 5150
NoConn ~ 2600 5250
NoConn ~ 2600 5350
Wire Wire Line
	8600 2750 8700 2750
Wire Wire Line
	8700 2750 8700 4200
Wire Wire Line
	8700 4200 2500 4200
Wire Wire Line
	2500 4200 2500 4550
Wire Wire Line
	2500 4550 2600 4550
NoConn ~ 4000 4750
Text HLabel 2800 1850 0    60   Input ~ 0
~CE
Text HLabel 2200 2650 0    60   Input ~ 0
SDIN
Text HLabel 4150 4650 2    60   Output ~ 0
SDOUT
Wire Wire Line
	2200 2650 2600 2650
Text Label 4500 3600 0    60   ~ 0
~LOAD
Wire Wire Line
	4500 3600 4900 3600
Text Label 4500 3750 0    60   ~ 0
SCLK
Wire Wire Line
	4500 3750 4900 3750
Text Label 4500 3850 0    60   ~ 0
~CE
Wire Wire Line
	4500 3850 4900 3850
Text Label 6800 3600 0    60   ~ 0
~LOAD
Wire Wire Line
	6800 3600 7200 3600
Text Label 6800 3750 0    60   ~ 0
SCLK
Wire Wire Line
	6800 3750 7200 3750
Text Label 6800 3850 0    60   ~ 0
~CE
Wire Wire Line
	6800 3850 7200 3850
Text Label 2200 5500 0    60   ~ 0
~LOAD
Wire Wire Line
	2200 5500 2600 5500
Text Label 2200 5650 0    60   ~ 0
SCLK
Wire Wire Line
	2200 5650 2600 5650
Text Label 2200 5750 0    60   ~ 0
~CE
Wire Wire Line
	2200 5750 2600 5750
Text Label 3200 1650 2    60   ~ 0
~LOAD
Wire Wire Line
	3200 1650 2800 1650
Text Label 3200 1750 2    60   ~ 0
SCLK
Wire Wire Line
	3200 1750 2800 1750
Text Label 3200 1850 2    60   ~ 0
~CE
Wire Wire Line
	3200 1850 2800 1850
Text HLabel 2800 1750 0    60   Input ~ 0
SCLK
Text HLabel 2800 1650 0    60   Input ~ 0
~LOAD
Wire Wire Line
	7200 2750 7050 2750
Wire Wire Line
	6800 2850 7200 2850
Wire Wire Line
	7200 2950 7050 2950
Wire Wire Line
	6800 3050 7200 3050
Wire Wire Line
	7200 3150 7050 3150
Wire Wire Line
	6800 3250 7200 3250
Wire Wire Line
	7200 3350 7050 3350
Wire Wire Line
	6800 3450 7200 3450
Wire Wire Line
	2450 2750 2600 2750
Wire Wire Line
	2600 2850 2200 2850
Wire Wire Line
	2450 2950 2600 2950
Wire Wire Line
	2600 3050 2200 3050
Wire Wire Line
	2450 3150 2600 3150
Wire Wire Line
	2600 3250 2200 3250
Wire Wire Line
	2450 3350 2600 3350
Wire Wire Line
	2600 3450 2200 3450
Wire Wire Line
	4900 2850 4500 2850
Wire Wire Line
	4500 3250 4900 3250
Wire Wire Line
	4900 2750 4750 2750
Wire Wire Line
	4750 3150 4900 3150
Wire Wire Line
	4750 2950 4900 2950
Wire Wire Line
	4900 3050 4500 3050
Wire Wire Line
	4750 3350 4900 3350
Wire Wire Line
	4900 3450 4500 3450
Text GLabel 7050 2750 0    60   Input ~ 0
D0
Text GLabel 6800 2850 0    60   Input ~ 0
D1
Text GLabel 7050 2950 0    60   Input ~ 0
D2
Text GLabel 6800 3050 0    60   Input ~ 0
D3
Text GLabel 6800 3450 0    60   Input ~ 0
D7
Text GLabel 7050 3350 0    60   Input ~ 0
D6
Text GLabel 6800 3250 0    60   Input ~ 0
D5
Text GLabel 7050 3150 0    60   Input ~ 0
D4
Text GLabel 2200 3450 0    60   Input ~ 0
A7
Text GLabel 2450 3350 0    60   Input ~ 0
A6
Text GLabel 2200 3250 0    60   Input ~ 0
A5
Text GLabel 2450 3150 0    60   Input ~ 0
A4
Text GLabel 2200 3050 0    60   Input ~ 0
A3
Text GLabel 2450 2950 0    60   Input ~ 0
A2
Text GLabel 2200 2850 0    60   Input ~ 0
A1
Text GLabel 2450 2750 0    60   Input ~ 0
A0
Text GLabel 4500 3450 0    60   Input ~ 0
A15
Text GLabel 4750 3350 0    60   Input ~ 0
A14
Text GLabel 4500 3250 0    60   Input ~ 0
A13
Text GLabel 4750 3150 0    60   Input ~ 0
A12
Text GLabel 4500 3050 0    60   Input ~ 0
A11
Text GLabel 4750 2950 0    60   Input ~ 0
A10
Text GLabel 4500 2850 0    60   Input ~ 0
A9
Text GLabel 4750 2750 0    60   Input ~ 0
A8
$EndSCHEMATC
