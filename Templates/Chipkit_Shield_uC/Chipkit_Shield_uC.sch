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
LIBS:DataStorage
LIBS:Microprocessors
LIBS:MiscellaneousDevices
LIBS:RF_OEM_Parts
LIBS:Sensors
LIBS:TransistorParts
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "21 aug 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_6 P1
U 1 1 5214C54F
P 1450 1600
F 0 "P1" V 1400 1600 60  0000 C CNN
F 1 "Power" V 1500 1600 60  0000 C CNN
F 2 "~" H 1450 1600 60  0000 C CNN
F 3 "~" H 1450 1600 60  0000 C CNN
	1    1450 1600
	-1   0    0    1   
$EndComp
Text Label 1950 1350 0    60   ~ 0
RESET
Text Label 1950 1450 0    60   ~ 0
3V3
Text Label 1950 1550 0    60   ~ 0
5V0
Text Label 1950 1650 0    60   ~ 0
GND
Text Label 1950 1750 0    60   ~ 0
GND
Text Label 1950 1850 0    60   ~ 0
VIN
Wire Wire Line
	1800 1350 1950 1350
Wire Wire Line
	1950 1450 1800 1450
Wire Wire Line
	1800 1550 1950 1550
Wire Wire Line
	1950 1650 1800 1650
Wire Wire Line
	1800 1750 1950 1750
Wire Wire Line
	1950 1850 1800 1850
$Comp
L CONN_6X2 P2
U 1 1 5214C59A
P 1450 2800
F 0 "P2" H 1450 3150 60  0000 C CNN
F 1 "Analog" V 1450 2800 60  0000 C CNN
F 2 "~" H 1450 2800 60  0000 C CNN
F 3 "~" H 1450 2800 60  0000 C CNN
	1    1450 2800
	1    0    0    -1  
$EndComp
Text Label 900  2550 2    60   ~ 0
A0
Text Label 900  2650 2    60   ~ 0
A1
Text Label 900  2750 2    60   ~ 0
A2
Text Label 900  2850 2    60   ~ 0
A3
Text Label 900  2950 2    60   ~ 0
A4/RG3
Text Label 900  3050 2    60   ~ 0
A5/RG2
Text Label 2000 2550 0    60   ~ 0
A6
Text Label 2000 2650 0    60   ~ 0
A7
Text Label 2000 2750 0    60   ~ 0
A8
Text Label 2000 2850 0    60   ~ 0
A9
Text Label 2000 2950 0    60   ~ 0
A10
Text Label 2000 3050 0    60   ~ 0
A11
Wire Wire Line
	1050 2550 900  2550
Wire Wire Line
	900  2650 1050 2650
Wire Wire Line
	1050 2750 900  2750
Wire Wire Line
	900  2850 1050 2850
Wire Wire Line
	1050 2950 900  2950
Wire Wire Line
	900  3050 1050 3050
Wire Wire Line
	1850 2550 2000 2550
Wire Wire Line
	2000 2650 1850 2650
Wire Wire Line
	1850 2750 2000 2750
Wire Wire Line
	2000 2850 1850 2850
Wire Wire Line
	1850 2950 2000 2950
Wire Wire Line
	2000 3050 1850 3050
$Comp
L CONN_8X2 P3
U 1 1 5214C701
P 3650 1550
F 0 "P3" H 3650 2000 60  0000 C CNN
F 1 "PWM/Digital" V 3650 1550 50  0000 C CNN
F 2 "~" H 3650 1550 60  0000 C CNN
F 3 "~" H 3650 1550 60  0000 C CNN
	1    3650 1550
	1    0    0    -1  
$EndComp
$Comp
L CONN_8X2 P4
U 1 1 5214C710
P 3650 2900
F 0 "P4" H 3650 3350 60  0000 C CNN
F 1 "PWM/Digital" V 3650 2900 50  0000 C CNN
F 2 "~" H 3650 2900 60  0000 C CNN
F 3 "~" H 3650 2900 60  0000 C CNN
	1    3650 2900
	1    0    0    -1  
$EndComp
Text Label 4200 1200 0    60   ~ 0
VREF+/AN0
Text Label 4200 1300 0    60   ~ 0
GND
Text Label 4200 1400 0    60   ~ 0
RG6
Text Label 4200 1500 0    60   ~ 0
MISO
Text Label 4200 1600 0    60   ~ 0
MOSI
Text Label 4200 1700 0    60   ~ 0
RD4/RG9
Text Label 4200 1800 0    60   ~ 0
RD3
Text Label 4200 1900 0    60   ~ 0
RD10
Text Label 3100 1200 2    60   ~ 0
VREF-/AN1
Text Label 3100 1300 2    60   ~ 0
RF5
Text Label 3100 1400 2    60   ~ 0
RF4
Text Label 3100 1500 2    60   ~ 0
RF6
Text Label 3100 1600 2    60   ~ 0
RD7
Text Label 3100 1700 2    60   ~ 0
RD6
Text Label 3100 1800 2    60   ~ 0
RD11
Text Label 3100 1900 2    60   ~ 0
RD5
Wire Wire Line
	3250 1200 3100 1200
Wire Wire Line
	3100 1300 3250 1300
Wire Wire Line
	3250 1400 3100 1400
Wire Wire Line
	3100 1500 3250 1500
Wire Wire Line
	3250 1600 3100 1600
Wire Wire Line
	3100 1700 3250 1700
Wire Wire Line
	3250 1800 3100 1800
Wire Wire Line
	3100 1900 3250 1900
Wire Wire Line
	4050 1900 4200 1900
Wire Wire Line
	4200 1800 4050 1800
Wire Wire Line
	4050 1700 4200 1700
Wire Wire Line
	4200 1600 4050 1600
Wire Wire Line
	4050 1500 4200 1500
Wire Wire Line
	4200 1400 4050 1400
Wire Wire Line
	4050 1300 4200 1300
Wire Wire Line
	4200 1200 4050 1200
Text Label 3100 2550 2    60   ~ 0
RE7
Text Label 3100 2650 2    60   ~ 0
RE6
Text Label 3100 2750 2    60   ~ 0
RE5
Text Label 3100 2850 2    60   ~ 0
RE4
Text Label 3100 2950 2    60   ~ 0
RE3
Text Label 3100 3050 2    60   ~ 0
RE2
Text Label 3100 3150 2    60   ~ 0
RE1
Text Label 3100 3250 2    60   ~ 0
RE0
Text Label 4200 2550 0    60   ~ 0
RD9
Text Label 4200 2650 0    60   ~ 0
RD2
Text Label 4200 2750 0    60   ~ 0
RD1
Text Label 4200 2850 0    60   ~ 0
RF1
Text Label 4200 2950 0    60   ~ 0
RD0
Text Label 4200 3050 0    60   ~ 0
RD8
Text Label 4200 3150 0    60   ~ 0
RF3
Text Label 4200 3250 0    60   ~ 0
RF2
Wire Wire Line
	3100 2550 3250 2550
Wire Wire Line
	3250 2650 3100 2650
Wire Wire Line
	3100 2750 3250 2750
Wire Wire Line
	3250 2850 3100 2850
Wire Wire Line
	3100 2950 3250 2950
Wire Wire Line
	3250 3050 3100 3050
Wire Wire Line
	3100 3150 3250 3150
Wire Wire Line
	3250 3250 3100 3250
Wire Wire Line
	4050 3250 4200 3250
Wire Wire Line
	4200 3150 4050 3150
Wire Wire Line
	4050 3050 4200 3050
Wire Wire Line
	4200 2950 4050 2950
Wire Wire Line
	4050 2850 4200 2850
Wire Wire Line
	4200 2750 4050 2750
Wire Wire Line
	4050 2650 4200 2650
Wire Wire Line
	4200 2550 4050 2550
Text Notes 1650 800  0    118  ~ 0
ChipKIT Headers
Text Notes 4850 1200 0    69   ~ 0
A\nG\n13\n12\n11\n10\n9\n8\n
Text Notes 2400 1200 0    69   ~ 0
41\n40\n39\n38\n37\n36\n35\n34
Text Notes 2700 2550 0    69   ~ 0
33\n32\n31\n30\n29\n28\n27\n26
Text Notes 4500 2550 0    69   ~ 0
7\n6\n5\n4\n3\n2\n1\n0
$Comp
L CONN_3X2 P5
U 1 1 5214E23D
P 2500 3900
F 0 "P5" H 2500 4150 50  0000 C CNN
F 1 "SPI" V 2500 3950 40  0000 C CNN
F 2 "~" H 2500 3900 60  0000 C CNN
F 3 "~" H 2500 3900 60  0000 C CNN
	1    2500 3900
	1    0    0    -1  
$EndComp
Text Label 1950 3750 2    69   ~ 0
RG7/RG8
Text Label 1950 3850 2    69   ~ 0
RG6
Text Label 1950 3950 2    69   ~ 0
RG9
Text Label 3050 3850 0    69   ~ 0
RG8/RG7
Text Label 3050 3950 0    69   ~ 0
GND
Wire Wire Line
	2100 3750 1950 3750
Wire Wire Line
	1950 3850 2100 3850
Wire Wire Line
	2100 3950 1950 3950
Wire Wire Line
	3050 3850 2900 3850
Wire Wire Line
	2900 3950 3050 3950
$EndSCHEMATC
