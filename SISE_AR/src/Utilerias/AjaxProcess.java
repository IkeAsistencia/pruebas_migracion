/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilerias;

import Seguridad.SeguridadC;
import Seguridad.ValidaSql;
import static Utilerias.UtileriasBDF.getConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Jesus Moreno velasco
 */
@WebServlet(name = "AjaxProcess", urlPatterns = {"/servlet/Utilerias.AjaxProcess"})
public class AjaxProcess extends HttpServlet {
       protected void processRequest(HttpServletRequest request, HttpServletResponse response)   throws ServletException, IOException {
        HttpSession sessionH = request.getSession(false);
//        response.setContentType("text/html");
        response.setContentType("application/x-www-form-urlencoded");
//        xmlHttpfn.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
//        request.setCharacterEncoding("UTF-8");
        String component="";//string,table,combobox,html
        boolean responsive=false;
        String sql="";//sql a ejecutar
        String param="";//sql a ejecutar
        String strclUsr = "0";
        String executeQuery="";
        String dinamicIDTable="ObjTable";
        try (PrintWriter out = response.getWriter()) {
            if (sessionH.getAttribute("clUsrApp")!= null){
                strclUsr = sessionH.getAttribute("clUsrApp").toString();      
            } 
            if (request.getParameter("param")!= null){
                param = request.getParameter("param");      
            } 
            if (request.getParameter("sql")!= null){
                sql = request.getParameter("sql");      
            }
            if (request.getParameter("component")!= null){
                 component = request.getParameter("component");      
            }
            if (request.getParameter("responsive")!= null){
                 responsive = Boolean.valueOf(request.getParameter("responsive").trim());      
            }
            if (request.getParameter("dinamicIDTable")!= null){
                 dinamicIDTable = request.getParameter("dinamicIDTable").trim();      
            }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true)  {
                out.println("Fuera de Horario");
                strclUsr=null;
                return;
            } 
            executeQuery=createQuery(sql,param);
            if(executeQuery.isEmpty()){
                out.println("QUERY VACIO");
                return;
            }
            StringBuffer result=new StringBuffer();
            switch (component.trim()) {
                case "json":
                    createJson(result,executeQuery);
                    out.println(result.toString());
                    break;
                case "html":
                    out.println("Componente sin implementacion.");
                    break;
                case "combobox":
                    createCombo(result,executeQuery);
                    out.println(result.toString());             
                    break;
                case "table":
                    createTable(result,executeQuery,responsive,dinamicIDTable);
                    out.println(result.toString());   
                    break;
                case "String":
                    createString(result,executeQuery);
                    out.println(result.toString());
                    break;
                default:
                    out.println("Componente sin implementacion.");
                    break;
            }
        }
    }
    private void createString(StringBuffer result,String executeQuery){
        ResultList re=new ResultList();
        try{
            re.rsSQL(executeQuery);
            if(re.next()){
                result.append((re.getString(1)==null)?"":re.getString(1).trim());
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }finally{
            re.close();
            re=null;
        }
    }
      private void createCombo(StringBuffer result,String executeQuery){
        JSONArray array=new JSONArray();
        ResultSet rs = null;
        Connection con = null;
        Statement stmt = null;
         try {
            con = getConnection();
            if(con==null){
                return;
            }
            stmt = con.createStatement(1005, 1007);
            stmt.execute(" SET DATEFORMAT MDY SET NOCOUNT ON ");
            rs = stmt.executeQuery(executeQuery);
            while (rs.next()) {
                JSONObject obj=new JSONObject();
                obj.put("value", (rs.getString(1)==null)?"":rs.getString(1).trim());
                obj.put("text", (rs.getString(2)==null)?"":rs.getString(2).trim());
                array.add(obj);
            }
            result.append(array.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
             try {
                if (stmt != null) {
                    stmt.close();
                    stmt = null;
                }
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception ee) {
                ee.printStackTrace();
        }
         }
        }
     private void createJson(StringBuffer result,String executeQuery){
        
        JSONArray array=new JSONArray();
        ResultSet rs = null;
        Connection con = null;
        Statement stmt = null;
         try {
            con = getConnection();
            if(con==null){
                return;
            }
            stmt = con.createStatement(1005, 1007);
            stmt.execute(" SET DATEFORMAT MDY SET NOCOUNT ON ");
            rs = stmt.executeQuery(executeQuery);
             ResultSetMetaData rsMetaDato = rs.getMetaData();
            while (rs.next()) {
                JSONObject obj=new JSONObject();
                for (int i = 1; i <= rsMetaDato.getColumnCount(); i++) {
                         switch(rsMetaDato.getColumnTypeName(i)){
                                case "int": 
                                    obj.put(rsMetaDato.getColumnLabel(i), rs.getInt(i));
                                    break;
                                case "bit": 
                                    obj.put(rsMetaDato.getColumnLabel(i), rs.getInt(i));
                                    break;
                                case "tinyint": 
                                    obj.put(rsMetaDato.getColumnLabel(i), rs.getInt(i));
                                    break;
                                case "smallint": 
                                    obj.put(rsMetaDato.getColumnLabel(i), rs.getInt(i));
                                    break;
                                case "float": 
                                    obj.put(rsMetaDato.getColumnLabel(i), rs.getFloat(i));
                                    break;
                                default: obj.put(rsMetaDato.getColumnLabel(i), (rs.getString(i)==null)?"":rs.getString(i).trim());
                                     break;
                         }
                    }
                array.add(obj);
            }
            result.append(array.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
             try {
                if (stmt != null) {
                    stmt.close();
                    stmt = null;
                }
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception ee) {
                ee.printStackTrace();
        }
         }
        }
    
    private  void createTable(StringBuffer result,String executeQuery,boolean responsive,String idTable) {
        String strValue = null;
        ResultSet rs = null;
        Connection con = null;
        Statement stmt = null;
        if(responsive){
            result.append("<div class='table-responsive' >");
        }
        try {
            con = getConnection();
            if(con==null){
                return;
            }
            stmt = con.createStatement(1005, 1007);
            stmt.execute(" SET DATEFORMAT MDY SET NOCOUNT ON ");
            rs = stmt.executeQuery(executeQuery);
            if (rs.next()) {
                rs.last();
                result.append("<p  class='RegFound'>Registros Encontrados: <span id='table_count_").append(idTable).append("' >").append(rs.getRow()).append("</span></p>");
                rs.first();
                ResultSetMetaData rsMetaDato = rs.getMetaData();
                
                
                result.append("<table id='").append(idTable).append("' class='table table-sm table-hover table-condensed table-bordered ' >");
                result.append("<tr class = 'TTable'>");
                for (int i = 1; i <= rsMetaDato.getColumnCount(); i++) {
                    String colorClassColumn= rsMetaDato.getColumnLabel(i);
                    if(!colorClassColumn.toLowerCase().contains("color-class")){
                        result.append("<th onClick='fnOrder(this.parentElement.parentElement,").append(String.valueOf(i - 1)).append(")'>").append(colorClassColumn).append("</th>");
                    }
                }
                result.append("</tr>");
                int fila=1;
                do {
                    int ultimo=0;
                    String colorClassColumn= rsMetaDato.getColumnLabel(rsMetaDato.getColumnCount()).toLowerCase();
                    if (colorClassColumn.trim().contains("color-class")) {
                        String colorClass=rs.getObject(rsMetaDato.getColumnCount()).toString();
                        result.append("<tr class='").append(colorClass).append("'>");
                    ultimo=1;
                    }else{
                        if (fila%2==0) {
                            result.append("<tr class=' R1Table '>");
                        } else {
                            result.append("<tr class=' R2Table '>");
                        }
                    }
                    for (int i = 1; i <= rsMetaDato.getColumnCount()-ultimo; i++) {
                        strValue = (rs.getString(i)==null)?"":rs.getString(i);
                        result.append("<td>").append(strValue.trim()).append("</td>");
                        strValue = null;
                    }
                    result.append("</tr>");
                    fila++;
                } while (rs.next());
            }else{
//                result.append("<table id='").append(idTable).append("' class='table table-hover table-condensed table-bordered' >");
//                result.append("<tr class='bg-danger text-white'><td>Sin resultados.</td></tr>");
                  result.append("<div style='border: 2px solid; width: 40%; margin: auto;'>");
                  result.append("<div class='modal-header' id='sin_resultado' style='background-color: #000066; color: white; text-align: center;' resul='sin_resultados'>");
                  result.append("<h5 class='modal-title' style='margin: 0;'>Informacion</h5>");
                  result.append("</div>");
                  result.append("<div class='modal-body' style='text-align: center;padding: 10px;'>");
                  result.append("<p>No se encontro ningun resultado, intentelo nuevamente.</p>");
                  result.append("</div>");
                  result.append("</div>");
            }
        } catch (Exception e) {
            System.out.println("SISE CO AjaxProcess QUERY="  + executeQuery);
            result.append("<table id='").append(idTable).append("' class='table table-hover table-condensed table-bordered' error='true'>");
            result.append("<tr class='bg-danger text-white'><td>Sin resultados.</td></tr>");
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                    stmt = null;
                }
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        result.append("</table >");
         if(responsive){
            result.append("</div >");
        }
    }
    
    private String createQuery(String sql,String param){
        try {
            param = java.net.URLDecoder.decode(param, StandardCharsets.ISO_8859_1.name());
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(ValidaSql.class.getName()).log(Level.SEVERE, null, ex);
        }
        sql=ValidaSql.limpiaSql(sql.trim());
        param=param.trim();
        String executeQuery="";
        if (!sql.isEmpty()){
            executeQuery=sql;
            if(!param.isEmpty()){
                String temResultParma="";
                String [] temParam=param.split("\\|");
                for (int i = 0; i < temParam.length; i++) {
                    temResultParma=temResultParma+"'"+ValidaSql.limpiaSql(temParam[i].trim())+"',";
                }
                if(temParam.length>0){
                    temResultParma=temResultParma.substring(0,temResultParma.length()-1);
                }
                 executeQuery= executeQuery+" "+temResultParma;
            }
        }
        return executeQuery;
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que gestiona peticiones asincronas.";
    }// </editor-fold>

}
