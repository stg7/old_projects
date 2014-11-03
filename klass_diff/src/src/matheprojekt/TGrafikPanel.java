/*
 * TGrafikPanel.java
 *
 * Created on 11. März 2007, 18:31
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package matheprojekt;

/**
 *
 * @author Steve
 */

import java.awt.*;
import java.awt.event.*;
import java.awt.font.GraphicAttribute;
import java.io.*;
import java.math.BigDecimal;
import javax.swing.*;

public strictfp class TGrafikPanel extends JPanel{
   protected TGrafenParameter GrafenParameter;
   protected TAusgabeOptionen GrafenAusgabe;
   int xfaktor,yfaktor,abstand;
        
   Dimension d;
   
   public TGrafikPanel(){
      
   }
   
   public void paint(Graphics g){
      d=getSize();
      xfaktor=GrafenAusgabe.getxfaktor();
      yfaktor=GrafenAusgabe.getyfaktor();
      abstand=GrafenAusgabe.getabstand();
      Color GrafenFarbe=GrafenAusgabe.getGrafenFarbe(),
            GeradenFarbe=GrafenAusgabe.getGeradenFarbe();
      
      g.setColor(new Color(255,255,255));
      g.fillRect(0,0,d.width,d.height);
      
      g.setColor(new Color(0,0,0));
      
      ZeichneKoorSystem(g);
      
      g.setColor(GrafenFarbe);
      
      
      float f[];
      //Funktionswerte berechnen
      f=BerechneFktWerte(GrafenParameter.getfktterm()); 
   
      // Grafen Plotten!
      PlotteGraf(f,g);
      //Graf ist nun gezeichnet
      
      // xp einzeichnen und xs1
      float m;
      g.setColor(new Color(255,0,0));
      
      if ( PunktEinzeichnen("xp",GrafenParameter.getxp(),f,g) &&
           PunktEinzeichnen("xs1",GrafenParameter.getxs1(),f,g))  {
       g.setColor(new Color(0,0,0));
       g.setFont(new Font("Courier New",1,15));
          
       if (Math.abs(GrafenParameter.getxp()-GrafenParameter.getxs1())>0.02 ) {
          g.drawString("Sekante P - S1",d.width-15*15,15);
          g.setColor(GeradenFarbe);
          m=zeichneSekanten(f,g);
       }
       else{
          g.drawString("Tangente in P",d.width-15*15,15);
          g.setColor(GeradenFarbe); 
          m=zeichneTangente(g);
       }
       String temp="";
       temp= Float.toString(m);
       g.setColor(new Color(0,0,0));
       g.setFont(new Font("Courier New",1,20));
       g.drawString(" m= "+temp.substring(0,temp.indexOf(".")+2),d.width-215,34 );
     } ; /* nur wenn beide Punkte im ZeichenIntervall liegen werden die
             Sekanten eingezeichnet*/
      
     
   }
   public void PlotteGraf(float f[],Graphics g){
      int fi,fi2,i;
      for(i=0;i<d.width-abstand-1;i++){
       fi=(int)( f[i]*yfaktor);
       fi2=(int)( f[i+1]*yfaktor);
       if ( (fi<=d.height-abstand)&&(fi2<=d.height-abstand) ){              
        g.drawLine(i+abstand, d.height-fi-abstand,i+1+abstand,d.height-fi2-abstand);
       } 
      }
   }
   
   public void setOptionen(TAusgabeOptionen GrafenAusgabe,TGrafenParameter GrafenParameter){
     this.GrafenAusgabe=GrafenAusgabe;
     this.GrafenParameter=GrafenParameter;
   }

   private void ZeichneKoorSystem(Graphics g) {
      // Y Achse mit dem Pfeil
      g.drawLine(abstand,0,abstand,d.height);//Achse      
      g.drawLine(abstand,0,abstand-4,abstand+5);      
      g.drawLine(abstand,0,abstand+4,abstand+5);      
      g.drawLine(abstand-4,abstand+5,abstand+4,abstand+5);      
      g.drawString("y",abstand+10,abstand+5);
      
      // X Achse mit dem Pfeil
      g.drawLine(0,d.height-abstand,d.width,d.height-abstand);//Achse
      g.drawLine(d.width,d.height-abstand,d.width-abstand-5,d.height-abstand-4);
      g.drawLine(d.width,d.height-abstand,d.width-abstand-5,d.height-abstand+4);
      g.drawLine(d.width-abstand-5,d.height-abstand-4,d.width-abstand-5,d.height-abstand+4);
      g.drawString("x",d.width-abstand-10,d.height-abstand-10);
      
    
      //X Achsen Einteilung 
      for(int i=1;i<=(d.width-abstand)/xfaktor;i++){
         g.drawLine(i*xfaktor+abstand,d.height-abstand+2,i*xfaktor+abstand,d.height-abstand-2);
         g.drawString(Integer.toString(i),i*xfaktor+abstand-2,d.height-2);
      }
      //Y Achsen Einteilung
      for(int i=1;i<=(d.height-10)/yfaktor;i++){
         g.drawLine(abstand-2,d.height-(i*yfaktor+abstand),abstand+2,d.height- (i*yfaktor+abstand));
         g.drawString(Integer.toString(i),2,d.height-(i*yfaktor+abstand)+4);
      }
   }

   private float[] BerechneFktWerte(String Gleichung) {
      float f[];
      double x;
      f=new float[(d.width-abstand)*5]; // ein wenig Reserve
      String tempgl="";
      Tterm Term=new Tterm();
      
      for(int i=0;i<d.width-abstand;i++){
       x= (double)i/xfaktor;  
       //Funktionswertberechnung!
       tempgl=Gleichung.replaceAll("x",Double.toString(x));
       //System.out.println(tempgl);
       Term.SetTerm(tempgl);
       f[i]=(float) Term.GetErgebnis() ;
       //System.out.println(f[i]);
      }
      return f;
   }
  private boolean PunktEinzeichnen(String bez,float x,float f[],Graphics g){    
      int xint= (int)(x*xfaktor),
          fxint=(int)(f[xint]*yfaktor);
      if (xint<=d.width-abstand){
       if (fxint<=d.height-abstand)
        g.drawOval(xint-2+abstand,d.height-fxint-abstand-2,4,4);
       //else return false;
      String punktname="",
             anfang="";
      anfang=bez.substring(1,2);
      anfang=anfang.toUpperCase();
      
      punktname=anfang+ bez.substring(2,bez.length());
      
      g.drawString(punktname,xint+abstand-10,d.height-fxint-abstand-10); 
      g.drawOval(xint-2+abstand,d.height-abstand-2,4,4);
      g.drawString(bez,xint+abstand,d.height-abstand-10);
      return true;
      }
      else return false;
  }

   private float zeichneSekanten(float f[],Graphics g) {
      float m;
      int xs1int=(int)(GrafenParameter.getxs1()*xfaktor) ,
          xpint=(int)(GrafenParameter.getxp()*xfaktor) ,
          i=xs1int,fi=(int)(f[i]*yfaktor),fxpint=(int)(f[xpint]*yfaktor);
      
      g.drawOval(i-2+abstand,d.height-fi-abstand-2,4,4);
      m=zeichneGerade(f,GrafenParameter.getxp(),GrafenParameter.getxs1(),g);
      float i2=0; //GrafenParameter.getxp();
      for(int z=1;z<GrafenParameter.getanzahl();z++){
          float xsn=0;
          i2= (GrafenParameter.getxs1()-GrafenParameter.getxp()+i2)/2;;
          i=(int)i2*xfaktor;
          fi=(int)(f[i]*yfaktor);
          g.setColor(new Color(255,0,0));
          g.drawOval(i-2+abstand,d.height-fi-abstand-2,4,4);
          
          zeichneGerade(f,GrafenParameter.getxp(),i2,g);
       
       /*   g.drawLine(xpint+abstand,d.height-fxpint-abstand,
                     i+abstand,d.height-fi-abstand);
      */
      };
      return m;
   }

   private float zeichneGerade(float f[], float x1, float x2,Graphics g) {
      float f1=f[(int)(x1*xfaktor)],f2=f[(int)(x2*xfaktor)];
      float m,xg1,yg1,yg2,xg2;
      //Berechnen des Anstieges m:
      m=(f1*1000-f2*1000)/(x1*1000-x2*1000);
      //System.out.println("f1="+f1);
      //System.out.println("f2="+f2);
      //System.out.println("x1-x2="+(x1-x2)+" m=" +m);
      // Punkt-Steigungsform:
      // y-y1=m*(x-x1)
      // y=m*(x-x1)+f1
      // y=mx -m*x1+f1 
      //System.out.println("y="+m+"* x + "+(f1-m*x1) );
      //System.out.println(x1);
      
      xg1=d.width;
      while (((m*( (xg1)/xfaktor-x1)+f1)*yfaktor >0)&&(xg1>0))
       xg1--;
      
      
      yg1=(m*(xg1/xfaktor-x1)+f1)*yfaktor;
    
      //System.out.println("x1= "+xg1+" y1 "+yg1);
      //System.out.println("P1 ("+ xg1+","+yg1+")");
      
      xg2=0;
      while ( ( (m*( xg2/xfaktor-x1)+f1)*yfaktor <d.height)&&(xg2<d.width-abstand))
       xg2++;
          
      yg2=(m*(xg2/xfaktor-x1)+f1)*yfaktor;
     
      //System.out.println("P2 ("+ xg2+","+yg2+")");
      g.drawLine((int)xg1+abstand,d.height-(int)yg1-abstand,
                 (int)xg2+abstand,d.height-(int)yg2-abstand);
      return m;
    
   }
   private float zeichneTangente(Graphics g) {
      float x1=GrafenParameter.getxp(),
            x2=GrafenParameter.getxs1();
      double m,f1=0,f2=0,x,f_alt;
      float xg1,yg1,yg2,xg2;
      m=0;
      //Berechnen des Anstieges m:
      // der Tangente mit Hilfe einer Näherung
      Tterm Term=new Tterm();
      String Gleichung=GrafenParameter.getfktterm(),
             tempgl="";
    
      int i=1;
      x=x1;
      
      tempgl=Gleichung.replaceAll("x",Double.toString(x));
      
      Term.SetTerm(tempgl);
      f1=Term.GetErgebnis(); // Funktionswertvon xp bleibt immer Konstant!
      f_alt=f1;
      do {
      //Berechnen des Anstieges m:
       /* System.out.println("x1 "+x1+" x2 "+x);
        System.out.println("m="+m);
        System.out.println("falt="+f_alt+" f2="+f2);
        System.out.println("falt-f2="+Double.toString(f_alt-f2));
       */
        f_alt=f2;
       
        x=  x1+1/(double)i;
        tempgl=Gleichung.replaceAll("x",Double.toString(x));
        Term.SetTerm(tempgl);
        f2=Term.GetErgebnis();
        m=(f1-f2)/(x1-x);
        i++;      
      } while((Math.abs(f_alt-f2)>0.00001)&&(i<1500) );
    
      //System.out.println("Iteratrionsschritte "+i);
      xg1=d.width;
      while (((m*( (xg1)/xfaktor-x1)+f1)*yfaktor >0)&&(xg1>0))
       xg1--;
      
      
      yg1=(float)(m*(xg1/xfaktor-x1)+f1)*yfaktor;
           
      xg2=0;
      while ( ( (m*( xg2/xfaktor-x1)+f1)*yfaktor <d.height)&&(xg2<d.width-abstand))
       xg2++;
          
      yg2=(float)(m*(xg2/xfaktor-x1)+f1)*yfaktor;
     
      g.drawLine((int)xg1+abstand,d.height-(int)yg1-abstand,
                 (int)xg2+abstand,d.height-(int)yg2-abstand);
      return (float)m;
    
   }

}
