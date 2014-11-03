/*
 * Tcfg.java
 *
 * erstellt am  11. März 2007, 17:34
 *
 */

package matheprojekt;

/**
 *
 * @author Steve
 * @version 0.01
 */
 import java.io.*;
 import java.util.*;
 
public class Tcfg {
   
   protected Hashtable tabelle=new Hashtable();
   protected static String dateiname;
   public void CFG_ermitteln(Hashtable cfg){
       
     try{  
       java.net.URL url = getClass().getResource(dateiname);;  
       BufferedReader datei2 = new BufferedReader(
                                 new InputStreamReader(url.openStream())   
                                 );
       String t;
       int mitte=0;
       do
       { 
        t= datei2.readLine();
         if ((t!=null) && (t.indexOf('=')>0))
         {
          mitte=t.indexOf('=');
          cfg.put(t.substring(0,mitte),t.substring(mitte+2,t.indexOf(";")-1 ));
         } 
       } 
       while (t!=null);
       datei2.close();
      }
     catch( IOException e ) 
      {
       System.out.println( "Achtung Fehler: "+e );
      }
   }  
    /** Creates a new instance of cfg */
    public Tcfg(String s) {
       dateiname=s; 
       CFG_ermitteln(tabelle);
    }

    public Hashtable getTabelle() {
       return tabelle;
    }
    public String getCfg(String s){
       return (String) tabelle.get(s);
    }
    
}
