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
Sheet 4 5
Title "6502 Computer - Compute Board"
Date "10 feb 2015"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	9050 2350 9200 2350
Wire Wire Line
	9450 2450 9050 2450
Wire Wire Line
	9050 2550 9200 2550
Wire Wire Line
	9450 2650 9050 2650
Wire Wire Line
	9050 2750 9200 2750
Wire Wire Line
	9450 2850 9050 2850
Wire Wire Line
	9050 2950 9200 2950
Wire Wire Line
	9450 3050 9050 3050
Wire Wire Line
	4000 2350 3850 2350
Wire Wire Line
	3850 2450 4250 2450
Wire Wire Line
	4000 2550 3850 2550
Wire Wire Line
	3850 2650 4250 2650
Wire Wire Line
	4000 2750 3850 2750
Wire Wire Line
	3850 2850 4250 2850
Wire Wire Line
	4000 2950 3850 2950
Wire Wire Line
	3850 3050 4250 3050
Wire Wire Line
	6450 2450 6850 2450
Wire Wire Line
	6850 2850 6450 2850
Wire Wire Line
	6450 2350 6600 2350
Wire Wire Line
	6600 2750 6450 2750
Wire Wire Line
	6600 2550 6450 2550
Wire Wire Line
	6450 2650 6850 2650
Wire Wire Line
	6600 2950 6450 2950
Wire Wire Line
	6450 3050 6850 3050
Text GLabel 9200 2350 2    60   Output ~ 0
D0
Text GLabel 9450 2450 2    60   Output ~ 0
D1
Text GLabel 9200 2550 2    60   Output ~ 0
D2
Text GLabel 9450 2650 2    60   Output ~ 0
D3
Text GLabel 9450 3050 2    60   Output ~ 0
D7
Text GLabel 9200 2950 2    60   Output ~ 0
D6
Text GLabel 9450 2850 2    60   Output ~ 0
D5
Text GLabel 9200 2750 2    60   Output ~ 0
D4
Text GLabel 4250 3050 2    60   Output ~ 0
A7
Text GLabel 4000 2950 2    60   Output ~ 0
A6
Text GLabel 4250 2850 2    60   Output ~ 0
A5
Text GLabel 4000 2750 2    60   Output ~ 0
A4
Text GLabel 4250 2650 2    60   Output ~ 0
A3
Text GLabel 4000 2550 2    60   Output ~ 0
A2
Text GLabel 4250 2450 2    60   Output ~ 0
A1
Text GLabel 4000 2350 2    60   Output ~ 0
A0
Text GLabel 6850 3050 2    60   Output ~ 0
A15
Text GLabel 6600 2950 2    60   Output ~ 0
A14
Text GLabel 6850 2850 2    60   Output ~ 0
A13
Text GLabel 6600 2750 2    60   Output ~ 0
A12
Text GLabel 6850 2650 2    60   Output ~ 0
A11
Text GLabel 6600 2550 2    60   Output ~ 0
A10
Text GLabel 6850 2450 2    60   Output ~ 0
A9
Text GLabel 6600 2350 2    60   Output ~ 0
A8
$Comp
L 74HC595 U9
U 1 1 54DA70FF
P 3150 2800
F 0 "U9" H 3300 3400 70  0000 C CNN
F 1 "74HC595" H 3150 2200 70  0000 C CNN
F 2 "" H 3150 2800 60  0000 C CNN
F 3 "" H 3150 2800 60  0000 C CNN
	1    3150 2800
	1    0    0    -1  
$EndComp
$Comp
L 74HC595 U10
U 1 1 54DA7111
P 5750 2800
F 0 "U10" H 5900 3400 70  0000 C CNN
F 1 "74HC595" H 5750 2200 70  0000 C CNN
F 2 "" H 5750 2800 60  0000 C CNN
F 3 "" H 5750 2800 60  0000 C CNN
	1    5750 2800
	1    0    0    -1  
$EndComp
$Comp
L 74HC595 U11
U 1 1 54DA73AE
P 8350 2800
F 0 "U11" H 8500 3400 70  0000 C CNN
F 1 "74HC595" H 8350 2200 70  0000 C CNN
F 2 "" H 8350 2800 60  0000 C CNN
F 3 "" H 8350 2800 60  0000 C CNN
	1    8350 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7650 2350 7150 2350
Wire Wire Line
	7150 2350 7150 3250
Wire Wire Line
	7150 3250 6450 3250
Wire Wire Line
	5050 2350 4550 2350
Wire Wire Line
	4550 2350 4550 3250
Wire Wire Line
	4550 3250 3850 3250
Wire Wire Line
	2450 2350 2050 2350
Text HLabel 2050 2350 0    60   Input ~ 0
SDIN
Wire Wire Line
	2450 2850 2050 2850
Wire Wire Line
	2050 2950 2450 2950
Wire Wire Line
	2450 2650 2050 2650
Wire Wire Line
	2050 2550 2450 2550
Text Label 2050 2550 0    60   ~ 0
SCLK
Text Label 2050 2650 0    60   ~ 0
~MR
Text Label 2050 2850 0    60   ~ 0
RCLK
Text Label 2050 2950 0    60   ~ 0
~AOE
Wire Wire Line
	5050 2850 4650 2850
Wire Wire Line
	4650 2950 5050 2950
Wire Wire Line
	5050 2650 4650 2650
Wire Wire Line
	4650 2550 5050 2550
Text Label 4650 2550 0    60   ~ 0
SCLK
Text Label 4650 2650 0    60   ~ 0
~MR
Text Label 4650 2850 0    60   ~ 0
RCLK
Text Label 4650 2950 0    60   ~ 0
~AOE
Wire Wire Line
	7650 2850 7250 2850
Wire Wire Line
	7250 2950 7650 2950
Wire Wire Line
	7650 2650 7250 2650
Wire Wire Line
	7250 2550 7650 2550
Text Label 7250 2550 0    60   ~ 0
SCLK
Text Label 7250 2650 0    60   ~ 0
~MR
Text Label 7250 2850 0    60   ~ 0
RCLK
Text Label 7250 2950 0    60   ~ 0
~DOE
$Comp
L +5V #PWR39
U 1 1 54DA78A6
P 2850 2150
F 0 "#PWR39" H 2850 2240 20  0001 C CNN
F 1 "+5V" H 2850 2240 30  0000 C CNN
F 2 "" H 2850 2150 60  0000 C CNN
F 3 "" H 2850 2150 60  0000 C CNN
	1    2850 2150
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR41
U 1 1 54DA78B8
P 5450 2150
F 0 "#PWR41" H 5450 2240 20  0001 C CNN
F 1 "+5V" H 5450 2240 30  0000 C CNN
F 2 "" H 5450 2150 60  0000 C CNN
F 3 "" H 5450 2150 60  0000 C CNN
	1    5450 2150
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR43
U 1 1 54DA78C3
P 8050 2150
F 0 "#PWR43" H 8050 2240 20  0001 C CNN
F 1 "+5V" H 8050 2240 30  0000 C CNN
F 2 "" H 8050 2150 60  0000 C CNN
F 3 "" H 8050 2150 60  0000 C CNN
	1    8050 2150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR44
U 1 1 54DA78D0
P 8050 3450
F 0 "#PWR44" H 8050 3450 30  0001 C CNN
F 1 "GND" H 8050 3380 30  0001 C CNN
F 2 "" H 8050 3450 60  0000 C CNN
F 3 "" H 8050 3450 60  0000 C CNN
	1    8050 3450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR42
U 1 1 54DA78E2
P 5450 3450
F 0 "#PWR42" H 5450 3450 30  0001 C CNN
F 1 "GND" H 5450 3380 30  0001 C CNN
F 2 "" H 5450 3450 60  0000 C CNN
F 3 "" H 5450 3450 60  0000 C CNN
	1    5450 3450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR40
U 1 1 54DA78ED
P 2850 3450
F 0 "#PWR40" H 2850 3450 30  0001 C CNN
F 1 "GND" H 2850 3380 30  0001 C CNN
F 2 "" H 2850 3450 60  0000 C CNN
F 3 "" H 2850 3450 60  0000 C CNN
	1    2850 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 3350 2850 3450
Wire Wire Line
	5450 3350 5450 3450
Wire Wire Line
	8050 3350 8050 3450
Wire Wire Line
	8050 2150 8050 2250
Wire Wire Line
	5450 2150 5450 2250
Wire Wire Line
	2850 2150 2850 2250
Wire Wire Line
	1550 1800 1950 1800
Wire Wire Line
	1950 1900 1550 1900
Wire Wire Line
	1550 1700 1950 1700
Wire Wire Line
	1950 1600 1550 1600
Text Label 1950 1600 2    60   ~ 0
SCLK
Text Label 1950 1700 2    60   ~ 0
~MR
Text Label 1950 1800 2    60   ~ 0
RCLK
Text Label 1950 1900 2    60   ~ 0
~AOE
Text HLabel 1550 1600 0    60   Input ~ 0
SCLK
Text HLabel 1550 1700 0    60   Input ~ 0
~MR
Text HLabel 1550 1800 0    60   Input ~ 0
RCLK
Text HLabel 1550 1900 0    60   Input ~ 0
~AOE
Wire Wire Line
	9050 3250 9450 3250
Text HLabel 9450 3250 2    60   Output ~ 0
SDOUT
Wire Wire Line
	1950 2000 1550 2000
Text Label 1950 2000 2    60   ~ 0
~DOE
Text HLabel 1550 2000 0    60   Input ~ 0
~DOE
$EndSCHEMATC
