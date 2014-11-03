/*
 * TGrafenParameter.java
 *
 * Diese Programm wurde von Steve
 * am 18. März 2007, um 11:52
 * erstellt
 */

package matheprojekt;

/**
 *
 * @author Steve
 * @version 0.01
 */
public class TGrafenParameter {
   String fktterm;
   float xp,xs1;
   int anzahl;
   public TGrafenParameter(){
      
   }
   public void setfktterm(String term){
      this.fktterm=term;
   }
   public void setxp(String xptext){
      xp=Float.valueOf(xptext);
   }

   public void setxs1(String xs1text) {
      xs1=Float.valueOf(xs1text);
   }
   public void setanzahl(String anzahltext){
     anzahl= Integer.valueOf(anzahltext);
   }
   public void setParameter(String term,String xp,String xs1,String anzahl){
      this.setfktterm(term);
      this.setxp(xp);
      this.setxs1(xs1);
      this.setanzahl(anzahl);
   }
   public String getfktterm(){
      return this.fktterm;
   }
   public float getxp(){
      return this.xp;
   }
   public float getxs1(){
      return this.xs1;
   }
   public int getanzahl(){
      return this.anzahl;
   } 

}  
