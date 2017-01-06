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
LIBS:w65c816
LIBS:tl7705a
LIBS:fixed_pin_7805
LIBS:combined-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 4400 1500 700  1000
U 586F9CB6
F0 "CPU" 60
F1 "cpu.sch" 60
F2 "~RST" I L 4400 1800 60 
F3 "~IRQ" I L 4400 1900 60 
F4 "~NMI" I L 4400 2000 60 
F5 "~ABORT" I L 4400 2100 60 
F6 "RDY" I L 4400 2400 60 
F7 "R/~W" O R 5100 1600 60 
F8 "PHI2" I L 4400 1600 60 
F9 "BE" I L 4400 2300 60 
F10 "E" O R 5100 1700 60 
F11 "~VP" O R 5100 1800 60 
F12 "~ML" O R 5100 1900 60 
F13 "MX" O R 5100 2000 60 
F14 "VPA" O R 5100 2100 60 
F15 "VDA" O R 5100 2200 60 
$EndSheet
Text GLabel 1400 6600 0    60   BiDi ~ 0
D0
Text GLabel 1400 6700 0    60   BiDi ~ 0
D1
Text GLabel 1400 6800 0    60   BiDi ~ 0
D2
Text GLabel 1400 6900 0    60   BiDi ~ 0
D3
Text GLabel 1400 7000 0    60   BiDi ~ 0
D4
Text GLabel 1400 7100 0    60   BiDi ~ 0
D5
Text GLabel 1400 7200 0    60   BiDi ~ 0
D6
Text GLabel 1400 7300 0    60   BiDi ~ 0
D7
$Comp
L RR8 RR1
U 1 1 586FC273
P 2800 5950
F 0 "RR1" H 2850 6500 50  0000 C CNN
F 1 "RR8" V 2830 5950 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Array_SIP9" H 2800 5950 50  0001 C CNN
F 3 "" H 2800 5950 50  0000 C CNN
	1    2800 5950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 586FC389
P 2450 5500
F 0 "#PWR01" H 2450 5250 50  0001 C CNN
F 1 "GND" H 2450 5350 50  0000 C CNN
F 2 "" H 2450 5500 50  0000 C CNN
F 3 "" H 2450 5500 50  0000 C CNN
	1    2450 5500
	0    1    1    0   
$EndComp
Text Notes 2100 5550 2    60   ~ 0
Data bus pull downs
$Sheet
S 2450 900  600  200 
U 586FC5DB
F0 "Reset" 60
F1 "resetpwr.sch" 60
F2 "~RESET" O R 3050 1000 60 
$EndSheet
Text Label 3400 1000 2    60   ~ 0
~RST
$Comp
L RR8 RR2
U 1 1 58705735
P 2950 2150
F 0 "RR2" H 3000 2700 50  0000 C CNN
F 1 "RR8" V 2980 2150 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Array_SIP9" H 2950 2150 50  0001 C CNN
F 3 "" H 2950 2150 50  0000 C CNN
	1    2950 2150
	-1   0    0    -1  
$EndComp
$Comp
L +5V #PWR02
U 1 1 58705DC5
P 3300 1700
F 0 "#PWR02" H 3300 1550 50  0001 C CNN
F 1 "+5V" H 3300 1840 50  0000 C CNN
F 2 "" H 3300 1700 50  0000 C CNN
F 3 "" H 3300 1700 50  0000 C CNN
	1    3300 1700
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR03
U 1 1 586FB9F7
P 5650 3050
F 0 "#PWR03" H 5650 2900 50  0001 C CNN
F 1 "+5V" H 5650 3190 50  0000 C CNN
F 2 "" H 5650 3050 50  0000 C CNN
F 3 "" H 5650 3050 50  0000 C CNN
	1    5650 3050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 586FB9FD
P 5650 3650
F 0 "#PWR04" H 5650 3400 50  0001 C CNN
F 1 "GND" H 5650 3500 50  0000 C CNN
F 2 "" H 5650 3650 50  0000 C CNN
F 3 "" H 5650 3650 50  0000 C CNN
	1    5650 3650
	1    0    0    -1  
$EndComp
Text Label 5500 3400 0    60   ~ 0
~RST
Text Label 5500 3300 0    60   ~ 0
PHI2
Text Label 4200 3100 0    60   ~ 0
BE
Text Label 4200 3600 0    60   ~ 0
~IRQ
Text Label 4200 3500 0    60   ~ 0
~NMI
Text Label 4200 3000 0    60   ~ 0
RDY
Text Label 4200 3700 0    60   ~ 0
R/~W
Text Label 4200 3300 0    60   ~ 0
~ML
Text Label 4200 3200 0    60   ~ 0
~VP
$Comp
L CONN_01X08 P4
U 1 1 586FBA49
P 2850 6950
F 0 "P4" H 2850 7400 50  0000 C CNN
F 1 "D0..D7" V 2950 6950 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08_Pitch2.54mm" H 2850 6950 50  0001 C CNN
F 3 "" H 2850 6950 50  0000 C CNN
	1    2850 6950
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P1
U 1 1 586FBA50
P 1500 2850
F 0 "P1" H 1500 3300 50  0000 C CNN
F 1 "A0..A7" V 1600 2850 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08_Pitch2.54mm" H 1500 2850 50  0001 C CNN
F 3 "" H 1500 2850 50  0000 C CNN
	1    1500 2850
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P2
U 1 1 586FBA57
P 1500 3850
F 0 "P2" H 1500 4300 50  0000 C CNN
F 1 "A8..A15" V 1600 3850 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08_Pitch2.54mm" H 1500 3850 50  0001 C CNN
F 3 "" H 1500 3850 50  0000 C CNN
	1    1500 3850
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P3
U 1 1 586FBA5E
P 1500 4850
F 0 "P3" H 1500 5300 50  0000 C CNN
F 1 "A16..A23" V 1600 4850 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08_Pitch2.54mm" H 1500 4850 50  0001 C CNN
F 3 "" H 1500 4850 50  0000 C CNN
	1    1500 4850
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P5
U 1 1 586FBA65
P 4700 3350
F 0 "P5" H 4700 3800 50  0000 C CNN
F 1 "CTRL1" V 4800 3350 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08_Pitch2.54mm" H 4700 3350 50  0001 C CNN
F 3 "" H 4700 3350 50  0000 C CNN
	1    4700 3350
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P6
U 1 1 586FBA6C
P 6000 3350
F 0 "P6" H 6000 3800 50  0000 C CNN
F 1 "CTRL2" V 6100 3350 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08_Pitch2.54mm" H 6000 3350 50  0001 C CNN
F 3 "" H 6000 3350 50  0000 C CNN
	1    6000 3350
	1    0    0    -1  
$EndComp
Text GLabel 1000 2500 0    60   Input ~ 0
A0
Text GLabel 1000 2600 0    60   Input ~ 0
A1
Text GLabel 1000 2700 0    60   Input ~ 0
A2
Text GLabel 1000 2800 0    60   Input ~ 0
A3
Text GLabel 1000 2900 0    60   Input ~ 0
A4
Text GLabel 1000 3000 0    60   Input ~ 0
A5
Text GLabel 1000 3100 0    60   Input ~ 0
A6
Text GLabel 1000 3200 0    60   Input ~ 0
A7
Text GLabel 1000 3500 0    60   Input ~ 0
A8
Text GLabel 1000 3600 0    60   Input ~ 0
A9
Text GLabel 1000 3700 0    60   Input ~ 0
A10
Text GLabel 1000 3800 0    60   Input ~ 0
A11
Text GLabel 1000 3900 0    60   Input ~ 0
A12
Text GLabel 1000 4000 0    60   Input ~ 0
A13
Text GLabel 1000 4100 0    60   Input ~ 0
A14
Text GLabel 1000 4200 0    60   Input ~ 0
A15
Text GLabel 1000 4500 0    60   Input ~ 0
A16
Text GLabel 1000 4600 0    60   Input ~ 0
A17
Text GLabel 1000 4700 0    60   Input ~ 0
A18
Text GLabel 1000 4800 0    60   Input ~ 0
A19
Text GLabel 1000 4900 0    60   Input ~ 0
A20
Text GLabel 1000 5000 0    60   Input ~ 0
A21
Text GLabel 1000 5100 0    60   Input ~ 0
A22
Text GLabel 1000 5200 0    60   Input ~ 0
A23
$Comp
L GND #PWR05
U 1 1 587027C8
P 4000 3800
F 0 "#PWR05" H 4000 3550 50  0001 C CNN
F 1 "GND" H 4000 3650 50  0000 C CNN
F 2 "" H 4000 3800 50  0000 C CNN
F 3 "" H 4000 3800 50  0000 C CNN
	1    4000 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 6600 2650 6600
Wire Wire Line
	1400 6700 2650 6700
Wire Wire Line
	1400 6800 2650 6800
Wire Wire Line
	1400 6900 2650 6900
Wire Wire Line
	1400 7000 2650 7000
Wire Wire Line
	1400 7100 2650 7100
Wire Wire Line
	1400 7200 2650 7200
Wire Wire Line
	1400 7300 2650 7300
Wire Wire Line
	3300 1800 4400 1800
Wire Wire Line
	3300 1900 4400 1900
Wire Wire Line
	3300 2000 4400 2000
Wire Wire Line
	4400 2100 3300 2100
Wire Wire Line
	3300 2200 3600 2200
Wire Wire Line
	3600 2200 3600 3100
Wire Wire Line
	3600 2300 4400 2300
Wire Wire Line
	4400 2400 3500 2400
Wire Wire Line
	3500 2300 3500 3000
Wire Wire Line
	3500 2300 3300 2300
Wire Wire Line
	3050 1000 3500 1000
Wire Wire Line
	3500 1000 3500 1800
Connection ~ 3500 1800
Wire Wire Line
	5800 3000 5750 3000
Wire Wire Line
	5750 3000 5750 3100
Wire Wire Line
	5750 3100 5800 3100
Wire Wire Line
	5650 3050 5750 3050
Connection ~ 5750 3050
Wire Wire Line
	5650 3600 5800 3600
Wire Wire Line
	5750 3500 5750 3700
Wire Wire Line
	5750 3700 5800 3700
Wire Wire Line
	5300 3400 5800 3400
Wire Wire Line
	5400 3300 5800 3300
Wire Wire Line
	3600 3100 4500 3100
Wire Wire Line
	3800 3600 4500 3600
Wire Wire Line
	3700 3500 4500 3500
Wire Wire Line
	3500 3000 4500 3000
Wire Wire Line
	4100 3700 4500 3700
Wire Wire Line
	4000 3300 4500 3300
Wire Wire Line
	3900 3200 4500 3200
Wire Wire Line
	5800 3200 5500 3200
Wire Wire Line
	5800 3500 5750 3500
Connection ~ 5750 3600
Wire Wire Line
	5650 3600 5650 3650
Wire Wire Line
	2450 6300 2350 6300
Wire Wire Line
	2350 6300 2350 7300
Connection ~ 2350 7300
Wire Wire Line
	2450 6200 2250 6200
Wire Wire Line
	2250 6200 2250 7200
Connection ~ 2250 7200
Wire Wire Line
	2450 6100 2150 6100
Wire Wire Line
	2150 6100 2150 7100
Connection ~ 2150 7100
Wire Wire Line
	2450 6000 2050 6000
Wire Wire Line
	2050 6000 2050 7000
Connection ~ 2050 7000
Wire Wire Line
	2450 5900 1950 5900
Wire Wire Line
	1950 5900 1950 6900
Connection ~ 1950 6900
Wire Wire Line
	2450 5800 1850 5800
Wire Wire Line
	1850 5800 1850 6800
Connection ~ 1850 6800
Wire Wire Line
	2450 5700 1750 5700
Wire Wire Line
	1750 5700 1750 6700
Connection ~ 1750 6700
Wire Wire Line
	2450 5600 1650 5600
Wire Wire Line
	1650 5600 1650 6600
Connection ~ 1650 6600
Wire Wire Line
	1000 2500 1300 2500
Wire Wire Line
	1000 2600 1300 2600
Wire Wire Line
	1000 2700 1300 2700
Wire Wire Line
	1000 2800 1300 2800
Wire Wire Line
	1000 2900 1300 2900
Wire Wire Line
	1000 3000 1300 3000
Wire Wire Line
	1000 3100 1300 3100
Wire Wire Line
	1000 3200 1300 3200
Wire Wire Line
	1000 3500 1300 3500
Wire Wire Line
	1000 3600 1300 3600
Wire Wire Line
	1000 3700 1300 3700
Wire Wire Line
	1000 3800 1300 3800
Wire Wire Line
	1000 3900 1300 3900
Wire Wire Line
	1000 4000 1300 4000
Wire Wire Line
	1000 4100 1300 4100
Wire Wire Line
	1000 4200 1300 4200
Wire Wire Line
	1000 4500 1300 4500
Wire Wire Line
	1000 4600 1300 4600
Wire Wire Line
	1000 4700 1300 4700
Wire Wire Line
	1000 4800 1300 4800
Wire Wire Line
	1000 4900 1300 4900
Wire Wire Line
	1000 5000 1300 5000
Wire Wire Line
	1000 5100 1300 5100
Wire Wire Line
	1000 5200 1300 5200
Connection ~ 3500 2400
Connection ~ 3600 2300
Wire Wire Line
	3700 3500 3700 2000
Connection ~ 3700 2000
Wire Wire Line
	3800 3600 3800 1900
Connection ~ 3800 1900
Wire Wire Line
	3900 3200 3900 1100
Wire Wire Line
	3900 1100 5600 1100
Wire Wire Line
	5600 1100 5600 1800
Wire Wire Line
	5600 1800 5100 1800
Wire Wire Line
	4000 3300 4000 1000
Wire Wire Line
	4000 1000 5700 1000
Wire Wire Line
	5700 1000 5700 1900
Wire Wire Line
	5700 1900 5100 1900
Wire Wire Line
	4100 3700 4100 900 
Wire Wire Line
	4100 900  5500 900 
Wire Wire Line
	5500 900  5500 1600
Wire Wire Line
	5500 1600 5100 1600
Wire Wire Line
	4400 1600 4200 1600
Wire Wire Line
	4200 1600 4200 1200
Wire Wire Line
	4200 1200 5400 1200
Wire Wire Line
	5400 1200 5400 3300
Wire Wire Line
	3500 1300 5300 1300
Wire Wire Line
	5300 1300 5300 3400
Connection ~ 3500 1300
Wire Wire Line
	4500 3400 4000 3400
Wire Wire Line
	4000 3400 4000 3800
Text Label 5500 3200 0    60   ~ 0
~IO2
NoConn ~ 3300 2400
NoConn ~ 3300 2500
NoConn ~ 5100 1700
NoConn ~ 5100 2000
NoConn ~ 5100 2100
NoConn ~ 5100 2200
$EndSCHEMATC
