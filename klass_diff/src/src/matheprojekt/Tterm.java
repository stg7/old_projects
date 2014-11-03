/*
 * Tterm.java
 *
 * Diese Programm wurde von Steve Göring
 * am 9. März 2007, um 19:14
 * erstellt
 */

package matheprojekt;

/**
 *
 * @author Steve
 * @version 0.01
 * Kontakt : stg7@gmx.de
 * 
 * Diese Klasse kann einfache Terme berechnen
 */
public strictfp class Tterm {

// strictfp bedeutet dass Fließkommaberechnungen
// dieser Klasse mit hoher Rechengenauigkeit bearbeitet werden
   protected String term;
   protected double Ergebnis;
   
   public Tterm() {
      this.SetTerm("");
   }
   public Tterm(String s ) {
       this.SetTerm(s);
   }
   public void SetTerm(String s){
      term=s;
   }
   public String GetTerm(){
      return term;
   }

   private char getOperator(String term){
    // char operatoren[]={'+','-','*','/','^'};
      
     char operatoren[]={'+','-','*','/','^'};
     for(int i=0;i<operatoren.length;i++) 
      if (term.indexOf(operatoren[i])>0)
       return operatoren[i];
     return ' ';    
   }
   private String berechnen(String term){
     char op=getOperator(term);
     int position =0;
     double ergebnis=0;
     
     String links_vom_op,rechts_vom_op;
     
     position=term.indexOf(op);
     
     links_vom_op=term.substring(0,position);
     rechts_vom_op=term.substring(position+1,term.length());
     //System.out.println("LINKS="+links_vom_op);
     //System.out.println("RechtsS="+rechts_vom_op);
     links_vom_op=Double.toString(this.term_berechnen(links_vom_op));
     rechts_vom_op=Double.toString(this.term_berechnen(rechts_vom_op));
  
     switch (op){
        case '+': 
           ergebnis=Double.valueOf(links_vom_op)+Double.valueOf(rechts_vom_op);
           break;
        case '-':
           ergebnis=Double.valueOf(links_vom_op)-Double.valueOf(rechts_vom_op);
           break;
        case '*':
           ergebnis=Double.valueOf(links_vom_op)*Double.valueOf(rechts_vom_op);
           break;
        case '/':
           ergebnis=Double.valueOf(links_vom_op)/Double.valueOf(rechts_vom_op);
           break;
        case '^':
           ergebnis= Math.pow(Double.valueOf(links_vom_op),Double.valueOf(rechts_vom_op));
           break;
     }
     //System.out.println("Ergebnis: "+ergebnis);
     return Double.toString(ergebnis);  
      
   } 
   private boolean operator_vorhanden(String term){
     char operatoren[]={'+','-','*','/','^'};
     boolean test=false; 
     for(int i=0;i<operatoren.length;i++)
        test=test || (term.indexOf(operatoren[i])>0);
     //System.out.println(test);
     return test;
   }
   private double term_berechnen(String term) {
      //System.out.println("Term:"+term);
      if (operator_vorhanden(term))
         return Double.valueOf(this.berechnen(term));
      else return Double.valueOf(term);
   }
   public double GetErgebnis(){
      String temp_term="";
      String term=this.GetTerm();
     /*Diese Schleife brigt Terme in denen der Minusoperator vorkommt 
      *z.B: 3-1-1-1
      *in die Form 3+-1+-1+-1 somit wird nun mit negativen Zahlen addiert
      *sonst gab es genau an dieser Stelle Probleme
      *denn 3-1-1-1 ist bekanntlich 0 und nicht 2
      */
      for(int i=0;i<term.length();i++)
         if (term.charAt(i)=='-')
            temp_term=temp_term+"+"+term.charAt(i);
         else temp_term=temp_term+term.charAt(i);
      //System.out.println("Temporärer Term "+temp_term);
       Ergebnis=term_berechnen(temp_term);
      return Ergebnis;
   } 
   
}