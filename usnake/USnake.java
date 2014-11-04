import java.awt.*;
import java.awt.event.*;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.*;
import javax.swing.*;
import javax.swing.Timer;

// 40 minutes snake

// Controls: wasd and q for quit

public class USnake extends JPanel implements ActionListener, KeyListener {

	// consts
	static int scale = 5;
	static Color snakeColor = Color.BLUE;
	static Color pieceColor = Color.GREEN;

	// game infos
	private int _size;
	private int _posx;
	private int _posy;
	private int _dx;
	private int _dy;
	private LinkedList<Point> snake = new LinkedList<Point>();
	private Vector<Point> pieces = new Vector<Point>();

	// timer for redrawing
	private Timer t = new Timer(100, this);

	class Point{
		int x;
		int y;
		Point(int xx,int yy){
			x = xx;
			y = yy;
		}
	}

	public USnake(int size){
		super();
		_size = size;
		_posx = size / 2;
		_posy = size / 2;
		_dx = 1;
		_dy = 0;

		//setLayout(null);
		setSize(100 * scale,100 * scale);
		setVisible(true);
		setBackground(Color.red);

		for(int i = 0 ; i< 10 ; i++){
			snake.add(new Point(-1,0));
			int x = (int)(Math.random()* _size);
			int y = (int)(Math.random()* _size);
			pieces.add(new Point(x,y));
		}
		t.start();
		addKeyListener(this);
	}

	private void drawPoint(int x, int y, Graphics g, Color c){
		Color b = g.getColor();
		g.setColor(c);
		g.fillRect((x+_size)%_size *scale, (y+_size) %_size *scale, scale, scale);
	}

	public void paint(Graphics g) {
		super.paint(g);
		g.setColor(Color.red);
		g.fillRect(0, 0, getWidth(), getHeight());

		Point start = new Point(_posx, _posy);
		Point p,l;
		String points = "";
		int id = snake.size()+1000;
		for(int i = 0 ; i< pieces.size(); i++){
			p = pieces.get(i);
			// collision with piece
			if(p.x == _posx && p.y == _posy){
				l = snake.getLast();
				snake.add(new Point(l.x,l.y));
				p.x = (int)(Math.random()* _size);
				p.y = (int)(Math.random()* _size);
			}
			else{
				drawPoint(p.x, p.y, g, pieceColor);
				points += NodeToXml(id, ((float)(p.x + _size)%_size) /_size + 0.05  , ((float)(p.y + _size)%_size) /_size + 0.05, 1.0) ;
				id++;
			}
		}
		send(points);

		int sumx = 0;
		int sumy = 0;
		String node ="";
		id = 0;
		for(Point s :snake){
			drawPoint(start.x, start.y, g, snakeColor);
			sumx += s.x;
			sumy += s.y;
			start.x += s.x;
			start.y += s.y;

			node += NodeToXml(id, ((float)(start.x + _size)%_size) /_size + 0.05, ((float)(start.y + _size)%_size) /_size + 0.05,0.0);

			id++;
			// self collision
			if (sumx == 0 && sumy == 0 ){
				t.stop();
			}

		}
		send(node);
		String edges = "";
		for(int i = 0;i< snake.size()-1; i++){
			edges += EdgeToXml(i,i+1);
		}
		send(edges);
	}

	@Override
	public void actionPerformed(ActionEvent arg0) {
		_posx += _dx;
		_posy += _dy;
		_posx = (_posx + _size) %_size;
		_posy = (_posy + _size) %_size;

		snake.removeLast();
		snake.addFirst(new Point(-_dx, -_dy));
		repaint();
	}

	@Override
	public void keyPressed(KeyEvent arg0) {	}

	@Override
	public void keyReleased(KeyEvent arg0) { }

	@Override
	public void keyTyped(KeyEvent e) {

		switch (Character.toLowerCase(e.getKeyChar())) {
		case 'w':
			if(_dy == 0 ){
				_dx = 0;
				_dy = -1;
			}
			break;
		case 's':
			if(_dy == 0 ){
				_dx = 0;
				_dy = 1;
			}
			break;
		case 'a':
			if(_dx == 0 ){
				_dx = -1;
				_dy = 0;
			}
			break;
		case 'd':
			if(_dx == 0 ){
				_dx = 1;
				_dy = 0;
			}
			break;
		case 'q':
			System.exit(0);
			break;
		default:
			break;
		}
	}

	// send String s to localhost:4000
	private static void send(String s){ /*
		try {
			Socket server = new Socket( "127.0.0.1", 4000 );


			OutputStream outS = server.getOutputStream();
			PrintWriter o=new PrintWriter(outS);

			o.println(s);

			o.close();
		} catch (UnknownHostException e) {

		} catch (IOException e) {

		} */
	}

	// create a node as xml string
	private static String NodeToXml(int id, double posx, double posy,double color){

		int layer = 0 ;
		return "<node layer=\""+layer+"\" "
					+"color=\""+color+"\">"
					+" <id>"+id+"</id>"
					+" <posx>"+posx+"</posx>"
					+" <posy>"+posy+"</posy>"
				+"</node>"	;

	}
	// create a edge as xml string
	private static String EdgeToXml(int n, int e){


		double color=0.5;
		int layer = 0;
		return "<edge layer=\""+layer+"\"  width=\""+0.5
					 +"\" color=\""+color+"\"  >" +
					"<src>"+n+"</src>"+
					"<dest>"+e+"</dest>"
				+"</edge>";
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		JFrame f = new JFrame();
		int size = 100;
		USnake us = new USnake(size);
		f.add(us);
		f.setSize(size * scale, size * scale + 20);
		f.addKeyListener(us);
		f.setVisible(true);
	}
}
