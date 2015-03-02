65xx_Library - KiCad part
=========================

## 1.0 About

![Component Example] (https://raw.githubusercontent.com/mkeller0815/65xx_Library/master/img/kicad_component.png)

This is a KiCad (http://www.kicad-pcb.org) Library for 65xx parts.

## 2.0 Supported parts

 - R6532 	RIOT
 - 6510 / 8500	8bit CPU
 - W65C02	8bit CPU
 - W65C21	PIA
 - W65C22	CIA
 - W65C51N	ACIA
 - W65C816S	16bit CPU
 - MC6850	ACIA (Motorola)

## 3.0 Alternate Layout 

There are different Layouts for some components. Mostly for parts with a bigger data- or address bus.
The default layout has the same arangement of pins as the chip. The altenate layout (identified by a 
'_' at the end of the name is arranged for more convenient bus connectivity.

## 4.0 Modules

Currently there are no additional modules needed, because all parts are default 600mil PDIP parts.
You can easy assign the right footprint by using the Sockets_DIP module library in the cvpcb tool. 

If this library is not part of your installation, you can check out the bewest libraries for KiCad
at: (https://github.com/KiCad/kicad-library)
