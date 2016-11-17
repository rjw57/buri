; Register locations for 6522 VIA

.export VIA_BASE := $DEF0
.export VIA_ORB := VIA_BASE + $0
.export VIA_ORA := VIA_BASE + $1
.export VIA_DDRB := VIA_BASE + $2
.export VIA_DDRA := VIA_BASE + $3
.export VIA_T1CL := VIA_BASE + $4
.export VIA_T1CH := VIA_BASE + $5
.export VIA_T1LL := VIA_BASE + $6
.export VIA_T1LH := VIA_BASE + $7
.export VIA_T2CL := VIA_BASE + $8
.export VIA_T2CH := VIA_BASE + $9
.export VIA_SR := VIA_BASE + $A
.export VIA_ACR := VIA_BASE + $B
.export VIA_PCR := VIA_BASE + $C
.export VIA_IFR := VIA_BASE + $D
.export VIA_IER := VIA_BASE + $E

