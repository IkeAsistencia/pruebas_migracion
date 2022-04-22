/*
 * LlenaProvxAfian.java
 *
 * Created on 30 de septiembre de 2005, 05:38 PM
 */
package Combos;

/*
 *
 * @author  cabrerar
 */
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/*
 *
 * @author  cabrerar
 * @version
 */
public class LlenaConcepto extends HttpServlet {

    /* Initializes the servlet.
     */
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    /* Destroys the servlet.
     */
    @Override
    public void destroy() {
    }

    /* Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);

        PrintWriter out = response.getWriter();
        String StrCodParent = request.getParameter("clAreaOperativa");
        String StrName = request.getParameter("strName");

        response.setContentType("text/html");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Llena Concepto</title>");
        out.println("</head>");
        out.println("<body><script>");

        cbItemParent hshObj = (cbItemParent) (cbConcepto.getComboHash().get(StrCodParent));
        StringBuilder strSelectHTML = new StringBuilder();

        if (hshObj != null) {
            List tempList = hshObj.getLstChildren();
            int x = 0;
            int xR = 1;
            if (tempList != null) {
                for (x = 0; x < tempList.size(); x++, xR++) {
                    cbItemChildren cbCH = (cbItemChildren) tempList.get(x);
                    strSelectHTML.append("<option value='").append(cbCH.getStrCod()).append("'>").append(cbCH.getStrDescripcion()).append("</option>");
                    //out.println("top.opener.fnOptionxAdd('"+StrName+"','"+ xR +"','"+cbCH.getStrDescripcion()+"','"+cbCH.getStrCod()+"');");
                }
            }
        }
        out.println("top.opener.fnReplaceSelect('" + StrName + "',\"" + strSelectHTML.toString() + "\");");
        strSelectHTML.delete(0, strSelectHTML.length());
        out.println("window.close();</script></body>");
        out.println("</html>");
        out.close();
        StrCodParent = null;
        StrName = null;
        this.destroy();
    }

    /* Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /* Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /* Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
