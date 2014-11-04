import java.awt.Toolkit;

import javax.swing.JButton;
import javax.swing.JFrame;


public class ListenerFenster extends JFrame implements InterfaceTestListener {

    // Konstruktor des Fensters, analog Fenster..
    public ListenerFenster(){
        super();
        
        // Titel festlegen
        setTitle("TEST");
        
        // größe festlegen
        setSize(300,10);
        
        // zuerst unsichtbar
        setVisible(false);
        
        
        // zufallsposition
        setLocation( (int)(Math.random()*Toolkit.getDefaultToolkit().getScreenSize().getWidth()) ,
                     (int)(Math.random()*Toolkit.getDefaultToolkit().getScreenSize().getHeight()) ) ;
        
        // lauoutmanager auf null setzen.. erstmal uninteressant
        setLayout(null);
        
       
        
    }
    
    @Override
    public void aktion(String msg) {
        // HIER WIRD DIE AKTION weitergeleitet.
        
        // man soll es auch sehen
        setVisible(true);
        
        
        // was machen wir?..
        // das fenster bewegen
        setLocation( (int)(Math.random()*400) ,(int)(Math.random()*400) ) ;
        
        // und eine Zufallsüberschrift setzen        
        setTitle( msg+(char)(Math.random()*50+50) + (char)(Math.random()*50+50) +(char)(Math.random()*50+50) +"");
        
        
        
        
    }

}
