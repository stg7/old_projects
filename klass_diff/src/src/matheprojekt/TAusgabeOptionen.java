/*
 * TGrafenAusgabe.java
 *
 * Diese Programm wurde von Steve
 * am 18. März 2007, um 13:45
 * erstellt
 */

package matheprojekt;

import java.awt.Color;

/**
 *
 * @author Steve
 * @version 0.01
 */
public class TAusgabeOptionen {
   protected int xfaktor,yfaktor,abstand;
   protected Color GrafenFarbe,GeradenFarbe;
   
   /** Konstruktor der Klasse TGrafenAusgabe */
   public TAusgabeOptionen(){
     this.xfaktor=100;
     this.yfaktor=100;
     this.abstand=15;
     this.GrafenFarbe=new Color(0,0,255);
     this.GeradenFarbe=new Color(0,255,0);
     
   }
   public TAusgabeOptionen(int xfaktor,int yfaktor,int abstand,Color GrafenFarbe) {
     this.xfaktor=xfaktor;
     this.yfaktor=yfaktor;
     this.abstand=abstand;
     this.GrafenFarbe=GrafenFarbe;
   }
   public int getxfaktor(){
      return this.xfaktor;
   }
   public int getyfaktor(){
      return this.yfaktor;
   }
   public int getabstand(){
      return this.abstand;
   }   
   public Color getGrafenFarbe(){
      return this.GrafenFarbe;
   }
   public Color getGeradenFarbe(){
      return this.GeradenFarbe;
   }
   
   
   public void setxfaktor(int xfakt){
      this.xfaktor=xfakt;
   }
   public void setyfaktor(int yfakt){
      this.yfaktor=yfakt;
   }
   public void setabstand(int abstand){
      this.abstand=abstand;
   }   
   public void setGrafenFarbe(Color Farbe){
      this.GrafenFarbe=Farbe;
   }
   
   public void setGeradenFarbe(Color Farbe){
      this.GeradenFarbe=Farbe;
   }
   
}
