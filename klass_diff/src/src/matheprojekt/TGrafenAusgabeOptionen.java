/*
 * TGrafenAusgabeOptionen.java
 *
 * Diese Programm wurde von Steve
 * am 18. März 2007, um 14:47
 * erstellt
 */

package matheprojekt;

import java.awt.Color;
import java.awt.event.*;
import javax.swing.*;

/**
 *
 * @author Steve
 * @version 0.01
 */
public class TGrafenAusgabeOptionen extends JFrame implements ActionListener, 
                                                              AdjustmentListener,
                                                              WindowListener
                                                              
{
   TAusgabeOptionen AusgabeOptionen=new TAusgabeOptionen();
   Tcfg cfg;
   JLabel  jLabel12 = new JLabel(),
           jLabel13 = new JLabel();
   JScrollBar XAchse = new JScrollBar(),
              YAchse = new JScrollBar();
   JCheckBox gleichlauf = new JCheckBox();
   JFrame Farbwähler=new JFrame();
   JPanel Farbe = new JPanel(),Farbe2 = new JPanel();
   int taste=0;
   
   JColorChooser Farbauswähler=new JColorChooser();
        
           
     /** Konstruktor der Klasse TGrafenAusgabeOptionen */
   public TGrafenAusgabeOptionen() {
     intitialisierung();
   } 
   public TGrafenAusgabeOptionen(Tcfg cfg) {
      this.cfg=cfg;
      intitialisierung();
   }
   public void intitialisierung(){
      setLocation(100,100);
      setSize(340,300);
      
      Farbwähler.setTitle(cfg.getCfg("Farbwähler"));
      Farbwähler.setLocation(150,150);
      Farbauswähler.setColor(AusgabeOptionen.getGrafenFarbe());
      Farbwähler.add(Farbauswähler) ; 
      Farbwähler.addWindowListener(this);
      
      jLabel12.setText(Integer.toString(AusgabeOptionen.getyfaktor())+" "+cfg.getCfg("jLabel12"));
      jLabel13.setText(Integer.toString(AusgabeOptionen.getxfaktor())+" "+cfg.getCfg("jLabel13"));
      
      JLabel jLabel9 = new JLabel (cfg.getCfg("jLabel9")),
             jLabel10 = new JLabel(cfg.getCfg("jLabel10")),
             jLabel11 = new JLabel(cfg.getCfg("jLabel11")),
             jLabel14 = new JLabel(cfg.getCfg("jLabel14")),
             geradenf = new JLabel(cfg.getCfg("geradenf"));
      
      gleichlauf.setText(cfg.getCfg("gleichlauf"));
      
     
    
      JButton ändern = new JButton(cfg.getCfg("ändern")),
              ändern2= new JButton(cfg.getCfg("ändern")+" ");
      Farbe.setBackground(AusgabeOptionen.getGrafenFarbe());
      Farbe2.setBackground(AusgabeOptionen.getGeradenFarbe());
  
      ändern.addActionListener(this);
      ändern2.addActionListener(this);
      
          
      XAchse.setOrientation(JScrollBar.HORIZONTAL);
      
      XAchse.setMaximum(510);
      YAchse.setMaximum(510);
      XAchse.setMinimum(10);
      YAchse.setMinimum(10);
      
      XAchse.setValue(AusgabeOptionen.getxfaktor());
      YAchse.setValue(YAchse.getMaximum()-AusgabeOptionen.getyfaktor());
      XAchse.addAdjustmentListener(this);
      YAchse.addAdjustmentListener(this);
      
      JTextField Abstand = new JTextField();
      // Autogeneriert
      getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());
      getContentPane().add(jLabel9, new org.netbeans.lib.awtextra.AbsoluteConstraints(40, 40, -1, -1));
      getContentPane().add(ändern, new org.netbeans.lib.awtextra.AbsoluteConstraints(190, 40, 100,18));
      getContentPane().add(Farbe, new org.netbeans.lib.awtextra.AbsoluteConstraints(150, 40, 20, 20));
      getContentPane().add(geradenf, new org.netbeans.lib.awtextra.AbsoluteConstraints(40, 60, -1, -1));
      getContentPane().add(ändern2, new org.netbeans.lib.awtextra.AbsoluteConstraints(190, 60, 100,18));
      getContentPane().add(Farbe2, new org.netbeans.lib.awtextra.AbsoluteConstraints(150, 60, 20, 20));
      
      getContentPane().add(XAchse, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 210, 130, -1));
      getContentPane().add(YAchse, new org.netbeans.lib.awtextra.AbsoluteConstraints(50, 90, -1, 120));
      getContentPane().add(jLabel10, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 90, -1, -1));
      getContentPane().add(jLabel11, new org.netbeans.lib.awtextra.AbsoluteConstraints(210, 210, -1, -1));
      getContentPane().add(jLabel12, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 130, -1, -1));
      getContentPane().add(jLabel13, new org.netbeans.lib.awtextra.AbsoluteConstraints(130, 180, -1, -1));
      getContentPane().add(jLabel14, new org.netbeans.lib.awtextra.AbsoluteConstraints(40, 10, 300, -1));
      getContentPane().add(gleichlauf, new org.netbeans.lib.awtextra.AbsoluteConstraints(160, 90, -1, -1));

      // Autogeneriert Ende
   }
   public TAusgabeOptionen getAusgabeOptionen(){
      return this.AusgabeOptionen;
   } 

   public void adjustmentValueChanged(AdjustmentEvent e) {
      // diese Prozedur wird aufgerufen wenn die Werte der Scrollbars 
      // verändert werden
      // wenn die Checkbox gleichlauf aktiviert ist 
      // sind die X/Y Werte gleichläufig
       if (gleichlauf.getSelectedObjects()!=null){
         if (e.getValue()==XAchse.getValue())
            YAchse.setValue(YAchse.getMaximum()-e.getValue());
         else XAchse.setValue(YAchse.getMaximum()-e.getValue());
       };
       jLabel13.setText(XAchse.getValue()+" "+cfg.getCfg("jLabel12"));
       AusgabeOptionen.setxfaktor(XAchse.getValue());
       jLabel12.setText(YAchse.getMaximum()-YAchse.getValue()+" "+cfg.getCfg("jLabel13"));
       AusgabeOptionen.setyfaktor(YAchse.getMaximum()-YAchse.getValue());
       //System.out.println("Y Faktor "+AusgabeOptionen.getyfaktor());
      
   }

   public void actionPerformed(ActionEvent e) {
      if(e.getActionCommand().equals(cfg.getCfg("ändern"))){          
         Farbwähler.setVisible(true);
         Farbwähler.pack();
         taste=1;
      }
      if(e.getActionCommand().equals(cfg.getCfg("ändern")+" ")){          
         Farbwähler.setVisible(true);
         Farbwähler.pack();
         taste=2;
      }
      
   }

   
 // die anderen Prozeduren müssen
 // dabei sein, da sie abstrakt sind und die Hauptklasse TGrafenAusgabeOptionen als
 // Windowlistener arbeitet, WindowClosing wird nur verwendet 
   public void windowClosing(WindowEvent e) {
      if (taste==1){
       AusgabeOptionen.setGrafenFarbe(Farbauswähler.getColor());
       Farbe.setBackground(AusgabeOptionen.getGrafenFarbe());
      }else {
       AusgabeOptionen.setGeradenFarbe(Farbauswähler.getColor());
       Farbe2.setBackground(AusgabeOptionen.getGeradenFarbe());
          
      } 
  }
   
   public void windowOpened(WindowEvent e)      {   }
   public void windowClosed(WindowEvent e)      {   }
   public void windowIconified(WindowEvent e)   {   }
   public void windowDeiconified(WindowEvent e) {   }
   public void windowActivated(WindowEvent e)   {   }
   public void windowDeactivated(WindowEvent e) {   }
}
