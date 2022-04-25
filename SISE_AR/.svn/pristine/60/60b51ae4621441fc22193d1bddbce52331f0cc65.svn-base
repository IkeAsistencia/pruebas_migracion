package Utilerias;

import java.util.Vector;

public class NodeList {

    Vector v;
    int length = 0;

    public NodeList() {
        v = new Vector();
    }

    public void add(Node node) {
        v.add(node);
        length++;
    }

    public void add(String text) {
        add(new Node(text));
    }

    public Node item(int index) {
        return (Node) v.get(index);
    }
}