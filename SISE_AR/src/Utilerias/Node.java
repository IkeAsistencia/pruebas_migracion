package Utilerias;

public class Node 
{
    public String text;
    public String href;
    public String target="";
    public String toolTip;
    public NodeList childNodes;
    public String imageUrl="";
    public int length=0;

    public Node(){
        childNodes = new NodeList();
    }	
    
    public Node(String text){
        this(text,"");
    }	
    
    public Node(String text,String href){
        this(text,href,"");
    }	

    public Node(String text,String href,String toolTip){
        this();
        this.text=text;
        this.href=href;
        this.toolTip=toolTip;
    }	

    public void add(Node node){
        childNodes.add(node);
        length++;
    }

    public void add(String text){
        add(new Node(text));
    }

}