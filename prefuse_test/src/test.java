
import java.util.Vector;

import javax.swing.JFrame;
import javax.swing.JOptionPane;

import prefuse.Display;
import prefuse.Visualization;
import prefuse.action.ActionList;
import prefuse.action.RepaintAction;
import prefuse.action.assignment.ColorAction;
import prefuse.action.layout.graph.BalloonTreeLayout;
import prefuse.action.layout.graph.ForceDirectedLayout;
import prefuse.action.layout.graph.FruchtermanReingoldLayout;
import prefuse.action.layout.graph.NodeLinkTreeLayout;
import prefuse.action.layout.graph.RadialTreeLayout;
import prefuse.action.layout.graph.SquarifiedTreeMapLayout;
import prefuse.activity.Activity;
import prefuse.controls.DragControl;
import prefuse.controls.PanControl;
import prefuse.controls.WheelZoomControl;
import prefuse.controls.ZoomControl;
import prefuse.data.Edge;
import prefuse.data.Graph;
import prefuse.data.Node;
import prefuse.data.Table;
import prefuse.data.Tuple;

import prefuse.data.io.DataIOException;
import prefuse.data.io.GraphMLReader;
import prefuse.data.tuple.TableNode;
import prefuse.data.tuple.TupleManager;
import prefuse.render.DefaultRendererFactory;
import prefuse.render.EdgeRenderer;
import prefuse.render.LabelRenderer;
import prefuse.util.ColorLib;
import prefuse.visual.VisualItem;




public class test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		String nodeCountStr = JOptionPane.showInputDialog(null,
				  "Count of Nodes?",
				  "Enter Node Cont",
				  JOptionPane.QUESTION_MESSAGE);
	
		int nodeCount= Integer.valueOf(nodeCountStr);
		
		/** erzeuge Graphen aus XML Datei **/
		/**
		Graph graph = null;
		try {
		    graph = new GraphMLReader().readGraph("/socialnet.xml");
		} catch ( DataIOException e ) {
		    e.printStackTrace();
		    System.err.println("Error loading graph. Exiting...");
		    System.exit(1);
		}**/
		
		/** erzeuge Graph manuell **/
		
		Graph graph=new Graph();
		graph.addColumn("name",String.class);
		graph.addColumn("info",String.class);
		
		// Knoten merken
		Vector<Node> n =new Vector<Node>();
		
		// erzeugen der knoten
		for(int i=0;i<nodeCount;i++){
			Node kn=graph.addNode();
			kn.setString("name","T"+i);
			n.add(kn);
			
		}
		// zusammenhängenden Graph erzeugen
		for(int i=0;i<nodeCount-1;i++){
			Edge tmp=graph.addEdge(n.get( i),n.get(i+1));
			tmp.setString("info","TEST");
		}
		
		
		// zufällige kanten hinzufügen		
		
		for(int i=0;i<nodeCount;i++){
			graph.addEdge(n.get( (int)(Math.random()*nodeCount)),n.get( (int)(Math.random()*nodeCount)));
		}
		
		// add the graph to the visualization as the data group "graph"
		// nodes and edges are accessible as "graph.nodes" and "graph.edges"
		Visualization vis = new Visualization();
		vis.add("graph", graph);
		
		// draw the "name" label for NodeItems
		LabelRenderer r = new LabelRenderer("name");
		
		r.setRoundedCorner(10, 10); // round the corners
		
		// draw the "info" label for EdgeItems
		EdgeRenderer e = new EdgeRenderer();
		
		
		LabelRenderer t = new LabelRenderer("info");
		
		
		DefaultRendererFactory ren= new DefaultRendererFactory();
		ren.setDefaultRenderer(r);
		
		
		
		//ren.add(p, r)
		//ren.add("graph.edges",t);
		// create a new default renderer factory
		// return our name label renderer as the default for all non-EdgeItems
		// includes straight line edges for EdgeItems by default
		vis.setRendererFactory(ren);


		
		
		
		
		// map nominal data values to colors using our provided palette
		ColorAction fill = new ColorAction("graph.nodes",
		    VisualItem.FILLCOLOR, ColorLib.rgb(255,180,180));
		
		
		// use black for node text
		ColorAction text = new ColorAction("graph.nodes",
		    VisualItem.TEXTCOLOR, ColorLib.gray(0));
		// use light grey for edges
		ColorAction edges = new ColorAction("graph.edges",
		    VisualItem.STROKECOLOR, ColorLib.gray(200));
			
		// create an action list containing all color assignments
		ActionList color = new ActionList();
	
		color.add(text);
		color.add(edges);
		color.add(fill);
		
		// create an action list with an animated layout
		// the INFINITY parameter tells the action list to run indefinitely
		ActionList layout = new ActionList( Activity.INFINITY);
		layout.add(new ForceDirectedLayout("graph")); // O(N log N) and O(E)  N = Nodes, E = Edges
		layout.add(new RepaintAction());
		
		// add the actions to the visualization
		vis.putAction("color", color);
		vis.putAction("layout", layout);
		
		
		
		// create a new Display that pull from our Visualization
		Display display = new Display(vis);
		display.setSize(720, 500); // set display sizetra
		display.addControlListener(new DragControl()); // drag items around
		display.addControlListener(new PanControl());  // pan with background left-drag
		display.addControlListener(new WheelZoomControl()); // zoom with mouse wheel
								// ZoomControl with right mouse button
		
		// create a new window to hold the visualization
		JFrame frame = new JFrame("prefuse example "+nodeCountStr);
		// ensure application exits when window is closed
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.add(display);
		frame.pack();           // layout components in window
		frame.setVisible(true); // show the window

		vis.run("color");  // assign the colors
		vis.run("layout"); // start up the animated layout

		

	}

}
