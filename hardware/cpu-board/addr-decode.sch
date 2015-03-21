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
Sheet 2 5
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 3600 5200 0    60   Input ~ 0
A15
Text GLabel 3600 4950 0    60   Input ~ 0
A14
Text GLabel 3600 4650 0    60   Input ~ 0
A13
Text GLabel 3600 3550 0    60   Input ~ 0
A12
$Comp
L 4012 U8
U 1 1 54E60B13
P 4900 4700
F 0 "U8" H 4900 4800 60  0000 C CNN
F 1 "4012" H 4900 4600 60  0000 C CNN
F 2 "" H 4900 4700 60  0000 C CNN
F 3 "" H 4900 4700 60  0000 C CNN
	1    4900 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 5200 7300 5200
Wire Wire Line
	4100 3750 4100 5200
Wire Wire Line
	4100 4850 4300 4850
Wire Wire Line
	4000 4950 3600 4950
Wire Wire Line
	4000 3650 4000 4950
Wire Wire Line
	4000 4750 4300 4750
Connection ~ 4100 5200
Wire Wire Line
	3600 4650 4300 4650
Wire Wire Line
	5500 4700 7300 4700
$Comp
L 4012 U7
U 2 1 54E60BC0
P 4900 3700
F 0 "U7" H 4900 3800 60  0000 C CNN
F 1 "4012" H 4900 3600 60  0000 C CNN
F 2 "" H 4900 3700 60  0000 C CNN
F 3 "" H 4900 3700 60  0000 C CNN
	2    4900 3700
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR032
U 1 1 54E60BCB
P 4700 4400
F 0 "#PWR032" H 4700 4490 20  0001 C CNN
F 1 "+5V" H 4700 4490 30  0000 C CNN
F 2 "" H 4700 4400 60  0000 C CNN
F 3 "" H 4700 4400 60  0000 C CNN
	1    4700 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 4400 4700 4500
Wire Wire Line
	4200 4450 4700 4450
Connection ~ 4700 4450
$Comp
L GND #PWR033
U 1 1 54E60BF3
P 4700 4950
F 0 "#PWR033" H 4700 4950 30  0001 C CNN
F 1 "GND" H 4700 4880 30  0001 C CNN
F 2 "" H 4700 4950 60  0000 C CNN
F 3 "" H 4700 4950 60  0000 C CNN
	1    4700 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 4900 4700 4950
$Comp
L +5V #PWR034
U 1 1 54E60C15
P 4700 3450
F 0 "#PWR034" H 4700 3540 20  0001 C CNN
F 1 "+5V" H 4700 3540 30  0000 C CNN
F 2 "" H 4700 3450 60  0000 C CNN
F 3 "" H 4700 3450 60  0000 C CNN
	1    4700 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 3450 4700 3500
$Comp
L GND #PWR035
U 1 1 54E60C45
P 4700 3950
F 0 "#PWR035" H 4700 3950 30  0001 C CNN
F 1 "GND" H 4700 3880 30  0001 C CNN
F 2 "" H 4700 3950 60  0000 C CNN
F 3 "" H 4700 3950 60  0000 C CNN
	1    4700 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 3900 4700 3950
Wire Wire Line
	5600 4700 5600 4150
Wire Wire Line
	4200 4150 4200 3850
Wire Wire Line
	4200 3850 4300 3850
Connection ~ 5600 4700
Text GLabel 3600 3200 0    60   Input ~ 0
A11
Text GLabel 3600 3000 0    60   Input ~ 0
A10
Connection ~ 4000 4750
Wire Wire Line
	4000 3650 4300 3650
Wire Wire Line
	4100 3750 4300 3750
Connection ~ 4100 4850
Wire Wire Line
	3600 3550 4300 3550
$Comp
L 4012 U7
U 1 1 54E60D09
P 4900 2900
F 0 "U7" H 4900 3000 60  0000 C CNN
F 1 "4012" H 4900 2800 60  0000 C CNN
F 2 "" H 4900 2900 60  0000 C CNN
F 3 "" H 4900 2900 60  0000 C CNN
	1    4900 2900
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR036
U 1 1 54E60D0F
P 4700 2650
F 0 "#PWR036" H 4700 2740 20  0001 C CNN
F 1 "+5V" H 4700 2740 30  0000 C CNN
F 2 "" H 4700 2650 60  0000 C CNN
F 3 "" H 4700 2650 60  0000 C CNN
	1    4700 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 2650 4700 2700
$Comp
L GND #PWR037
U 1 1 54E60D16
P 4700 3150
F 0 "#PWR037" H 4700 3150 30  0001 C CNN
F 1 "GND" H 4700 3080 30  0001 C CNN
F 2 "" H 4700 3150 60  0000 C CNN
F 3 "" H 4700 3150 60  0000 C CNN
	1    4700 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 3100 4700 3150
Text GLabel 3600 2800 0    60   Input ~ 0
A9
Text GLabel 3600 2600 0    60   Input ~ 0
A8
Wire Wire Line
	3600 3000 4100 3000
Wire Wire Line
	4100 3000 4100 2950
Wire Wire Line
	4100 2950 4300 2950
Wire Wire Line
	3600 2800 4100 2800
Wire Wire Line
	4100 2800 4100 2850
Wire Wire Line
	4100 2850 4300 2850
Wire Wire Line
	3600 3200 4000 3200
Wire Wire Line
	4000 3200 4000 3050
Wire Wire Line
	4000 3050 4300 3050
Wire Wire Line
	3600 2600 4000 2600
Wire Wire Line
	4000 2600 4000 2750
Wire Wire Line
	4000 2750 4300 2750
$Comp
L 74LS138 U9
U 1 1 54E60F5B
P 6500 2250
F 0 "U9" H 6600 2750 60  0000 C CNN
F 1 "74HC138" H 6500 1600 60  0000 C CNN
F 2 "" H 6500 2250 60  0000 C CNN
F 3 "" H 6500 2250 60  0000 C CNN
	1    6500 2250
	1    0    0    -1  
$EndComp
Text GLabel 3600 2400 0    60   Input ~ 0
A7
Text GLabel 3600 2200 0    60   Input ~ 0
A6
Text GLabel 3600 2000 0    60   Input ~ 0
A5
Text GLabel 3600 1800 0    60   Input ~ 0
A4
Wire Wire Line
	3600 2400 5900 2400
Wire Wire Line
	5500 2900 5600 2900
Wire Wire Line
	5600 2900 5600 2500
Wire Wire Line
	5600 2500 5900 2500
Wire Wire Line
	5500 3700 5700 3700
Wire Wire Line
	5700 3700 5700 2600
Wire Wire Line
	5700 2600 5900 2600
Wire Wire Line
	5900 2000 3600 2000
Wire Wire Line
	3600 2200 5600 2200
Wire Wire Line
	5600 2200 5600 2100
Wire Wire Line
	5600 2100 5900 2100
Wire Wire Line
	3600 1800 5600 1800
Wire Wire Line
	5600 1800 5600 1900
Wire Wire Line
	5600 1900 5900 1900
$Comp
L GND #PWR038
U 1 1 54E61284
P 6500 2750
F 0 "#PWR038" H 6500 2750 30  0001 C CNN
F 1 "GND" H 6500 2680 30  0001 C CNN
F 2 "" H 6500 2750 60  0000 C CNN
F 3 "" H 6500 2750 60  0000 C CNN
	1    6500 2750
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR039
U 1 1 54E6128B
P 6500 1750
F 0 "#PWR039" H 6500 1840 20  0001 C CNN
F 1 "+5V" H 6500 1840 30  0000 C CNN
F 2 "" H 6500 1750 60  0000 C CNN
F 3 "" H 6500 1750 60  0000 C CNN
	1    6500 1750
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6500 1750 6500 1800
Wire Wire Line
	6500 2750 6500 2700
Wire Wire Line
	4200 4450 4200 4550
Wire Wire Line
	4200 4550 4300 4550
Wire Wire Line
	5600 4150 4200 4150
Text HLabel 7300 1900 2    60   Output ~ 0
~IO0
Text HLabel 7300 2000 2    60   Output ~ 0
~IO1
Text HLabel 7300 2100 2    60   Output ~ 0
~IO2
Text HLabel 7300 2200 2    60   Output ~ 0
~IO3
Text HLabel 7300 2300 2    60   Output ~ 0
~IO4
Text HLabel 7300 2400 2    60   Output ~ 0
~IO5
Text HLabel 7300 2500 2    60   Output ~ 0
~IO6
Text HLabel 7300 2600 2    60   Output ~ 0
~IO7
Wire Wire Line
	7100 1900 7300 1900
Wire Wire Line
	7300 2000 7100 2000
Wire Wire Line
	7100 2100 7300 2100
Wire Wire Line
	7300 2200 7100 2200
Wire Wire Line
	7100 2300 7300 2300
Wire Wire Line
	7300 2400 7100 2400
Wire Wire Line
	7100 2500 7300 2500
Wire Wire Line
	7300 2600 7100 2600
Text HLabel 7300 4700 2    60   Output ~ 0
~ROMSEL
Text HLabel 7300 5200 2    60   Output ~ 0
~RAMSEL
Text Notes 6200 3900 0    60   ~ 0
MEMORY MAP\n\nRAM: $0000-$7FFF (32K)\nROM: $E000-$FFFF (8K)\nIO0..IO7: 8x16 byte regions starting at $DF80
$Comp
L +5V #PWR040
U 1 1 550E66B4
P 6000 3900
F 0 "#PWR040" H 6000 3990 20  0001 C CNN
F 1 "+5V" H 6000 3990 30  0000 C CNN
F 2 "" H 6000 3900 60  0000 C CNN
F 3 "" H 6000 3900 60  0000 C CNN
	1    6000 3900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR041
U 1 1 550E66BA
P 6000 4400
F 0 "#PWR041" H 6000 4400 30  0001 C CNN
F 1 "GND" H 6000 4330 30  0001 C CNN
F 2 "" H 6000 4400 60  0000 C CNN
F 3 "" H 6000 4400 60  0000 C CNN
	1    6000 4400
	1    0    0    -1  
$EndComp
$Comp
L C C10
U 1 1 550E66C0
P 6000 4150
F 0 "C10" H 6000 4250 40  0000 L CNN
F 1 "10nF" H 6006 4065 40  0000 L CNN
F 2 "~" H 6038 4000 30  0000 C CNN
F 3 "~" H 6000 4150 60  0000 C CNN
	1    6000 4150
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR042
U 1 1 550E66C7
P 7950 1800
F 0 "#PWR042" H 7950 1890 20  0001 C CNN
F 1 "+5V" H 7950 1890 30  0000 C CNN
F 2 "" H 7950 1800 60  0000 C CNN
F 3 "" H 7950 1800 60  0000 C CNN
	1    7950 1800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR043
U 1 1 550E66CD
P 7950 2300
F 0 "#PWR043" H 7950 2300 30  0001 C CNN
F 1 "GND" H 7950 2230 30  0001 C CNN
F 2 "" H 7950 2300 60  0000 C CNN
F 3 "" H 7950 2300 60  0000 C CNN
	1    7950 2300
	1    0    0    -1  
$EndComp
$Comp
L C C11
U 1 1 550E66D3
P 7950 2050
F 0 "C11" H 7950 2150 40  0000 L CNN
F 1 "10nF" H 7956 1965 40  0000 L CNN
F 2 "~" H 7988 1900 30  0000 C CNN
F 3 "~" H 7950 2050 60  0000 C CNN
	1    7950 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 3900 6000 3950
Wire Wire Line
	6000 4350 6000 4400
Wire Wire Line
	7950 1800 7950 1850
Wire Wire Line
	7950 2250 7950 2300
$EndSCHEMATC
