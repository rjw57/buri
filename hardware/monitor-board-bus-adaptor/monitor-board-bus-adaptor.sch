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
LIBS:monitor-board-bus-adaptor-cache
EELAYER 24 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 4350 2450 0    60   ~ 0
A0
Text Label 4350 2550 0    60   ~ 0
A1
Text Label 4350 2650 0    60   ~ 0
A2
Text Label 4350 2750 0    60   ~ 0
A3
Text Label 4350 2850 0    60   ~ 0
A4
Text Label 4350 2950 0    60   ~ 0
A5
Text Label 4350 3050 0    60   ~ 0
A6
Text Label 4350 3150 0    60   ~ 0
A7
Text Label 4350 3350 0    60   ~ 0
A8
Text Label 4350 3450 0    60   ~ 0
A9
Text Label 4350 3550 0    60   ~ 0
A10
Text Label 4350 3650 0    60   ~ 0
A11
Text Label 4350 3750 0    60   ~ 0
A12
Text Label 4350 3850 0    60   ~ 0
A13
Text Label 4350 4050 0    60   ~ 0
A15
Text Label 4350 4250 0    60   ~ 0
D0
Text Label 4350 4350 0    60   ~ 0
D1
Text Label 4350 4450 0    60   ~ 0
D2
Text Label 4350 4550 0    60   ~ 0
D3
Text Label 4350 4650 0    60   ~ 0
D4
Text Label 4350 4750 0    60   ~ 0
D5
Text Label 4350 4850 0    60   ~ 0
D6
Text Label 4350 4950 0    60   ~ 0
D7
Text Label 4350 3950 0    60   ~ 0
A14
Text GLabel 3300 2950 0    60   Input ~ 0
SYNC
Text GLabel 3100 3450 0    60   Input ~ 0
R/~W
Text GLabel 3100 3250 0    60   Input ~ 0
PHI2
Text GLabel 3350 3150 0    60   Input ~ 0
~RST
Text GLabel 3300 2750 0    60   Output ~ 0
~IRQ
Text GLabel 2950 2650 0    60   Output ~ 0
RDY
Text GLabel 3350 3350 0    60   Output ~ 0
BE
$Comp
L CONN_8 P6
U 1 1 552FE6F4
P 5100 4600
F 0 "P6" V 5050 4600 60  0000 C CNN
F 1 "DATA" V 5150 4600 60  0000 C CNN
F 2 "" H 5100 4600 60  0000 C CNN
F 3 "" H 5100 4600 60  0000 C CNN
	1    5100 4600
	1    0    0    -1  
$EndComp
$Comp
L CONN_8 P4
U 1 1 552FE6FA
P 5100 2800
F 0 "P4" V 5050 2800 60  0000 C CNN
F 1 "ADDR1" V 5150 2800 60  0000 C CNN
F 2 "" H 5100 2800 60  0000 C CNN
F 3 "" H 5100 2800 60  0000 C CNN
	1    5100 2800
	1    0    0    -1  
$EndComp
$Comp
L CONN_8 P5
U 1 1 552FE700
P 5100 3700
F 0 "P5" V 5050 3700 60  0000 C CNN
F 1 "ADDR2" V 5150 3700 60  0000 C CNN
F 2 "" H 5100 3700 60  0000 C CNN
F 3 "" H 5100 3700 60  0000 C CNN
	1    5100 3700
	1    0    0    -1  
$EndComp
$Comp
L CONN_6 P1
U 1 1 552FE706
P 3800 2700
F 0 "P1" V 3750 2700 60  0000 C CNN
F 1 "CTRL1" V 3850 2700 60  0000 C CNN
F 2 "" H 3800 2700 60  0000 C CNN
F 3 "" H 3800 2700 60  0000 C CNN
	1    3800 2700
	1    0    0    -1  
$EndComp
$Comp
L CONN_6 P2
U 1 1 552FE70C
P 3800 3400
F 0 "P2" V 3750 3400 60  0000 C CNN
F 1 "CTRL2" V 3850 3400 60  0000 C CNN
F 2 "" H 3800 3400 60  0000 C CNN
F 3 "" H 3800 3400 60  0000 C CNN
	1    3800 3400
	1    0    0    -1  
$EndComp
NoConn ~ 3450 3550
NoConn ~ 3450 3650
Wire Wire Line
	4750 4250 4350 4250
Wire Wire Line
	4350 4350 4750 4350
Wire Wire Line
	4750 4450 4350 4450
Wire Wire Line
	4350 4550 4750 4550
Wire Wire Line
	4750 4650 4350 4650
Wire Wire Line
	4350 4750 4750 4750
Wire Wire Line
	4750 4850 4350 4850
Wire Wire Line
	4350 4950 4750 4950
Wire Wire Line
	4350 2450 4750 2450
Wire Wire Line
	4750 2550 4350 2550
Wire Wire Line
	4350 2650 4750 2650
Wire Wire Line
	4750 2750 4350 2750
Wire Wire Line
	4350 2850 4750 2850
Wire Wire Line
	4750 2950 4350 2950
Wire Wire Line
	4350 3050 4750 3050
Wire Wire Line
	4750 3150 4350 3150
Wire Wire Line
	4750 3450 4350 3450
Wire Wire Line
	4350 3850 4750 3850
Wire Wire Line
	4750 3350 4350 3350
Wire Wire Line
	4350 3750 4750 3750
Wire Wire Line
	4350 3550 4750 3550
Wire Wire Line
	4750 3650 4350 3650
Wire Wire Line
	4350 3950 4750 3950
Wire Wire Line
	4750 4050 4350 4050
Wire Wire Line
	3450 3150 3350 3150
Wire Wire Line
	3450 2650 2950 2650
Wire Wire Line
	3100 3250 3450 3250
Wire Wire Line
	3300 2950 3450 2950
Wire Wire Line
	3450 3350 3350 3350
Wire Wire Line
	3100 3450 3450 3450
Wire Wire Line
	3450 2750 3300 2750
Wire Wire Line
	3450 2850 2950 2850
Wire Wire Line
	2650 2550 3450 2550
$Comp
L CONN_8 P3
U 1 1 552FE735
P 3800 4750
F 0 "P3" V 3750 4750 60  0000 C CNN
F 1 "IO" V 3850 4750 60  0000 C CNN
F 2 "" H 3800 4750 60  0000 C CNN
F 3 "" H 3800 4750 60  0000 C CNN
	1    3800 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 4400 3050 4400
Wire Wire Line
	3450 4500 3300 4500
Wire Wire Line
	3450 4600 3050 4600
Wire Wire Line
	3450 4700 3300 4700
Wire Wire Line
	3450 4800 3050 4800
Wire Wire Line
	3450 4900 3300 4900
Wire Wire Line
	3450 5000 3050 5000
Wire Wire Line
	3450 5100 3300 5100
Text GLabel 3050 4400 0    60   Output ~ 0
~IO0
Text GLabel 3300 4500 0    60   Output ~ 0
~IO1
Text GLabel 3050 4600 0    60   Output ~ 0
~IO2
Text GLabel 3300 4700 0    60   Output ~ 0
~IO3
Text GLabel 3050 4800 0    60   Output ~ 0
~IO4
Text GLabel 3300 4900 0    60   Output ~ 0
~IO5
Text GLabel 3050 5000 0    60   Output ~ 0
~IO6
Text GLabel 3300 5100 0    60   Output ~ 0
~IO7
Text GLabel 2950 2850 0    60   UnSpc ~ 0
VIN
$Comp
L +5V #PWR2
U 1 1 552FE74C
P 3300 2400
F 0 "#PWR2" H 3300 2490 20  0001 C CNN
F 1 "+5V" H 3300 2490 30  0000 C CNN
F 2 "" H 3300 2400 60  0000 C CNN
F 3 "" H 3300 2400 60  0000 C CNN
	1    3300 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 2400 3300 2450
Wire Wire Line
	3300 2450 3450 2450
$Comp
L GND #PWR1
U 1 1 552FE754
P 2650 2600
F 0 "#PWR1" H 2650 2600 30  0001 C CNN
F 1 "GND" H 2650 2530 30  0001 C CNN
F 2 "" H 2650 2600 60  0000 C CNN
F 3 "" H 2650 2600 60  0000 C CNN
	1    2650 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 2550 2650 2600
$Comp
L CONN_13X2 P8
U 1 1 552FE75D
P 7900 5000
F 0 "P8" H 7900 5700 60  0000 C CNN
F 1 "AD_BUS" V 7900 5000 50  0000 C CNN
F 2 "" H 7900 5000 60  0000 C CNN
F 3 "" H 7900 5000 60  0000 C CNN
	1    7900 5000
	1    0    0    -1  
$EndComp
Text Label 7100 4400 0    60   ~ 0
D0
Text Label 7100 4500 0    60   ~ 0
D1
Text Label 7100 4600 0    60   ~ 0
D2
Text Label 7100 4700 0    60   ~ 0
D3
Wire Wire Line
	7500 4400 7100 4400
Wire Wire Line
	7100 4500 7500 4500
Wire Wire Line
	7500 4600 7100 4600
Wire Wire Line
	7100 4700 7500 4700
Text Label 8700 4700 2    60   ~ 0
D4
Text Label 8700 4600 2    60   ~ 0
D5
Text Label 8700 4500 2    60   ~ 0
D6
Text Label 8700 4400 2    60   ~ 0
D7
Wire Wire Line
	8300 4700 8700 4700
Wire Wire Line
	8700 4600 8300 4600
Wire Wire Line
	8300 4500 8700 4500
Wire Wire Line
	8700 4400 8300 4400
Text Label 7100 5600 0    60   ~ 0
A0
Text Label 7100 5500 0    60   ~ 0
A1
Text Label 7100 5400 0    60   ~ 0
A2
Text Label 7100 5300 0    60   ~ 0
A3
Text Label 7100 5200 0    60   ~ 0
A4
Text Label 7100 5100 0    60   ~ 0
A5
Text Label 7100 5000 0    60   ~ 0
A6
Text Label 7100 4900 0    60   ~ 0
A7
Wire Wire Line
	7100 5600 7500 5600
Wire Wire Line
	7500 5500 7100 5500
Wire Wire Line
	7100 5400 7500 5400
Wire Wire Line
	7500 5300 7100 5300
Wire Wire Line
	7100 5200 7500 5200
Wire Wire Line
	7500 5100 7100 5100
Wire Wire Line
	7100 5000 7500 5000
Wire Wire Line
	7500 4900 7100 4900
Text Label 8700 5600 2    60   ~ 0
A8
Text Label 8700 5500 2    60   ~ 0
A9
Text Label 8700 5400 2    60   ~ 0
A10
Text Label 8700 5300 2    60   ~ 0
A11
Text Label 8700 5200 2    60   ~ 0
A12
Text Label 8700 5100 2    60   ~ 0
A13
Text Label 8700 4900 2    60   ~ 0
A15
Text Label 8700 5000 2    60   ~ 0
A14
Wire Wire Line
	8300 5500 8700 5500
Wire Wire Line
	8700 5100 8300 5100
Wire Wire Line
	8300 5600 8700 5600
Wire Wire Line
	8700 5200 8300 5200
Wire Wire Line
	8700 5400 8300 5400
Wire Wire Line
	8300 5300 8700 5300
Wire Wire Line
	8700 5000 8300 5000
Wire Wire Line
	8300 4900 8700 4900
NoConn ~ 8300 4800
NoConn ~ 7500 4800
$Comp
L CONN_13X2 P7
U 1 1 552FE86B
P 7900 2700
F 0 "P7" H 7900 3400 60  0000 C CNN
F 1 "CTRL_BUS" V 7900 2700 50  0000 C CNN
F 2 "" H 7900 2700 60  0000 C CNN
F 3 "" H 7900 2700 60  0000 C CNN
	1    7900 2700
	1    0    0    -1  
$EndComp
NoConn ~ 7500 2100
$Comp
L +5V #PWR3
U 1 1 552FE87D
P 8450 2050
F 0 "#PWR3" H 8450 2140 20  0001 C CNN
F 1 "+5V" H 8450 2140 30  0000 C CNN
F 2 "" H 8450 2050 60  0000 C CNN
F 3 "" H 8450 2050 60  0000 C CNN
	1    8450 2050
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8450 2050 8450 2100
Wire Wire Line
	8450 2100 8400 2100
Wire Wire Line
	8400 2100 8300 2100
Wire Wire Line
	8300 2200 8400 2200
Wire Wire Line
	8400 2200 8400 2100
Connection ~ 8400 2100
Wire Wire Line
	8300 2300 8700 2300
NoConn ~ 8300 2400
NoConn ~ 8300 2500
NoConn ~ 7500 2200
NoConn ~ 7500 2300
NoConn ~ 7500 2400
NoConn ~ 7500 2900
NoConn ~ 7500 3000
NoConn ~ 7500 3100
NoConn ~ 7500 3200
Text Label 2750 2550 0    60   ~ 0
GND
Text Label 8700 2300 2    60   ~ 0
GND
Wire Wire Line
	8300 3000 8700 3000
Text Label 8700 3000 2    60   ~ 0
GND
Wire Wire Line
	7500 3300 7100 3300
Text Label 7100 3300 0    60   ~ 0
GND
Wire Wire Line
	7500 2500 7100 2500
Text Label 7100 2500 0    60   ~ 0
GND
Text GLabel 7100 2700 0    60   Output ~ 0
SYNC
Text GLabel 7400 2600 0    60   Output ~ 0
PHI2
Text GLabel 7400 2800 0    60   Output ~ 0
~RST
Wire Wire Line
	7500 2800 7400 2800
Wire Wire Line
	7400 2600 7500 2600
Wire Wire Line
	7100 2700 7500 2700
Text GLabel 8400 3100 2    60   Output ~ 0
R/~W
Text GLabel 8800 2900 2    60   Input ~ 0
~IRQ
Text GLabel 8400 2600 2    60   Input ~ 0
RDY
Text GLabel 8400 2800 2    60   Input ~ 0
BE
Wire Wire Line
	8300 2600 8400 2600
Wire Wire Line
	8300 2800 8400 2800
Wire Wire Line
	8400 3100 8300 3100
Wire Wire Line
	8300 2900 8800 2900
NoConn ~ 8300 3200
NoConn ~ 8300 3300
$EndSCHEMATC
