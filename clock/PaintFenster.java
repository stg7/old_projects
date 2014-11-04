
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Calendar;
import javax.swing.JFrame;
import javax.swing.Timer;



public class PaintFenster extends JFrame implements ActionListener{
    private double secW=0; // sekundenwinkel
    private double minW=0; // Minutenwinkel
    private double hW=0; // Stundenwinkel

    public void paint(Graphics g){
        super.paint(g);
        Graphics2D t=(Graphics2D) g;
        t.translate(50, 50);// verschieben
        t.scale(2,2); // Skalieren

        t.drawOval(0, 0,100,100);
        t.translate(50,50);

        t.rotate(secW,0,0); // rotieren
        t.drawLine(0,0,0,-50); // linie zeichnen
        t.rotate(2*Math.PI-secW,0,0); // rückrotieren


        t.rotate(minW,0,0); // rotieren
        t.drawLine(0,0,0,-40); // linie zeichnen
        t.rotate(2*Math.PI-minW,0,0); // rückrotieren

        t.rotate(hW,0,0); // rotieren
        t.drawLine(0,0,0,-30); // linie zeichnen
        t.rotate(2*Math.PI-hW,0,0); // rückrotieren



    }

    public PaintFenster(){
        setTitle("Zeichnen"); // Titel festlegen
        setSize(300,300); // Größe festlegen

        // damit man das fenster schließen kann
        setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );

        setLayout(null);

        Calendar now = Calendar.getInstance();

        secW=2*Math.PI/60*now.get(Calendar.SECOND);
        minW=2*Math.PI/60*now.get(Calendar.MINUTE);
        hW=2*Math.PI/12*now.get(Calendar.HOUR);
        Timer timer=new Timer(getDefaultCloseOperation(),null);
        timer.setDelay(1000);
        timer.addActionListener(this);
        timer.start();
        repaint();


    }

    @Override
    public void actionPerformed(ActionEvent arg0) {
        secW+=Math.PI/30;
        if(secW>=Math.PI*2){
            minW+=Math.PI/30;
            secW=0;
        }
        if(minW>=Math.PI*2){
            minW=0;
            hW+=Math.PI/6;
        }
        if(hW>=Math.PI*2){
            hW=0;
        }
        repaint();
    }

}
