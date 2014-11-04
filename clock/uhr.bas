SCREEN 18
FUNCTION min
    min=VAL(MID$(TIME,4,2))
END FUNCTION

FUNCTION sek
    sek=VAL(MID$(TIME,7,2))
END FUNCTION

FUNCTION std
    std=VAL(MID$(TIME,1,2))
END FUNCTION
DIM laenge_sek AS INTEGER
DIM laenge_min AS INTEGER
DIM laenge_std AS INTEGER
DIM faktor AS SINGLE
laenge_sek=150
laenge_min=130
laenge_std=110

faktor=(ATN(1) * 4)/180
DO
CLS
LOCATE 1,1    
? TIME
COLOR 12,0 :? sek,"Sekunden"
COLOR 13,0 :? min,"Minuten"
COLOR 14,0 :? std,"Stunden"
CIRCLE (320,240), 100 ,10
CIRCLE (320,240),140,7
COLOR 15,0
'Zahlen ausgeben
FOR i%=1 TO 12
  x%=INT((320+sin(i%*30*faktor)*(laenge_std+50))/8)
  y%=INT((240-cos(i%*30*faktor)*(laenge_std+50))/16)+1 
  locate y%,x%
  PRINT i%
NEXT i%

'Stundenzeiger
LINE (320,240)-(320+INT(sin(std*30*faktor)*laenge_std),240-INT(cos(std*30*faktor)*laenge_std)),14
LINE (320,240)-(320+INT(sin((std*30+90)*faktor)*15),240-INT(cos((std*30+90)*faktor)*15)),14
LINE (320,240)-(320+INT(sin((std*30-90)*faktor)*15),240-INT(cos((std*30-90)*faktor)*15)),14
LINE (320+INT(sin((std*30+90)*faktor)*15),240-INT(cos((std*30+90)*faktor)*15))-(320+INT(sin(std*30*faktor)*laenge_std),240-INT(cos(std*30*faktor)*laenge_std)),14
LINE (320+INT(sin((std*30-90)*faktor)*15),240-INT(cos((std*30-90)*faktor)*15))-(320+INT(sin(std*30*faktor)*laenge_std),240-INT(cos(std*30*faktor)*laenge_std)),14
'Minutenzeiger
LINE (320,240)-(320+INT(sin(min*6*faktor)*laenge_min),240-INT(cos(min*6*faktor)*laenge_min)),13
LINE (320,240)-(320+INT(sin((min*6+90)*faktor)*10),240-INT(cos((min*6+90)*faktor)*10)),13
LINE (320,240)-(320+INT(sin((min*6-90)*faktor)*10),240-INT(cos((min*6-90)*faktor)*10)),13
LINE (320+INT(sin((min*6+90)*faktor)*10),240-INT(cos((min*6+90)*faktor)*10))-(320+INT(sin(min*6*faktor)*laenge_min),240-INT(cos(min*6*faktor)*laenge_min)),13
LINE (320+INT(sin((min*6-90)*faktor)*10),240-INT(cos((min*6-90)*faktor)*10))-(320+INT(sin(min*6*faktor)*laenge_min),240-INT(cos(min*6*faktor)*laenge_min)),13
'Sekundenzeiger
LINE (320,240)-(320+INT(sin(sek*6*faktor)*laenge_sek),240-INT(cos(sek*6*faktor)*laenge_sek)),12
LINE (320,240)-(320+INT(sin((sek*6+90)*faktor)*5),240-INT(cos((sek*6+90)*faktor)*5)),12
LINE (320,240)-(320+INT(sin((sek*6-90)*faktor)*5),240-INT(cos((sek*6-90)*faktor)*5)),12
LINE (320+INT(sin((sek*6+90)*faktor)*5),240-INT(cos((sek*6+90)*faktor)*5))-(320+INT(sin(sek*6*faktor)*laenge_sek),240-INT(cos(sek*6*faktor)*laenge_sek)),12
LINE (320+INT(sin((sek*6-90)*faktor)*5),240-INT(cos((sek*6-90)*faktor)*5))-(320+INT(sin(sek*6*faktor)*laenge_sek),240-INT(cos(sek*6*faktor)*laenge_sek)),12

SLEEP 100

LOOP WHILE INKEY$=""
