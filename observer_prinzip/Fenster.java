
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;

import javax.swing.JButton;
import javax.swing.JFrame;


/**
 * Fenster welches Angezeigt wird.
 * @author stg7
 *
 */
public class Fenster extends JFrame implements ActionListener {
    
    Vector<InterfaceTestListener> listeners=new Vector<InterfaceTestListener>(); 
    
    
    JButton Button;
    
    public Fenster(){
        super();
        
        // Titel festlegen
        setTitle("TEST");
        
        // größe festlegen
        setSize(200,200);
        
        // damit man das fenster schließen kann
        setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
        
        // zufallsposition
        setLocation( (int)(Math.random()*400) ,(int)(Math.random()*400) ) ;
        
        // lauoutmanager auf null setzen.. erstmal uninteressant
        setLayout(null);
        
        // Button erzeugen
        Button=new JButton("DO IT!");
        // Position des Buttons
        Button.setLocation(30,30);
        // Größe des Buttons
        Button.setSize(80,20);
        
        // diese Klasse soll auf ein Buttonereignis reagieren
        Button.addActionListener(this);
        
        //Button hinzufügen
        add(Button);
        
    }
    public void addListenerFenster(InterfaceTestListener i){
        listeners.add(i);
    }
    @Override
    public void actionPerformed(ActionEvent arg0) {
        // DER BUTTON WURDE GEDRÜCKT
        
        // diese Aktion soll nun an alle Listener weitergegeben werden:
        
        for(InterfaceTestListener l: listeners){
            l.aktion("HALLO");
        }
        
        
        
    }
    

}
