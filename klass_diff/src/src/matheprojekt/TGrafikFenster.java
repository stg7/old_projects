/*
 * TGrafikFenster.java
 *
 * Created on 11. März 2007, 18:33
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package matheprojekt;

/**
 *
 * @author Steve
 */
import javax.swing.*;

public class TGrafikFenster extends JFrame {
   protected TGrafikPanel GrafikPanel=new TGrafikPanel();
   public void ini(){
      setSize(600,500);
      setLocation(300,10);
      add(GrafikPanel);
   }
   public TGrafikFenster(){
      this.ini(); 
   }  
   public TGrafikFenster(String s){
      this.setTitle(s);
      this.ini();
   }
   public void setOptionen(TAusgabeOptionen GrafenAusgabe,TGrafenParameter GrafenParameter){
      String Titel=this.getTitle();
      if (Titel.indexOf(" ")>0)
         Titel=Titel.substring(0,Titel.indexOf(" "));
      GrafikPanel.setOptionen(GrafenAusgabe,GrafenParameter);
      this.setTitle(Titel+"     f(x)="+GrafenParameter.fktterm+" xp="+GrafenParameter.xp+" xs1="+GrafenParameter.xs1+" n="+GrafenParameter.anzahl);
   }   
}