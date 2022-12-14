;General Setup - RailCore RRF on a SBC for Duet3
M929 S2 ; Enable Logging
G21     ; Work in millimetres
G90     ; Send absolute coordinates...
M83     ; ...but relative extruder moves

; Stepper configuration
M569 P0 S0 D3 ; Drive 0 X / Rear
M569 P1 S1 D3 ; Drive 1 Y / Front
M569 P2 S1 ; Drive 2 Z Front Left
M569 P3 S1 ; Drive 3 Z Rear Left
M569 P4 S1 ; Drive 4 Z Right
M569 P5 S1 ; Drive 5 Extruder
 
;Axis configuration
M669 K1              ; corexy mode
M584 X0 Y1 Z2:3:4 E5 ; Map X to drive 0 Y to drive 1, Z to drives 2, 3, 4, and E to drive 5

;Leadscrew locations
M671 X-8:-8:342  Y19:276:148 S7.5

M350 X16 Y16 Z16 E16 I1          ; set 16x microstepping for axes with interpolation
M906 X2250 Y2250 Z1200 E800 I80  ; Set motor currents (mA)

M201 X3000 Y3000 Z100 E1500      ; Accelerations (mm/s^2)
M203 X36000 Y36000 Z900 E3600    ; Maximum speeds (mm/min)
M566 X1000 Y1000 Z100 E1500      ; Maximum jerk speeds mm/minute

M208 X295 Y305 Z338              ; set axis maxima and high homing switch positions (adjust to suit your machine)
M208 X-12 Y0 Z0 S1               ; set axis minima and low homing switch positions (adjust to make X=0 and Y=0 the edges of the bed)
M92 X100 Y100 Z1600 E837         ; steps/mm

 
; End Stops
M574 X1 S1 P"io1.in" ; Map the X endstop to io1.in
M574 Y1 S1 P"io2.in" ; May the Y endstop to io2.in
 
; Thermistors
M308 S0 P"temp0" Y"thermistor" A"bed_heat" T100000 B3950 H0 L0              ; Bed thermistor - connected to temp0
M308 S1 P"temp1" Y"thermistor" A"e0_heat" T100000 B4725 C7.06e-8 H0 L0      ; duet3 e3d thermistor - connected to e0_heat
M308 S2 P"temp2" Y"thermistor" A"keenovo" T100000 B3950 H0 L0               ; Keenovo thermistor - connected to temp2

;Define Heaters
M950 H0 C"out0" T0 ; Bed heater is on out0
M950 H1 C"out1" T1 ; Hotend heater is on out1

;Define Bed
M140 H0

; Dead time use to be 28.86
M307 H0 R0.263 K0.114:0.000 D60 E1.35 S1.00 B0          ; Bed, with enclosure tuned at 100c (B3950 thermistor)
; M307 H0 R0.246 K0.112:0.000 D30.62 E1.35 S1.00 B0        ; Bed, with enclosure tuned at 100c
; M307 H0 B0 R0.238 C1055.6 D38.24 S1.00 V24.0             ; Bed, with enclosure tuned at 60c
; M307 H0 R0.225 K0.135:0.000 D45.28 E1.35 S1.00 B0        ; Bed, no enclosure tuned at 60c
; Dead time used to be 6.51 
M307 H1 R2.489 K0.564:0.000 D12 E1.35 S1.00 B0 V24.0     ; Hotend with 5015 fan, with enclosure
; M307 H1 R2.370 K0.536:0.000 D7.36 E1.35 S1.00 B0 V24.0   ; Hotend with 5015 fan, no enclosure 
M570 S360                                                ; Hotend may be a little slow to heat up so allow it 180 seconds
M143 S295                                                ; Set max hotend temperature

; Mesh bed level grid
; M557 X15:280 Y50:275 P8:8
M557 X15:280 Y50:275 P4:4

; Fans
M950 F0 C"out4"     ; Layer fan on "out4" connector
M106 P0 S0          ; Layer Fan
M950 F1 C"out5"     ; Hotend fan on "out5" connector
M106 P1 S255 H1 T50 ; enable thermostatic mode for hotend fan

; Filter fans
M950 F2 C"out9"
M106 P2 S0
M950 F3 C"out8"
M106 P3 S0


; Tool definitions
M563 P0 D0 H1 F0 ; Define tool 0
G10 P0 S0 R0     ; Set tool 0 operating and standby temperatures

; Euclid Probe
; larger probe offset = nozzle closer to the bed
; ref: https://euclidprobe.github.io/05_rrf3.html
M574 Z1 S2
M558 K0 P5 C"^io8.in" H8 F120 T6000 A3 S0.01
G31 K0 P500 X3.5 Y36 Z6.35


; Calibrate MCU Temperature
M912 P0 S-8.7

; Stealthchop
; M98 P"stealthchop/config.g"

T0 ; select first hot end