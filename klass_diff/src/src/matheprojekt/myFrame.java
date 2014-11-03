/*
 * myFrame.java
 * myFrame erzeugt das Formular für diese Programm!
 * Diese Programm wurde von Steve
 * am 11. März 2007, um 15:07
 * erstellt
 */

package matheprojekt;

/**
 *
 * @author Steve
 * @version 0.01
 */

import java.awt.*;
import java.awt.event.*;
import java.io.*;
import javax.swing.*;
import javax.swing.event.*;

public class myFrame extends JFrame implements ActionListener,WindowListener,AdjustmentListener,KeyListener//Frame
//Klasse ableiten! 
{
   Tcfg cfg;     
   TGrafikFenster GrafikFenster= new TGrafikFenster();  
   JTextField funktionsterm=new JTextField(),
                 xp=new JTextField(),
                 xs1=new JTextField(),
                 anzahl=new JTextField();
   TAusgabeOptionen AusgabeOptionen=new TAusgabeOptionen();
   TGrafenAusgabeOptionen AusgabeOpt ;
   JScrollBar deltax = new JScrollBar();
   JLabel jLabel15=new JLabel();
        
   public myFrame(String cfgdatei) //Konstruktor dieser Klasse!
   {
      cfg=new Tcfg(cfgdatei);         
      GrafikFenster.setTitle(cfg.getCfg("GrafikFenster"));
      AusgabeOpt=new TGrafenAusgabeOptionen(cfg);
      AusgabeOpt.setTitle(cfg.getCfg("GrafenAusgabeOptionen"));
      AusgabeOpt.addWindowListener(this);
      
      funktionsterm.setText(cfg.getCfg("funktionsterm"));
      xp.setText(cfg.getCfg("xp"));
      xs1.setText(cfg.getCfg("xs1"));
      anzahl.setText(cfg.getCfg("anzahl"));
      
      
      setTitle(cfg.getCfg("titelHP"));
      setLocation(10,10);
      setSize(290,390);
      setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
      JMenuBar Menue=new JMenuBar();
      
      JMenuItem Infos=new JMenuItem(cfg.getCfg("Infos")),
                Beenden=new JMenuItem(cfg.getCfg("Beenden")),
                Grafenausgabe=new JMenuItem(cfg.getCfg("GrafenAusgabe"));
      JMenu Programm=new JMenu(cfg.getCfg("Programm")),
            Optionen=new JMenu(cfg.getCfg("Optionen"));
      Grafenausgabe.addActionListener(this);
      Beenden.addActionListener(this);
      Infos.addActionListener(this);
      
      Programm.add(Infos);
      Programm.add(Beenden);
      Optionen.add(Grafenausgabe);
      
      Menue.add(Programm);
      Menue.add(Optionen);
  
      setJMenuBar(Menue);
      
      
      JLabel jLabel1=new JLabel(cfg.getCfg("jLabel1")),
             jLabel2=new JLabel(cfg.getCfg("jLabel2")),
             jLabel3=new JLabel(cfg.getCfg("jLabel3")),
             jLabel4=new JLabel(cfg.getCfg("jLabel4")),
             jLabel5=new JLabel(cfg.getCfg("jLabel5")),
             jLabel6=new JLabel(cfg.getCfg("jLabel6")),
             jLabel7=new JLabel(cfg.getCfg("jLabel7")),
             jLabel8=new JLabel(cfg.getCfg("jLabel8"));
      jLabel15.setText(cfg.getCfg("jLabel15"));
      
      
      JButton grafzeigen=new JButton(cfg.getCfg("grafzeigen"));
      grafzeigen.addActionListener(this);
      
      grafzeigen.setToolTipText(cfg.getCfg("grafzeigen_tt"));
      funktionsterm.setToolTipText(cfg.getCfg("funktionsterm_tt"));
      xp.setToolTipText(cfg.getCfg("xp_tt"));
      xs1.setToolTipText(cfg.getCfg("xs1_tt"));
      anzahl.setToolTipText(cfg.getCfg("anzahl_tt"));
      xs1.addKeyListener(this);
      xp.addKeyListener(this);
      
      deltax.setOrientation(JScrollBar.HORIZONTAL);
      deltax.setMaximum(60);
      deltax.setMinimum(0);
      deltax.setValue(10*(int)Math.abs(Float.valueOf(xs1.getText())-Float.valueOf(xp.getText())));
      deltax.addAdjustmentListener(this);
      jLabel15.setText(jLabel15.getText()+
                      Float.toString(
                       (float)deltax.getValue()/
                       ((int)AusgabeOptionen.getxfaktor()/10)
                      )
                      );
      // Autogeneriert
      getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());
      getContentPane().add(funktionsterm, new org.netbeans.lib.awtextra.AbsoluteConstraints(60, 40, 130, -1));
      getContentPane().add(jLabel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 40, -1, -1));
      getContentPane().add(jLabel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 10, -1, -1));
      getContentPane().add(jLabel3, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 80, -1, -1));
      getContentPane().add(jLabel4, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 110, -1, -1));
      getContentPane().add(jLabel5, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 150, -1, -1));
      getContentPane().add(jLabel6, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 180, -1, -1));
      getContentPane().add(xs1, new org.netbeans.lib.awtextra.AbsoluteConstraints(120, 180, 70, -1));
      getContentPane().add(anzahl, new org.netbeans.lib.awtextra.AbsoluteConstraints(120, 260, 70, -1));
      getContentPane().add(jLabel7, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 240, -1, -1));
      getContentPane().add(jLabel7, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 240, -1, -1));
     
      getContentPane().add(jLabel15, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 220, 100, -1));
    
      getContentPane().add(deltax, new org.netbeans.lib.awtextra.AbsoluteConstraints(100, 220, 100, -1));
      
      getContentPane().add(jLabel8, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 260, -1, -1));
      getContentPane().add(xp, new org.netbeans.lib.awtextra.AbsoluteConstraints(120, 110, 70, -1));
      getContentPane().add(grafzeigen, new org.netbeans.lib.awtextra.AbsoluteConstraints(140, 300, -1, -1)); 
      // Autogeneriert ENDE
   }
   public void actionPerformed(ActionEvent e) {
           
      if (e.getActionCommand().equals(cfg.getCfg("grafzeigen"))){
        // der Button graf Zeigen wurde gedrückt 
        // Eingegebene Parameter auslesen und in GrafenParameter abspeichern
        neuzeichnen();
        GrafikFenster.setVisible(true);  // sichtbar machen des Fensters               
     }
     if (e.getActionCommand().equals(cfg.getCfg("Beenden"))){ 
         System.exit(0);// Beenden wurde im Menü gewählt
     }
     if (e.getActionCommand().equals(cfg.getCfg("Infos"))){ 
         // InformationsFrame
         JFrame Test=new JFrame(cfg.getCfg("titelInfos")) ;
         
         JTextArea Text=new JTextArea();
         String Inhalt=DateiLesen("cfg/infos.txt");
         Text.setText(Inhalt);
         
        
         Text.setLineWrap(true);
         Text.setWrapStyleWord(true);
         Text.setFont(new Font("Courier New",1,12));
         Test.setLocation(200,200);
         Test.setSize(400,500);
         
         Test.add("North",new JPanel());
         Test.add("South",new JPanel());
         Test.add("West",new JPanel());
         Test.add("East",new JPanel());
         Test.add("Center",new JPanel().add(Text));
         //Test.pack();
         Test.setVisible(true);
         
     }
     if (e.getActionCommand().equals(cfg.getCfg("GrafenAusgabe"))){ 
         //AusgabeOptionen sichtbar machen
         AusgabeOpt.setVisible(true);
     }
     GrafikFenster.repaint();
   }
   public String DateiLesen(String dateiname){
    try{  
       java.net.URL url = getClass().getResource(dateiname);;  
       BufferedReader datei = new BufferedReader(
                                 new InputStreamReader(url.openStream())   
                                 );
       String t="";
       
       while (datei.ready())
        if (t!="")
           t=t+"\n"+datei.readLine();
        else t=t+datei.readLine();
      
       
       datei.close();
       //System.out.println(t); // zumDebuggen
       return t;
      }
     catch( IOException e ) 
      {
       System.out.println( "Achtung Fehler: "+e );
       return "Fehler "+e;
      }
   }
   
   public void windowClosing(WindowEvent e) {
    // ermitteln der neuen Ausgabe Optionen nach dem Schließen des Optionsfensters
      AusgabeOptionen=AusgabeOpt.getAusgabeOptionen();
      neuzeichnen();
      
   }
   public void adjustmentValueChanged(AdjustmentEvent e) {
      String Titel=jLabel15.getText();
      jLabel15.setText(Titel.substring(0,Titel.indexOf("="))+"= "+Float.toString((float)deltax.getValue()/(int) (AusgabeOptionen.getxfaktor()/10)));
      xs1.setText(Float.toString(Float.valueOf(xp.getText())+(float)e.getValue()/(int) (AusgabeOptionen.getxfaktor()/10)));
   
      neuzeichnen();
   }
   private void neuzeichnen() {
     TGrafenParameter GrafenParameter=new TGrafenParameter();
     GrafenParameter.setParameter(funktionsterm.getText(),xp.getText(),
                                    xs1.getText(),anzahl.getText());
     GrafikFenster.setOptionen(AusgabeOptionen,GrafenParameter) ;
     GrafikFenster.repaint();
   }
   public void keyReleased(KeyEvent e) {  
     if ( (xp.getText().length()>0) && (xs1.getText().length()>0)){
       //deltax neuberechnen!    
       String Titel=jLabel15.getText();
       int Wert=10*(int)Math.abs(Float.valueOf(xs1.getText())-Float.valueOf(xp.getText()));
       if (Wert>=deltax.getMaximum())
          deltax.setMaximum(Wert+10);
       deltax.setValue(Wert);
   
       jLabel15.setText(Titel.substring(0,Titel.indexOf("="))+"= "+Float.toString((float)deltax.getValue()/(int) (AusgabeOptionen.getxfaktor()/10)));
    
       neuzeichnen();
     } 
    }
   
   // folgende Funktionenn werden nicht gebraucht ,müssen aber 
   // implementiert sein (Abstrakte Listener Funktionen)
   public void windowClosed(WindowEvent e)      {   }
   public void windowIconified(WindowEvent e)   {   }
   public void windowDeiconified(WindowEvent e) {   }
   public void windowActivated(WindowEvent e)   {   }
   public void windowDeactivated(WindowEvent e) {   }
   public void windowOpened(WindowEvent e)      {   }
   public void keyTyped(KeyEvent e)             {   }
   public void keyPressed(KeyEvent e)           {   }

  

   

 




}