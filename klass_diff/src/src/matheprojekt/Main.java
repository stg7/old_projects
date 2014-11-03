/*
 * Main.java
 *
 * erstellt am 10. März 2007, 17:30
 *
 */

package matheprojekt;

/**
 *
 * @author Steve
 * @version 0.01
 *
 * Dieses Programm veranschaulicht die Klassische Methode des
 * Differenzierens 
 *
 * Dieses Programm ist eine Projektarbeit im Fach AnTe (12.Klasse)
 * des Beruflichen Gymnasiums Mühlhausen , 
 * von Steve Göring   
 */


public class Main {   
   /** Creates a new instance of Main */
   public Main() {
   }
    /**
    * @param args the command line arguments
    */
   
   //CFG Datei ,InfoDatei ... als "Konstanten"
   public static void main(String[] args) {
      // Der Quelltext des eigendlichen Hauptprogrammes
      // der Parameter von myFrame gibt den Pfad zur Konfigurationsdatei an 
      new myFrame("cfg/cfg.ini").setVisible(true); // es wird ein neues Object erstellt myFrame siehe myFrame.java
   }
   
}


