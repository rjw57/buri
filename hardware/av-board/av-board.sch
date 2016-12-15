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
LIBS:65xx
LIBS:tms9929
LIBS:ym3014
LIBS:ym3812
LIBS:cy62256
LIBS:av-board-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 4
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 900  4700 0    60   ~ 0
A0
Text Label 900  4800 0    60   ~ 0
A1
Text Label 900  4900 0    60   ~ 0
A2
Text Label 900  5000 0    60   ~ 0
A3
Text Label 900  5100 0    60   ~ 0
A4
Text Label 900  5200 0    60   ~ 0
A5
Text Label 900  5300 0    60   ~ 0
A6
Text Label 900  5400 0    60   ~ 0
A7
Text Label 2100 3700 2    60   ~ 0
A8
Text Label 2100 3800 2    60   ~ 0
A9
Text Label 2100 3900 2    60   ~ 0
A10
Text Label 2100 4000 2    60   ~ 0
A11
Text Label 2100 4100 2    60   ~ 0
A12
Text Label 2100 4200 2    60   ~ 0
A13
Text Label 2100 4300 2    60   ~ 0
A14
Text Label 2100 4400 2    60   ~ 0
A15
Text Label 2100 4700 2    60   ~ 0
A16
Text Label 2100 4800 2    60   ~ 0
A17
Text Label 2100 4900 2    60   ~ 0
A18
Text Label 2100 5000 2    60   ~ 0
A19
Text Label 2100 5100 2    60   ~ 0
A20
Text Label 2100 5200 2    60   ~ 0
A21
Text Label 2100 5300 2    60   ~ 0
A22
Text Label 2100 5400 2    60   ~ 0
A23
$Comp
L +5V #PWR01
U 1 1 584EA813
P 2050 5750
F 0 "#PWR01" H 2050 5600 50  0001 C CNN
F 1 "+5V" H 2050 5890 50  0000 C CNN
F 2 "" H 2050 5750 50  0000 C CNN
F 3 "" H 2050 5750 50  0000 C CNN
	1    2050 5750
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 584EA814
P 2050 6350
F 0 "#PWR02" H 2050 6100 50  0001 C CNN
F 1 "GND" H 2050 6200 50  0000 C CNN
F 2 "" H 2050 6350 50  0000 C CNN
F 3 "" H 2050 6350 50  0000 C CNN
	1    2050 6350
	-1   0    0    -1  
$EndComp
Text Label 2300 6100 2    60   ~ 0
~RST
Text Label 2300 6000 2    60   ~ 0
PHI2
Text Label 700  5800 0    60   ~ 0
BE
Text Label 700  6300 0    60   ~ 0
~IRQ
Text Label 700  6200 0    60   ~ 0
~NMI
Text Label 700  5700 0    60   ~ 0
RDY
Text Label 900  3700 0    60   ~ 0
D0
Text Label 900  3800 0    60   ~ 0
D1
Text Label 900  3900 0    60   ~ 0
D2
Text Label 900  4000 0    60   ~ 0
D3
Text Label 900  4100 0    60   ~ 0
D4
Text Label 900  4200 0    60   ~ 0
D5
Text Label 900  4300 0    60   ~ 0
D6
Text Label 900  4400 0    60   ~ 0
D7
Text Label 700  6400 0    60   ~ 0
R/~W
Text Label 700  6100 0    60   ~ 0
SYNC
Text Label 700  6000 0    60   ~ 0
~ML
Text Label 700  5900 0    60   ~ 0
~VP
Text Label 2300 5900 2    60   ~ 0
~IOPAGE
Wire Wire Line
	900  4700 1100 4700
Wire Wire Line
	900  4800 1100 4800
Wire Wire Line
	900  4900 1100 4900
Wire Wire Line
	900  5000 1100 5000
Wire Wire Line
	900  5100 1100 5100
Wire Wire Line
	900  5200 1100 5200
Wire Wire Line
	900  5300 1100 5300
Wire Wire Line
	900  5400 1100 5400
Wire Wire Line
	2100 3700 1900 3700
Wire Wire Line
	2100 3800 1900 3800
Wire Wire Line
	2100 3900 1900 3900
Wire Wire Line
	2100 4000 1900 4000
Wire Wire Line
	2100 4100 1900 4100
Wire Wire Line
	2100 4200 1900 4200
Wire Wire Line
	2100 4300 1900 4300
Wire Wire Line
	2100 4400 1900 4400
Wire Wire Line
	2100 4700 1900 4700
Wire Wire Line
	2100 4800 1900 4800
Wire Wire Line
	2100 4900 1900 4900
Wire Wire Line
	2100 5000 1900 5000
Wire Wire Line
	2100 5100 1900 5100
Wire Wire Line
	2100 5200 1900 5200
Wire Wire Line
	2100 5300 1900 5300
Wire Wire Line
	2100 5400 1900 5400
Wire Wire Line
	1900 5700 1950 5700
Wire Wire Line
	1950 5700 1950 5800
Wire Wire Line
	1950 5800 1900 5800
Wire Wire Line
	2050 5750 1950 5750
Connection ~ 1950 5750
Wire Wire Line
	1900 6300 2050 6300
Wire Wire Line
	1950 6200 1950 6400
Wire Wire Line
	1950 6400 1900 6400
Wire Wire Line
	2300 6100 1900 6100
Wire Wire Line
	2300 6000 1900 6000
Wire Wire Line
	1100 5800 700  5800
Wire Wire Line
	700  6300 1100 6300
Wire Wire Line
	700  6200 1100 6200
Wire Wire Line
	700  5700 1100 5700
Wire Wire Line
	900  3700 1100 3700
Wire Wire Line
	900  3800 1100 3800
Wire Wire Line
	900  3900 1100 3900
Wire Wire Line
	900  4000 1100 4000
Wire Wire Line
	900  4100 1100 4100
Wire Wire Line
	900  4200 1100 4200
Wire Wire Line
	900  4300 1100 4300
Wire Wire Line
	900  4400 1100 4400
Wire Wire Line
	700  6400 1100 6400
Wire Wire Line
	700  6100 1100 6100
Wire Wire Line
	700  6000 1100 6000
Wire Wire Line
	1100 5900 700  5900
Wire Wire Line
	1900 5900 2300 5900
$Comp
L TEST_1P W1
U 1 1 584EA837
P 1000 7500
F 0 "W1" H 1000 7770 50  0000 C CNN
F 1 "MOUNTING" H 1000 7700 50  0000 C CNN
F 2 "buri3:M3_MOUNT" H 1200 7500 50  0001 C CNN
F 3 "" H 1200 7500 50  0000 C CNN
	1    1000 7500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 584EA838
P 1000 7500
F 0 "#PWR03" H 1000 7250 50  0001 C CNN
F 1 "GND" H 1000 7350 50  0000 C CNN
F 2 "" H 1000 7500 50  0000 C CNN
F 3 "" H 1000 7500 50  0000 C CNN
	1    1000 7500
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P W2
U 1 1 584EA839
P 1400 7500
F 0 "W2" H 1400 7770 50  0000 C CNN
F 1 "MOUNTING" H 1400 7700 50  0000 C CNN
F 2 "buri3:M3_MOUNT" H 1600 7500 50  0001 C CNN
F 3 "" H 1600 7500 50  0000 C CNN
	1    1400 7500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 584EA83A
P 1400 7500
F 0 "#PWR04" H 1400 7250 50  0001 C CNN
F 1 "GND" H 1400 7350 50  0000 C CNN
F 2 "" H 1400 7500 50  0000 C CNN
F 3 "" H 1400 7500 50  0000 C CNN
	1    1400 7500
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P W3
U 1 1 584EA83B
P 1800 7500
F 0 "W3" H 1800 7770 50  0000 C CNN
F 1 "MOUNTING" H 1800 7700 50  0000 C CNN
F 2 "buri3:M3_MOUNT" H 2000 7500 50  0001 C CNN
F 3 "" H 2000 7500 50  0000 C CNN
	1    1800 7500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 584EA83C
P 1800 7500
F 0 "#PWR05" H 1800 7250 50  0001 C CNN
F 1 "GND" H 1800 7350 50  0000 C CNN
F 2 "" H 1800 7500 50  0000 C CNN
F 3 "" H 1800 7500 50  0000 C CNN
	1    1800 7500
	1    0    0    -1  
$EndComp
$Comp
L TEST_1P W4
U 1 1 584EA83D
P 2200 7500
F 0 "W4" H 2200 7770 50  0000 C CNN
F 1 "MOUNTING" H 2200 7700 50  0000 C CNN
F 2 "buri3:M3_MOUNT" H 2400 7500 50  0001 C CNN
F 3 "" H 2400 7500 50  0000 C CNN
	1    2200 7500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 584EA83E
P 2200 7500
F 0 "#PWR06" H 2200 7250 50  0001 C CNN
F 1 "GND" H 2200 7350 50  0000 C CNN
F 2 "" H 2200 7500 50  0000 C CNN
F 3 "" H 2200 7500 50  0000 C CNN
	1    2200 7500
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P1
U 1 1 584EA855
P 1300 4050
F 0 "P1" H 1300 4500 50  0000 C CNN
F 1 "D0..D7" V 1400 4050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08" H 1300 4050 50  0001 C CNN
F 3 "" H 1300 4050 50  0000 C CNN
	1    1300 4050
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P2
U 1 1 584EA856
P 1300 5050
F 0 "P2" H 1300 5500 50  0000 C CNN
F 1 "A0..A7" V 1400 5050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08" H 1300 5050 50  0001 C CNN
F 3 "" H 1300 5050 50  0000 C CNN
	1    1300 5050
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P4
U 1 1 584EA857
P 1700 4050
F 0 "P4" H 1700 4500 50  0000 C CNN
F 1 "A8..A15" V 1800 4050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08" H 1700 4050 50  0001 C CNN
F 3 "" H 1700 4050 50  0000 C CNN
	1    1700 4050
	-1   0    0    -1  
$EndComp
$Comp
L CONN_01X08 P5
U 1 1 584EA858
P 1700 5050
F 0 "P5" H 1700 5500 50  0000 C CNN
F 1 "A16..A23" V 1800 5050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08" H 1700 5050 50  0001 C CNN
F 3 "" H 1700 5050 50  0000 C CNN
	1    1700 5050
	-1   0    0    -1  
$EndComp
$Comp
L CONN_01X08 P3
U 1 1 584EA859
P 1300 6050
F 0 "P3" H 1300 6500 50  0000 C CNN
F 1 "CTRL1" V 1400 6050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08" H 1300 6050 50  0001 C CNN
F 3 "" H 1300 6050 50  0000 C CNN
	1    1300 6050
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X08 P6
U 1 1 584EA85A
P 1700 6050
F 0 "P6" H 1700 6500 50  0000 C CNN
F 1 "CTRL2" V 1800 6050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08" H 1700 6050 50  0001 C CNN
F 3 "" H 1700 6050 50  0000 C CNN
	1    1700 6050
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1900 6200 1950 6200
Connection ~ 1950 6300
Wire Wire Line
	2050 6300 2050 6350
$Comp
L WD65C22 U3
U 1 1 584EA68F
P 3950 1700
F 0 "U3" H 3650 550 60  0000 C CNN
F 1 "WD65C22" V 3950 1600 60  0000 C CNN
F 2 "Housings_DIP:DIP-40_W15.24mm_LongPads" H 3450 2000 60  0001 C CNN
F 3 "" H 3450 2000 60  0000 C CNN
	1    3950 1700
	-1   0    0    -1  
$EndComp
Text Label 3100 1300 0    60   ~ 0
D0
Text Label 3100 1400 0    60   ~ 0
D1
Text Label 3100 1500 0    60   ~ 0
D2
Text Label 3100 1600 0    60   ~ 0
D3
Text Label 3100 1700 0    60   ~ 0
D4
Text Label 3100 1800 0    60   ~ 0
D5
Text Label 3100 1900 0    60   ~ 0
D6
Text Label 3100 2000 0    60   ~ 0
D7
Wire Wire Line
	3100 1300 3300 1300
Wire Wire Line
	3100 1400 3300 1400
Wire Wire Line
	3100 1500 3300 1500
Wire Wire Line
	3100 1600 3300 1600
Wire Wire Line
	3100 1700 3300 1700
Wire Wire Line
	3100 1800 3300 1800
Wire Wire Line
	3100 1900 3300 1900
Wire Wire Line
	3100 2000 3300 2000
Text Label 3100 1200 0    60   ~ 0
~RST
Wire Wire Line
	3100 1200 3300 1200
Text Label 3100 800  0    60   ~ 0
A0
Text Label 3100 900  0    60   ~ 0
A1
Text Label 3100 1000 0    60   ~ 0
A2
Text Label 3100 1100 0    60   ~ 0
A3
Wire Wire Line
	3100 800  3300 800 
Wire Wire Line
	3100 900  3300 900 
Wire Wire Line
	3100 1000 3300 1000
Wire Wire Line
	3100 1100 3300 1100
Text Label 3100 2100 0    60   ~ 0
PHI2
Text Label 4600 4500 0    60   ~ 0
~IOPAGE
Wire Wire Line
	3100 2100 3300 2100
Wire Wire Line
	4800 4500 4600 4500
Text Label 2900 2400 0    60   ~ 0
R/~W
Wire Wire Line
	2900 2400 3300 2400
$Comp
L D_Small D1
U 1 1 584EAAA4
P 3200 2500
F 0 "D1" H 3150 2400 50  0000 L CNN
F 1 "D_Small" H 3050 2420 50  0001 L CNN
F 2 "Diodes_SMD:SMA-SMB_Universal_Handsoldering" V 3200 2500 50  0001 C CNN
F 3 "" V 3200 2500 50  0000 C CNN
	1    3200 2500
	-1   0    0    -1  
$EndComp
Text Label 2900 2500 0    60   ~ 0
~IRQ
Wire Wire Line
	2900 2500 3100 2500
$Comp
L 74LS138 U4
U 1 1 584EAE30
P 5400 4150
F 0 "U4" H 5500 4650 50  0000 C CNN
F 1 "74HC138" H 5100 3600 50  0000 C CNN
F 2 "Housings_SOIC:SOIC-16_3.9x9.9mm_Pitch1.27mm" H 5400 4150 50  0001 C CNN
F 3 "" H 5400 4150 50  0000 C CNN
	1    5400 4150
	1    0    0    -1  
$EndComp
Text Label 4600 4000 0    60   ~ 0
A4
Text Label 4600 4300 0    60   ~ 0
A5
Text Label 3100 4300 0    60   ~ 0
A6
Text Label 3100 4500 0    60   ~ 0
A7
Wire Wire Line
	4600 4000 4800 4000
Wire Wire Line
	4600 4300 4800 4300
Wire Wire Line
	3100 4300 3300 4300
Wire Wire Line
	3100 4500 3300 4500
Text Label 4600 3900 0    60   ~ 0
A3
Wire Wire Line
	4600 3900 4800 3900
$Comp
L +5V #PWR07
U 1 1 584EB206
P 5400 3700
F 0 "#PWR07" H 5400 3550 50  0001 C CNN
F 1 "+5V" H 5400 3840 50  0000 C CNN
F 2 "" H 5400 3700 50  0000 C CNN
F 3 "" H 5400 3700 50  0000 C CNN
	1    5400 3700
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 584EB238
P 5400 4600
F 0 "#PWR08" H 5400 4350 50  0001 C CNN
F 1 "GND" H 5400 4450 50  0000 C CNN
F 2 "" H 5400 4600 50  0000 C CNN
F 3 "" H 5400 4600 50  0000 C CNN
	1    5400 4600
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 584EB277
P 3950 2750
F 0 "#PWR09" H 3950 2500 50  0001 C CNN
F 1 "GND" H 3950 2600 50  0000 C CNN
F 2 "" H 3950 2750 50  0000 C CNN
F 3 "" H 3950 2750 50  0000 C CNN
	1    3950 2750
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR010
U 1 1 584EB2E8
P 3950 750
F 0 "#PWR010" H 3950 600 50  0001 C CNN
F 1 "+5V" H 3950 890 50  0000 C CNN
F 2 "" H 3950 750 50  0000 C CNN
F 3 "" H 3950 750 50  0000 C CNN
	1    3950 750 
	1    0    0    -1  
$EndComp
Text Notes 5000 5050 0    60   ~ 0
8 x 4-byte regions\n$E0-$FF in IO page
Wire Wire Line
	3300 2200 2900 2200
$Comp
L 74HC00 U2
U 1 1 584EBCE5
P 3900 4400
F 0 "U2" H 3900 4450 50  0000 C CNN
F 1 "74HC00" H 3900 4300 50  0000 C CNN
F 2 "Housings_SOIC:SOIC-14_3.9x8.7mm_Pitch1.27mm" H 3900 4400 50  0001 C CNN
F 3 "" H 3900 4400 50  0000 C CNN
	1    3900 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 4400 4500 4400
Text Label 4600 3800 0    60   ~ 0
A2
Wire Wire Line
	4600 3800 4800 3800
$Comp
L 74LS138 U1
U 1 1 584EC276
P 2100 2650
F 0 "U1" H 2200 3150 50  0000 C CNN
F 1 "74HC138" H 1800 2100 50  0000 C CNN
F 2 "Housings_SOIC:SOIC-16_3.9x9.9mm_Pitch1.27mm" H 2100 2650 50  0001 C CNN
F 3 "" H 2100 2650 50  0000 C CNN
	1    2100 2650
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR011
U 1 1 584EC27C
P 2100 2200
F 0 "#PWR011" H 2100 2050 50  0001 C CNN
F 1 "+5V" H 2100 2340 50  0000 C CNN
F 2 "" H 2100 2200 50  0000 C CNN
F 3 "" H 2100 2200 50  0000 C CNN
	1    2100 2200
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 584EC282
P 2100 3100
F 0 "#PWR012" H 2100 2850 50  0001 C CNN
F 1 "GND" H 2100 2950 50  0000 C CNN
F 2 "" H 2100 3100 50  0000 C CNN
F 3 "" H 2100 3100 50  0000 C CNN
	1    2100 3100
	-1   0    0    -1  
$EndComp
Text Label 1200 3000 0    60   ~ 0
~IOPAGE
Wire Wire Line
	1500 3000 1200 3000
Text Label 1200 2500 0    60   ~ 0
A6
Text Label 1200 2900 0    60   ~ 0
A7
Wire Wire Line
	1200 2500 1500 2500
Wire Wire Line
	1200 2900 1500 2900
Text Label 1200 2300 0    60   ~ 0
A4
Text Label 1200 2400 0    60   ~ 0
A5
Wire Wire Line
	1200 2300 1500 2300
Wire Wire Line
	1200 2400 1500 2400
$Comp
L +5V #PWR013
U 1 1 584EC4AC
P 1500 2800
F 0 "#PWR013" H 1500 2650 50  0001 C CNN
F 1 "+5V" H 1500 2940 50  0000 C CNN
F 2 "" H 1500 2800 50  0000 C CNN
F 3 "" H 1500 2800 50  0000 C CNN
	1    1500 2800
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3300 2300 2700 2300
$Comp
L +5V #PWR014
U 1 1 584EC708
P 2900 2200
F 0 "#PWR014" H 2900 2050 50  0001 C CNN
F 1 "+5V" H 2900 2340 50  0000 C CNN
F 2 "" H 2900 2200 50  0000 C CNN
F 3 "" H 2900 2200 50  0000 C CNN
	1    2900 2200
	1    0    0    -1  
$EndComp
NoConn ~ 2700 2400
NoConn ~ 2700 2500
NoConn ~ 2700 2600
NoConn ~ 2700 2700
NoConn ~ 2700 2800
NoConn ~ 2700 2900
NoConn ~ 2700 3000
Text Notes 2650 1850 2    60   ~ 0
VIA at $00-$0F\nin IO page
Text Label 9050 3700 2    60   ~ 0
D0
Text Label 9050 3800 2    60   ~ 0
D1
Text Label 9050 3900 2    60   ~ 0
D2
Text Label 9050 4000 2    60   ~ 0
D3
Text Label 9050 4100 2    60   ~ 0
D4
Text Label 9050 4200 2    60   ~ 0
D5
Text Label 9050 4300 2    60   ~ 0
D6
Text Label 9050 4400 2    60   ~ 0
D7
Wire Wire Line
	9050 3700 8850 3700
Wire Wire Line
	9050 3800 8850 3800
Wire Wire Line
	9050 3900 8850 3900
Wire Wire Line
	9050 4000 8850 4000
Wire Wire Line
	9050 4100 8850 4100
Wire Wire Line
	9050 4200 8850 4200
Wire Wire Line
	9050 4300 8850 4300
Wire Wire Line
	9050 4400 8850 4400
Text Label 7900 3700 0    60   ~ 0
A0
Wire Wire Line
	7900 3700 8200 3700
Text Label 7900 4400 0    60   ~ 0
~RST
Wire Wire Line
	7900 4400 8200 4400
Text Label 7900 4300 0    60   ~ 0
~IRQ
Wire Wire Line
	7900 4300 8200 4300
Text Label 7900 4000 0    60   ~ 0
R/~W
Wire Wire Line
	7900 4000 8200 4000
Text Label 6700 3900 0    60   ~ 0
~VDPS
Wire Wire Line
	6700 3900 7000 3900
Text Label 6400 3800 2    60   ~ 0
~VDPS
Wire Wire Line
	6400 3800 6000 3800
$Comp
L Q_NPN_BCE Q2
U 1 1 5852B9A8
P 9100 1400
F 0 "Q2" H 9400 1450 50  0000 R CNN
F 1 "NPN" H 9350 1350 50  0000 L CNN
F 2 "" H 9300 1500 50  0000 C CNN
F 3 "" H 9100 1400 50  0000 C CNN
	1    9100 1400
	1    0    0    -1  
$EndComp
$Comp
L R_Small R2
U 1 1 5852BD05
P 9200 1900
F 0 "R2" H 9230 1920 50  0000 L CNN
F 1 "330" H 9230 1860 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 9200 1900 50  0001 C CNN
F 3 "" H 9200 1900 50  0000 C CNN
	1    9200 1900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR015
U 1 1 5852BEB6
P 9200 2000
F 0 "#PWR015" H 9200 1750 50  0001 C CNN
F 1 "GND" H 9200 1850 50  0000 C CNN
F 2 "" H 9200 2000 50  0000 C CNN
F 3 "" H 9200 2000 50  0000 C CNN
	1    9200 2000
	-1   0    0    -1  
$EndComp
$Comp
L +5V #PWR016
U 1 1 5852C0AD
P 9200 1200
F 0 "#PWR016" H 9200 1050 50  0001 C CNN
F 1 "+5V" H 9200 1340 50  0000 C CNN
F 2 "" H 9200 1200 50  0000 C CNN
F 3 "" H 9200 1200 50  0000 C CNN
	1    9200 1200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9200 1600 9200 1800
Wire Wire Line
	9400 1700 9200 1700
Connection ~ 9200 1700
$Comp
L GND #PWR017
U 1 1 5852C7C4
P 9550 2000
F 0 "#PWR017" H 9550 1750 50  0001 C CNN
F 1 "GND" H 9550 1850 50  0000 C CNN
F 2 "" H 9550 2000 50  0000 C CNN
F 3 "" H 9550 2000 50  0000 C CNN
	1    9550 2000
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9550 1900 9550 2000
$Comp
L Q_NPN_BCE Q3
U 1 1 5852D06B
P 10200 1400
F 0 "Q3" H 10500 1450 50  0000 R CNN
F 1 "NPN" H 10450 1350 50  0000 L CNN
F 2 "" H 10400 1500 50  0000 C CNN
F 3 "" H 10200 1400 50  0000 C CNN
	1    10200 1400
	1    0    0    -1  
$EndComp
$Comp
L R_Small R3
U 1 1 5852D071
P 10300 1900
F 0 "R3" H 10330 1920 50  0000 L CNN
F 1 "330" H 10330 1860 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 10300 1900 50  0001 C CNN
F 3 "" H 10300 1900 50  0000 C CNN
	1    10300 1900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR018
U 1 1 5852D077
P 10300 2000
F 0 "#PWR018" H 10300 1750 50  0001 C CNN
F 1 "GND" H 10300 1850 50  0000 C CNN
F 2 "" H 10300 2000 50  0000 C CNN
F 3 "" H 10300 2000 50  0000 C CNN
	1    10300 2000
	-1   0    0    -1  
$EndComp
$Comp
L +5V #PWR019
U 1 1 5852D07D
P 10300 1200
F 0 "#PWR019" H 10300 1050 50  0001 C CNN
F 1 "+5V" H 10300 1340 50  0000 C CNN
F 2 "" H 10300 1200 50  0000 C CNN
F 3 "" H 10300 1200 50  0000 C CNN
	1    10300 1200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	10300 1600 10300 1800
Wire Wire Line
	10500 1700 10300 1700
Connection ~ 10300 1700
$Comp
L GND #PWR020
U 1 1 5852D08D
P 10650 2000
F 0 "#PWR020" H 10650 1750 50  0001 C CNN
F 1 "GND" H 10650 1850 50  0000 C CNN
F 2 "" H 10650 2000 50  0000 C CNN
F 3 "" H 10650 2000 50  0000 C CNN
	1    10650 2000
	-1   0    0    -1  
$EndComp
Wire Wire Line
	10650 1900 10650 2000
$Comp
L Q_NPN_BCE Q1
U 1 1 5852D419
P 8000 1400
F 0 "Q1" H 8300 1450 50  0000 R CNN
F 1 "NPN" H 8250 1350 50  0000 L CNN
F 2 "" H 8200 1500 50  0000 C CNN
F 3 "" H 8000 1400 50  0000 C CNN
	1    8000 1400
	1    0    0    -1  
$EndComp
$Comp
L R_Small R1
U 1 1 5852D41F
P 8100 1900
F 0 "R1" H 8130 1920 50  0000 L CNN
F 1 "330" H 8130 1860 50  0000 L CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" H 8100 1900 50  0001 C CNN
F 3 "" H 8100 1900 50  0000 C CNN
	1    8100 1900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR021
U 1 1 5852D425
P 8100 2000
F 0 "#PWR021" H 8100 1750 50  0001 C CNN
F 1 "GND" H 8100 1850 50  0000 C CNN
F 2 "" H 8100 2000 50  0000 C CNN
F 3 "" H 8100 2000 50  0000 C CNN
	1    8100 2000
	-1   0    0    -1  
$EndComp
$Comp
L +5V #PWR022
U 1 1 5852D42B
P 8100 1200
F 0 "#PWR022" H 8100 1050 50  0001 C CNN
F 1 "+5V" H 8100 1340 50  0000 C CNN
F 2 "" H 8100 1200 50  0000 C CNN
F 3 "" H 8100 1200 50  0000 C CNN
	1    8100 1200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8100 1600 8100 1800
Wire Wire Line
	8300 1700 8100 1700
Connection ~ 8100 1700
$Comp
L GND #PWR023
U 1 1 5852D43B
P 8450 2000
F 0 "#PWR023" H 8450 1750 50  0001 C CNN
F 1 "GND" H 8450 1850 50  0000 C CNN
F 2 "" H 8450 2000 50  0000 C CNN
F 3 "" H 8450 2000 50  0000 C CNN
	1    8450 2000
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8450 1900 8450 2000
Text Label 9100 4600 2    60   ~ 0
Y
Text Label 9100 4700 2    60   ~ 0
R-Y
Text Label 9100 4800 2    60   ~ 0
B-Y
Wire Wire Line
	9100 4800 8850 4800
Wire Wire Line
	8850 4700 9100 4700
Wire Wire Line
	9100 4600 8850 4600
Text Label 8650 1400 0    60   ~ 0
Y
Text Label 7550 1400 0    60   ~ 0
R-Y
Text Label 9750 1400 0    60   ~ 0
B-Y
Wire Wire Line
	9750 1400 10000 1400
Wire Wire Line
	7800 1400 7550 1400
Wire Wire Line
	8650 1400 8900 1400
$Comp
L BNC P9
U 1 1 5852D083
P 10650 1700
F 0 "P9" H 10660 1820 50  0000 C CNN
F 1 "Pb" H 10760 1640 50  0000 C CNN
F 2 "w_conn_av:rca_black" H 10650 1700 50  0001 C CNN
F 3 "" H 10650 1700 50  0000 C CNN
	1    10650 1700
	1    0    0    -1  
$EndComp
$Comp
L BNC P8
U 1 1 5852C219
P 9550 1700
F 0 "P8" H 9560 1820 50  0000 C CNN
F 1 "Y" H 9660 1640 50  0000 C CNN
F 2 "w_conn_av:rca_black" H 9550 1700 50  0001 C CNN
F 3 "" H 9550 1700 50  0000 C CNN
	1    9550 1700
	1    0    0    -1  
$EndComp
$Comp
L BNC P7
U 1 1 5852D431
P 8450 1700
F 0 "P7" H 8460 1820 50  0000 C CNN
F 1 "Pr" H 8560 1640 50  0000 C CNN
F 2 "w_conn_av:rca_black" H 8450 1700 50  0001 C CNN
F 3 "" H 8450 1700 50  0000 C CNN
	1    8450 1700
	1    0    0    -1  
$EndComp
$Sheet
S 5800 1350 700  1100
U 5852CC0E
F0 "Sound" 60
F1 "sound.sch" 60
F2 "~SEL" I L 5800 1450 60 
F3 "R" I L 5800 1550 60 
F4 "W" I L 5800 1650 60 
F5 "D0" B R 6500 1450 60 
F6 "D1" B R 6500 1550 60 
F7 "D2" B R 6500 1650 60 
F8 "D3" B R 6500 1750 60 
F9 "D4" B R 6500 1850 60 
F10 "D5" B R 6500 1950 60 
F11 "D6" B R 6500 2050 60 
F12 "D7" B R 6500 2150 60 
F13 "A0" I L 5800 2350 60 
F14 "~RST" I L 5800 1850 60 
F15 "~IRQ" O L 5800 1750 60 
F16 "3.58M" I L 5800 2050 60 
F17 "OUT" O R 6500 2350 60 
$EndSheet
$Sheet
S 8200 3600 650  1300
U 584EB0A1
F0 "Video" 60
F1 "vdp.sch" 60
F2 "D0" B R 8850 3700 60 
F3 "D1" B R 8850 3800 60 
F4 "D2" B R 8850 3900 60 
F5 "D3" B R 8850 4000 60 
F6 "D4" B R 8850 4100 60 
F7 "D5" B R 8850 4200 60 
F8 "D6" B R 8850 4300 60 
F9 "D7" B R 8850 4400 60 
F10 "A0" I L 8200 3700 60 
F11 "~RST" I L 8200 4400 60 
F12 "~IRQ" O L 8200 4300 60 
F13 "Y" O R 8850 4600 60 
F14 "R-Y" O R 8850 4700 60 
F15 "B-Y" O R 8850 4800 60 
F16 "SEL" I L 8200 3900 60 
F17 "R" I L 8200 4000 60 
F18 "W" I L 8200 4100 60 
F19 "10.7M" I L 8200 4700 60 
F20 "~10.7M" I L 8200 4800 60 
$EndSheet
Text Label 7900 4100 0    60   ~ 0
W/~R
Wire Wire Line
	7900 4100 8200 4100
$Comp
L 74HC04 U5
U 1 1 5852E566
P 7450 3900
F 0 "U5" H 7600 4000 50  0000 C CNN
F 1 "74HC04" H 7650 3800 50  0000 C CNN
F 2 "" H 7450 3900 50  0000 C CNN
F 3 "" H 7450 3900 50  0000 C CNN
	1    7450 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7900 3900 8200 3900
$Comp
L +5V #PWR024
U 1 1 5852EB44
P 7400 3800
F 0 "#PWR024" H 7400 3650 50  0001 C CNN
F 1 "+5V" H 7400 3940 50  0000 C CNN
F 2 "" H 7400 3800 50  0000 C CNN
F 3 "" H 7400 3800 50  0000 C CNN
	1    7400 3800
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR025
U 1 1 5852EC00
P 7400 4000
F 0 "#PWR025" H 7400 3750 50  0001 C CNN
F 1 "GND" H 7400 3850 50  0000 C CNN
F 2 "" H 7400 4000 50  0000 C CNN
F 3 "" H 7400 4000 50  0000 C CNN
	1    7400 4000
	-1   0    0    -1  
$EndComp
$Comp
L 74HC04 U5
U 2 1 5852F3C5
P 9550 5800
F 0 "U5" H 9700 5900 50  0000 C CNN
F 1 "74HC04" H 9750 5700 50  0000 C CNN
F 2 "" H 9550 5800 50  0000 C CNN
F 3 "" H 9550 5800 50  0000 C CNN
	2    9550 5800
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR026
U 1 1 5852F3CB
P 9500 5700
F 0 "#PWR026" H 9500 5550 50  0001 C CNN
F 1 "+5V" H 9500 5840 50  0000 C CNN
F 2 "" H 9500 5700 50  0000 C CNN
F 3 "" H 9500 5700 50  0000 C CNN
	1    9500 5700
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR027
U 1 1 5852F3D1
P 9500 5900
F 0 "#PWR027" H 9500 5650 50  0001 C CNN
F 1 "GND" H 9500 5750 50  0000 C CNN
F 2 "" H 9500 5900 50  0000 C CNN
F 3 "" H 9500 5900 50  0000 C CNN
	1    9500 5900
	-1   0    0    -1  
$EndComp
Text Label 8800 5800 0    60   ~ 0
R/~W
Wire Wire Line
	8800 5800 9100 5800
Text Label 10300 5800 2    60   ~ 0
W/~R
Wire Wire Line
	10300 5800 10000 5800
Text Label 6400 3900 2    60   ~ 0
~SNDS
Wire Wire Line
	6400 3900 6000 3900
Text Label 5500 1450 0    60   ~ 0
~SNDS
Wire Wire Line
	5500 1450 5800 1450
Text Label 5500 1550 0    60   ~ 0
R/~W
Wire Wire Line
	5500 1550 5800 1550
Text Label 5500 1650 0    60   ~ 0
W/~R
Wire Wire Line
	5500 1650 5800 1650
Text Label 5500 2350 0    60   ~ 0
A0
Wire Wire Line
	5500 2350 5800 2350
Text Label 6700 1450 2    60   ~ 0
D0
Text Label 6700 1550 2    60   ~ 0
D1
Text Label 6700 1650 2    60   ~ 0
D2
Text Label 6700 1750 2    60   ~ 0
D3
Text Label 6700 1850 2    60   ~ 0
D4
Text Label 6700 1950 2    60   ~ 0
D5
Text Label 6700 2050 2    60   ~ 0
D6
Text Label 6700 2150 2    60   ~ 0
D7
Wire Wire Line
	6700 1450 6500 1450
Wire Wire Line
	6700 1550 6500 1550
Wire Wire Line
	6700 1650 6500 1650
Wire Wire Line
	6700 1750 6500 1750
Wire Wire Line
	6700 1850 6500 1850
Wire Wire Line
	6700 1950 6500 1950
Wire Wire Line
	6700 2050 6500 2050
Wire Wire Line
	6700 2150 6500 2150
Text Label 5500 1850 0    60   ~ 0
~RST
Wire Wire Line
	5500 1850 5800 1850
Text Label 5500 1750 0    60   ~ 0
~IRQ
Wire Wire Line
	5500 1750 5800 1750
$Sheet
S 3650 5850 700  300 
U 5853EEF0
F0 "Clock" 60
F1 "clock.sch" 60
F2 "10.7M" O R 4350 5950 60 
F3 "~10.7M" O R 4350 6050 60 
$EndSheet
Text Label 7900 4800 0    60   ~ 0
~10.7M
Wire Wire Line
	7900 4800 8200 4800
Text Label 7900 4700 0    60   ~ 0
10.7M
Wire Wire Line
	7900 4700 8200 4700
Text Label 4650 6050 2    60   ~ 0
~10.7M
Wire Wire Line
	4650 6050 4350 6050
Text Label 4650 5950 2    60   ~ 0
10.7M
Wire Wire Line
	4650 5950 4350 5950
$EndSCHEMATC
