
public class Haupt {

    /**
     * @param args
     */
    public static void main(String[] args) {


        // fenster erzeugen
        Fenster f=new Fenster();

        // 20 ListenerFenster erzeugen und dem Fenster registrieren
        for(int i=0;i<20;i++){
            InterfaceTestListener j=new ListenerFenster();
            f.addListenerFenster(j);
        }

        // fenster sichtbar machen
        f.setVisible(true);

    }

}
