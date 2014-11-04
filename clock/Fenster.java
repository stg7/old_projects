import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
/**
 * Fenster welches Angezeigt wird.
 * @author stg7
 *
 */
public class Fenster extends JFrame  implements ActionListener{
    JPanel p;
    public Fenster(){
        setTitle("Hallo Button"); // Titel festlegen
        setSize(300,300); // Größe festlegen

        // damit man das fenster schließen kann
        setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );

        /** hier folgt die Ergänzung **/
        setLayout(null);
        JButton taste=new JButton("Test");  // button test erzeugen
        taste.setSize(80,30);
        taste.setLocation(40, 40);
        taste.addActionListener(this);
        add(taste); // testbutton dem Fenste hinzufügen
        p=new JPanel();
        p.setBackground(Color.BLACK);
        p.setSize(200,200);
        add(p);

    }

    @Override
    public void actionPerformed(ActionEvent arg0) {
        p.setBackground(new Color( (int)(Math.random()*255),
                                    (int)(Math.random()*255),
                                    (int)(Math.random()*255) ));
        JOptionPane.showMessageDialog(null,"Hey du hast die Taste gedrückt",
        "Taste",JOptionPane.DEFAULT_OPTION);

    }
}
