/*
 * TreeView.java
 *
 * Created on 18 de octubre de 2004, 05:03 PM
 */
package Utilerias;
/*
 *
 * @author  lopgui
 */

/* Creates a new instance of TreeView */

public class TreeView {


   
     
    private String folder = "images";
    private String color = "white";
    public NodeList nodes;
    public String target = "";
    public int length = 0;
    private StringBuffer buf;

    public TreeView() {
        nodes = new NodeList();
        buf = new StringBuffer();
    }

    public void setImagesUrl(String url) {
        this.folder = url;
    }

    public void add(Node node) {
        nodes.add(node);
        length++;
    }

    public void add(String text) {
        add(new Node(text));
    }

    public Node createNode(String text) {
        return (new Node(text));
    }

    public Node createNode(String text, String href, String toolTip) {
        return (new Node(text, href, toolTip));
    }

    private void print(String text) {
        buf.append(text);
    }

    public StringBuffer getTree() {
        print("<script>function toggle(id,p){var myChild = document.getElementById(id);if(myChild.style.display!='block'){myChild.style.display='block';document.getElementById(p).className='folderOpen';}else{myChild.style.display='none';document.getElementById(p).className='folder';}}</script>");
       print("<style>ul.tree{display:none;margin-left:10px;padding:0}li.folder{list-style-image: url(" + folder + "/plus.gif);}li.folderOpen{list-style-image: url(" + folder + "/minus.gif);}li.file{list-style-image: url(" + folder + "/dot.gif);}a.treeview{color:" + color + ";font-family:verdana;font-size:7pt;}a.treeview:link {text-decoration:none;}a.treeview:visited{text-decoration:none;}a.treeview:hover {color:yellow;text-decoration:solid;}" +
                "/* Internet Explorer 8+ (And old Firefox 1.x) */ " +
                " @media screen\\0 { ul.tree { margin-left:-35px; } } "+
                "</style>");

        
//print("<style>ul.tree{display:none;margin-left:10px;}li.folder{list-style-image: url(" + folder + "/plus.gif);}li.folderOpen{list-style-image: url(" + folder + "/minus.gif);}li.file{list-style-image: url(" + folder + "/dot.gif);}a.treeview{color:" + color + ";font-family:verdana;font-size:7pt;}a.treeview:link {text-decoration:none;}a.treeview:visited{text-decoration:none;}a.treeview:hover {color:yellow;text-decoration:solid;}</style>");
        loopThru(nodes, "0");
        return buf;
    }

    private void loopThru(NodeList nodeList, String parent) {
        boolean hasChild;
        String style;

        if (parent != "0") {
            print("<ul class=tree id='N" + parent + "'>");
        } else {
            print("<ul id='N" + parent + "'>");
        }

        for (int i = 0; i < nodeList.length; i++) {
            Node node = nodeList.item(i);

            if (node.childNodes.length > 0) {
                hasChild = true;
            } else {
                hasChild = false;
            }

            if (node.imageUrl == "") {
                style = "";
            } else {
                style = "style='list-style-image: url(" + node.imageUrl + ");'";
            }
            if (hasChild) {
                print("<li " + style + " class=folder onmouseover:this.className=folderOpen onmouseout:this.className=folder id='P" + parent + i + "'><a class=treeview href=javascript:toggle('N" + parent + "_" + i + "','P" + parent + i + "')>" + node.text + "</a>");
            } else {
                if (node.target == "") {
                    node.target = target;
                }
                print("<li " + style + " class=file ><a class=treeview href='" + node.href + "' target='" + node.target + "'  title='" + node.toolTip + "'>" + node.text + "</a>");
            }

            if (hasChild) {
                loopThru(node.childNodes, parent + "_" + i);
            }

            print("</li>");
        }
        print("</ul>");
    }

}

