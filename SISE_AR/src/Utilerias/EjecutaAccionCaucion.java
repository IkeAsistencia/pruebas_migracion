/*
 * EjecutaAccion.java
 *
 * Created on 3 de diciembre de 2004, 04:27 PM
 */

package Utilerias;

import java.sql.ResultSet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/*
 *
 * @author  cabrerar
 * @version
 */
public class EjecutaAccionCaucion extends HttpServlet {
    
    /* Initializes the servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        
    }
    
    /* Destroys the servlet.
     */
    public void destroy() {
        
    }
    
    /* Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
        String StrSentence = "";                    
        String StrFields = "";
        String StrVals = "";
        String StrType ="";
        String StrWhere = "";
        String strBack="";
        boolean blnBackId=false;
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Prueba de Servicio Seguridad</title>");
        out.println("</head>");
        out.println("<body>");

        if (request.getParameter("Action")==null){
            out.println("Problema con la definición de la acción a realizar, por favor vuelva a intentarlo");
            out.println("</body>");            
            out.println("</html>");            
            out.close();
            return;            
        }

        if (sessionH.getAttribute("clPaginaWebP")==null){
            out.println("No se definió variable de session para la página");
            out.println("</body>");            
            out.println("</html>");            
            out.close();
            return;            
        }
     
        try{
            ResultSet rs = UtileriasBDF.rsSQLNP("select Tabla from cPaginaWeb where clPaginaWeb = " + sessionH.getAttribute("clPaginaWebP"));
            if(rs.next()){
                ResultSet rsInfo = UtileriasBDF.rsSQLNP("sp_GetInfoTabla " + rs.getString("Tabla"));                
                                
                if (Integer.parseInt(request.getParameter("Action"))==1){
                    String StrSql="";
                    String Folio="0";
                    StrSql = "sp_CalculaMaxFolioCaucion '" + request.getParameter("FechaExped") + "'";
                    ResultSet rsFolio = UtileriasBDF.rsSQLNP(StrSql);  
                    if (rsFolio.next()){
                        Folio=rsFolio.getString("folio");
                        rsFolio.close();
                    }   
                    StrSentence = "Insert into " + rs.getString("Tabla");                                        
                    while(rsInfo.next()){
                        if (request.getParameter(rsInfo.getString("NameF"))!=null){
                            // No es un campo identity, en un insert se debe omitir
                            if (rsInfo.getString("Identit").equalsIgnoreCase("No")){
                                if (StrFields!=""){
                                    StrFields=StrFields+",";
                                    StrVals=StrVals+",";
                                }
                                StrFields = StrFields + rsInfo.getString("NameF");
                                StrType = rsInfo.getString("TypeData").toString();
                                if (StrType.equalsIgnoreCase("tinyint") || StrType.equalsIgnoreCase("bigint") || StrType.equalsIgnoreCase("binary") || StrType.equalsIgnoreCase("bit") || StrType.equalsIgnoreCase("decimal") || StrType.equalsIgnoreCase("float") || StrType.equalsIgnoreCase("int") || StrType.equalsIgnoreCase("money") || StrType.equalsIgnoreCase("numeric") || StrType.equalsIgnoreCase("real") || StrType.equalsIgnoreCase("smallint") || StrType.equalsIgnoreCase("smallmoney") || StrType.equalsIgnoreCase("uniqueidentifier") || StrType.equalsIgnoreCase("varbinary")){
                                    if(request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("")){
                                        StrVals = StrVals + "null";                                                                        
                                    }else{
                                        StrVals  = StrVals + request.getParameter(rsInfo.getString("NameF"));                                    
                                    }
                                }else{
                                    if(request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("") && (rsInfo.getString("nullable").equalsIgnoreCase("Si")) ){
                                        StrVals = StrVals + "null";                                                                        
                                    }else{
                                        StrVals = StrVals + "'" + request.getParameter(rsInfo.getString("NameF")) + "'";
                                    }
                                }
                                if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")){
                                    if(strBack.equalsIgnoreCase("")){
                                        strBack=rsInfo.getString("NameF") +"=" + request.getParameter(rsInfo.getString("NameF"));
                                    }else{
                                        strBack=strBack + "&" + rsInfo.getString("NameF") +"=" + request.getParameter(rsInfo.getString("NameF"));
                                    }
                                }
                            }
                            else{
                                strBack=rsInfo.getString("NameF");
                                blnBackId=true;
                            }
                        }
                        else{
                            if(rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si") && rsInfo.getString("Identit").equalsIgnoreCase("No")){
                                out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                                out.close();
                                return;
                            }
                        }
                    }
                    StrSentence = StrSentence + "(" + StrFields + ",FolioCaucion) values (" + StrVals + "," + Folio + ")";
                }
                
                if (Integer.parseInt(request.getParameter("Action"))==2){
                    StrSentence = "Update " + rs.getString("Tabla") + " set ";
                    while(rsInfo.next()){
                        if (request.getParameter(rsInfo.getString("NameF"))!=null){
                            // No es un campo identity, en un insert se debe omitir
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("No") && rsInfo.getString("Identit").equalsIgnoreCase("No")){
                                if (StrFields!=""){
                                    StrFields=StrFields+",";
                                }
                                StrFields = StrFields + rsInfo.getString("NameF");
                                StrType = rsInfo.getString("TypeData").toString();
                                if (StrType.equalsIgnoreCase("tinyint") || StrType.equalsIgnoreCase("bigint") || StrType.equalsIgnoreCase("binary") || StrType.equalsIgnoreCase("bit") || StrType.equalsIgnoreCase("decimal") || StrType.equalsIgnoreCase("float") || StrType.equalsIgnoreCase("int") || StrType.equalsIgnoreCase("money") || StrType.equalsIgnoreCase("numeric") || StrType.equalsIgnoreCase("real") || StrType.equalsIgnoreCase("smallint") || StrType.equalsIgnoreCase("smallmoney") || StrType.equalsIgnoreCase("uniqueidentifier") || StrType.equalsIgnoreCase("varbinary")){
                                    if(request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("")){
                                        StrFields = StrFields + "=null";
                                    }else{
                                        StrFields = StrFields + "=" + request.getParameter(rsInfo.getString("NameF"));                                    
                                    }
                                }else{
                                    if(request.getParameter(rsInfo.getString("NameF")).toString().equalsIgnoreCase("") && (rsInfo.getString("nullable").equalsIgnoreCase("Si")) ){
                                        StrFields = StrFields + "=null";
                                    }else{
                                        StrFields = StrFields + "='" + request.getParameter(rsInfo.getString("NameF")) + "'";
                                    }
                                }
                            }
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")){
                                if(strBack.equalsIgnoreCase("")){
                                    strBack=strBack + rsInfo.getString("NameF") +"=" + request.getParameter(rsInfo.getString("NameF"));
                                }else{
                                    strBack=strBack + "&" + rsInfo.getString("NameF") +"=" + request.getParameter(rsInfo.getString("NameF"));
                                }
                                if (StrWhere.equalsIgnoreCase("")){
                                    StrWhere = StrWhere + "Where ";
                                }
                                else{
                                    StrWhere = StrWhere + " and ";
                                }
                                StrWhere = StrWhere + rsInfo.getString("NameF") +"=" + request.getParameter(rsInfo.getString("NameF"));
                            }
                        }
                        else{
                            if(rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si") && rsInfo.getString("Identit").equalsIgnoreCase("No")){
                                out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                                out.close();
                                return;
                            }
                        }
                    }
                    //out.println(StrSentence + " " + StrFields + " " + StrWhere);
                    if(StrWhere.equalsIgnoreCase("")){
                        out.println("La llave primaria no debe quedar en blanco, verifique con su administrador");
                        out.close();
                        return;
                    }
                    StrSentence = StrSentence + " " + StrFields + " " + StrWhere;
                }

                if (Integer.parseInt(request.getParameter("Action"))==3){
                    StrSentence = "Delete from " + rs.getString("Tabla");
                    while(rsInfo.next()){
                        if (request.getParameter(rsInfo.getString("NameF"))!=null){
                            if (rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")){
                                if(strBack.equalsIgnoreCase("")){
                                    strBack=strBack + rsInfo.getString("NameF") +"=" + request.getParameter(rsInfo.getString("NameF"));
                                }else{
                                    strBack=strBack + "&" + rsInfo.getString("NameF") +"=" + request.getParameter(rsInfo.getString("NameF"));
                                }
                                
                                if (StrWhere.equalsIgnoreCase("")){
                                    StrWhere = StrWhere + "Where ";
                                }
                                else{
                                    StrWhere = StrWhere + " and ";
                                }
                                StrWhere = StrWhere + rsInfo.getString("NameF") +"=" + request.getParameter(rsInfo.getString("NameF"));
                            }
                        }
                        else{
                            if(rsInfo.getString("LlavePrimaria").equalsIgnoreCase("Si")){
                                out.println("La llave primaria no debe quedar en blanco, por favor vuelva a intentarlo");
                            }
                        }
                    }
                    if(StrWhere.equalsIgnoreCase("")){
                        out.println("La llave primaria no debe quedar en blanco, verifique con su administrador");
                        out.close();
                        return;
                    }
                    StrSentence = StrSentence + " " + StrWhere;
                }
                
                if ((Integer.parseInt(request.getParameter("Action"))==1)&&(blnBackId==true)){                
                    try{
                        ResultSet rsLlave = UtileriasBDF.rsSQLNP(StrSentence + " Select @@Identity Llave ");
                        if(rsLlave.next()){
                            strBack=strBack + "=" + rsLlave.getString("Llave");
                            rsLlave.close();
                        }
                    }catch(Exception e){
                        out.close();
                        e.printStackTrace();
                    }
                }else{
                   UtileriasBDF.ejecutaSQLNP(StrSentence);                                            
                }
                String strUrlBack="";
                if(request.getParameter("URLBACK")!=null){
                    strUrlBack = request.getParameter("URLBACK");
                    //out.println("<script> //'"+ strUrlBack + strBack +"'</script>");             
                    out.println("<script> window.opener.fnValidaResponse(1,'"+ strUrlBack + strBack +"')</script>");                    
                }
                out.println("</body>");            
                out.println("</html>");            
                rs.close();
                rsInfo.close();
            }else{
                out.println("Problemas al obtener información de la página solicitada");
                out.close();
                return;
            }
                
        }catch(Exception e){
            out.close();
            e.printStackTrace();
        }
        out.close();
        
        
    }
    
    /* Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /* Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /* Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
    
}
