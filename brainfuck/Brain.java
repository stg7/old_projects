import java.io.*;
import java.util.*;
import javax.swing.JOptionPane;

/**
 * Brainfuck Interpreter 
 * 
 * Befehle:
 * 	
 * Zeichen 	Semantik
> 	inkrementiert den Zeiger
< 	dekrementiert den Zeiger
+ 	inkrementiert den aktuellen Zellenwert
- 	dekrementiert den aktuellen Zellenwert
. 	Gibt den aktuellen Zellenwert als ASCII-Zeichen auf der Standardausgabe aus
, 	Liest ein Zeichen von der Standardeingabe und speichert dessen ASCII-Wert in der aktuellen Zelle
[ 	Springt nach vorne, hinter den passenden ]-Befehl, wenn der aktuelle Zellenwert null ist
] 	Springt zurück, hinter den passenden [-Befehl, wenn der aktuelle Zellenwert verschieden von null ist
* 
* alle anderen Zeichen werden ignoniert
 * 
 * 
 **/ 

/**
 * minimale datenstruktur, namens QStack <-> beinhaltet Q und Stack Eigenschaften
 */
class MStack{
	private Vector<Character> s=new Vector<Character>();
	public void push(char c){
		s.add(c);
	}	
	public char pop(){
		char tmp=s.firstElement();
		s.remove(0);
		return tmp;
	}	
	public char last(){
		char tmp=s.lastElement();
		s.remove(s.size()-1);
		return tmp;
	}
	public boolean isEmpty(){
		return s.size()==0;
	}	
	public char top(){
		return isEmpty()?' ':s.firstElement();		
	}
}	

public class Brain{

	/**
	 * lösche alle nicht benötigten zeichen
	 */
	private static String simplifyCode(String s){
		String res="";
		String valid="<>+-.,[]";
		for(char c: s.toCharArray())
			if( valid.indexOf(c)>=0) 
				res+=c;
		return res;
	}	
	
	private static boolean syntaxCheck(String code){
		// wichtig ist im grunde genommen die richtige verwendung der Klammern
		// -> mit Hilfe eines 'PDA' wird das Überprüft
		MStack s=new MStack();
		for(char c: code.toCharArray()){
			if(c=='[' )
				s.push('[');			
			if(c==']' )
				if(s.top()=='[')
					s.pop();
				else 
					return false; // falsche klammer konstellation gefunden -> fehler				
		}
		return s.isEmpty();
	}	
	
	private static void doBrainFuck(String code){
		Vector<Character> memory=new Vector<Character>(); // oder halt nen array
		
		// jump marken
		int[] jumps=new int[code.length()]; // code bleibt immer gleich lang
		int[] jumpsback=new int[code.length()]; // code bleibt immer gleich lang
		
		MStack s=new MStack();
		MStack t=new MStack();// sollt besser ne Q sein
		int pos=0;
		for(char c: code.toCharArray()){
			if(c=='[' ){
				s.push('[');
				t.push((char)pos); // merken der position 
			}
			if(c==']' ){
				if( s.top()=='['){
					int k=(int)t.last(); // ermiteln der zuerst eingefügten Klammer [ pos 
					jumps[k]=pos; // jump array setzen, 
					jumpsback[pos]=k; // zurück springen setzen
					s.pop(); // bei jedem popen, haben wir ein klammerpäärchen gefunden
				}				
			}
			pos++;
		}	
		
		
		int index=0;
		char tmp=0;
		memory.add(tmp);
		
		int i=0;
		while(i<code.length()){
			switch (code.charAt(i)) {
				case '+':{ //+ 	inkrementiert den aktuellen Zellenwert
					tmp=memory.get(index);
					tmp++;
					memory.set(index, tmp);
					break;
				}
				case '-':{//- 	dekrementiert den aktuellen Zellenwert
					tmp=memory.get(index);
					if(tmp!=0)
						tmp--;
					memory.set(index, tmp);
					break;
				}
				case '>':{//> 	inkrementiert den Zeiger
					index++;
					if(memory.size()<=index){
						memory.add(index,new Character((char)0));
					}
					break;
				}
				case '<':{//< 	dekrementiert den Zeiger
					index--;
					if(index<=0){
						index=0;
					}
					break;
				}
				case '.':{//. 	Gibt den aktuellen Zellenwert als ASCII-Zeichen auf der Standardausgabe aus
					tmp=memory.get(index);
					System.out.print(tmp);
					break;
				}
				case ',':{//, 	Liest ein Zeichen von der Standardeingabe und speichert dessen ASCII-Wert in der aktuellen Zelle
					String res=JOptionPane.showInputDialog("gib ein Zeichen ein (1. zeichen wird benutzt)");
					memory.set(index, res.charAt(0));
					break;
				}
				case '[':{//[ 	Springt nach vorne, hinter den passenden ]-Befehl, wenn der aktuelle Zellenwert null ist
					tmp=memory.get(index);// aktuellen zellenwert anschauen
					if(tmp==(char)0) // dann springe nach vorn
						i= jumps[i];
					break;
				}
				case ']':{//]
					i= jumpsback[i]-1;// zurückspringen					
					break;
				}
			}
			i++;
		}	
	}
	
	public static void runBrainFuck(String input){
		String code=simplifyCode(input);
		if(!syntaxCheck(code)){
			System.out.println("no valid brainfuck code");
			return;
		}
		// code ist nun gereinigt , und korrekt 
		// -> auswerten des ganzen
		System.out.println(code);
		doBrainFuck(code);
		System.exit(0); // beenden
	}
	
	private static void help(){
		System.out.println("brainfuck interpreter: copyright stg7 2010/2011");
		System.out.println(" brain [do] \n [do]= [filename]|| [-help] || [-debug]");
		System.exit(0);
	}	
	private static void interpretFile(String filename){
		// datei einlesen:
		String input="";
		try {
			BufferedReader in = new BufferedReader(new FileReader(filename));
			String line="";
			while ((line = in.readLine()) != null)
				input+=line;

			runBrainFuck(input);		
		} catch (FileNotFoundException e) {
			System.out.println("file not found");
			System.exit(-1);
		} catch (IOException e) {
			System.out.println("unknown error");
			System.exit(-1);
		}
	}	
	public static void main(String[] args){
		// parameter checken:

		// keine paras-> eingabe
		if(args.length==0)
			runBrainFuck(JOptionPane.showInputDialog("Programmcode eingeben:"));
		
		args[0]=args[0].toLowerCase(); // in kleinbuchstaben
		
		// ausführen eines im parameter übergebenen programms
		if(args[0].equals("-c")){
			if(args.length>=2)
				runBrainFuck(args[1]);
			else {
				System.out.println("no file as parameter");
				System.exit(-1);
			}
		}	
		// debuge
		if(args[0].equals("-debug"))
			runBrainFuck("++++++++++[>+++++++>++++++>+++++++>++++++++<<<<-]>++.>+++++.>++++++..>-." );
		//hilfe 	
		if(args[0].equals("-help"))
			help();
					
		// ansonsten eingabe einer quelltextdatei als parameter
		interpretFile(args[0]);
	}	
}	
