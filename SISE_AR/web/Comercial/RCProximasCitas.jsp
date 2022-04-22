<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,java.sql.DatabaseMetaData,java.sql.ResultSetMetaData" errorPage="" %>
<html>
    <head>              
        <script type="text/javascript">

        </script>	

        <title>Listado de proximas citas</title>
    </head>
    <body >
        <link href="../StyleClasses/Table.css" rel="stylesheet" type="text/css">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilServicio.js'></script>

        <div name='CON' ID='Imp' style='position:absolute; z-index:25; left:700px; top:30px;'>
            <!--<input type='button' value='Corregir' onClick="fnregresar();">-->
            <input type='button' value='Imprimir' onClick="hide('Imp');window.print();show('Imp');">
        </div>
        
        <%
            ResultSet rs = null;
            ResultSet rs1 = null;
            StringBuffer StrSql = new StringBuffer();
            String strValue = null;
            String fecha = null;
            String clReunion = null;
            String clReunionTmp = null;
            String fechaTmp = null;
            String strNomUsrApp = "";
            String strclUsr = null;
            boolean blnRegistro = false;

            if (session.getAttribute("clUsrApp")!= null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            StrSql.append("st_RCListaCitas '','','"+strclUsr+"'");
            rs1 = UtileriasBDF.rsSQLNP("Select Nombre from cUsrApp where clUsrApp="+strclUsr);
            if(rs1.next()){
                strNomUsrApp = rs1.getString("Nombre");
            }
            rs = UtileriasBDF.rsSQLNP(StrSql.toString());

            if(rs.next()){
                ResultSetMetaData rsMetaDato = rs.getMetaData();
                int i;
                out.println("<br><table id='ObjTableTit' class='TableList' border='0' cellpadding='0' cellspacing='0' width='100%'>");
                out.println("<tr class = 'RTitulo'><td colspan='"+(rsMetaDato.getColumnCount()-2)+"' width='25%'><p>Listado de citas: "+ strNomUsrApp
                        +" <br><br>"+rs.getString("Periodo")+"<br>&nbsp;</p></td></tr>");
                out.println("</table>");
                rs.beforeFirst();
                while(rs.next()){
                    clReunion = rs.getString("clReunion");
                    fecha = rs.getString("Fecha");
                    if(!fecha.equalsIgnoreCase(fechaTmp)){
                        if(fechaTmp != null){
                            out.println("</table>");
                        }
                        out.println("<br><table id='ObjTable' class='TableList' border='0' cellpadding='0' cellspacing='0' width='100%'>");
                        out.println("<tr class = 'Fecha'><td colspan='"+rsMetaDato.getColumnCount()+"' width='25%'><b>"+fecha+"</b></td></tr>");
                        out.println("<tr class = 'RTitulos'><td colspan='"+rsMetaDato.getColumnCount()+"' width='25%'></td></tr>");
                        out.println("<tr class = 'RTitulos'>");
                        for ( i=3; i<=rsMetaDato.getColumnCount()-2; i++){
                            out.println("<td>"+rsMetaDato.getColumnLabel(i)+"</td>");
                        }
                        out.println("</tr>");
                        out.println("<tr class = 'R2TableList'><td colspan='"+rsMetaDato.getColumnCount()+"' width='25%'>&nbsp;</td></tr>");
                        blnRegistro = false;
                    }
                    // Checa que si el registro es par o non
                    if (blnRegistro){
                        out.println("<tr class='R1TableList'>");
                        blnRegistro = false;
                    } else {
                        out.println("<tr class='R2TableList'>");
                        blnRegistro = true;
                    }

                    for ( i=3; i<=rsMetaDato.getColumnCount()-2; i++){
                        strValue = rs.getString(i);
                        if(i==3){
                            out.println("<td class='Hora' ' width='10%'>"+strValue+"</td>");
                        }else if(i==4){
                            out.println("<td width='20%'>"+strValue+"</td>");
                        }else if(i==5){
                            out.println("<td width='15%'>"+strValue+"</td>");
                        }else if(i==6){
                            out.println("<td width='15%'>"+strValue+"</td>");
                        }else if(i==7){
                            out.println("<td width='18%'>"+strValue+"</td>");
                        } else{
                            out.println("<td width='20%'>"+strValue+"</td>");
                        }
                        strValue=null;
                    }
                    out.println("</tr>");
                    fechaTmp = fecha;
                    clReunionTmp = clReunion;
                }
            }
            StrSql.delete(0,StrSql.length());
            %>               
            <script>
        function hide(i) {
            if (document.all) {
            var ourhelp = eval ("document.all."+ i)
            ourhelp.style.visibility="hidden";            
            }
            }
            
            function show(i) {
            if (document.all) {
            var ourhelp = eval ("document.all."+ i)
            ourhelp.style.visibility="visible";
            }
            }
        </script>
    </body>
</html>
