<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" import="java.sql.ResultSet,Utilerias.UtileriasBDF"%>


<html>    
    <body>

    <%
        String StrUsr = "";
        String StrPwd = "";
        String StrMsgValidaSupervisor = "";
        boolean blnAutorizado = false;
        ResultSet rsAut = null;
        String StrclUsrAut = "";
        String StrdsCategoria = "";
        String StrclCategoria = "";
        String StrdsSubCategoria = "0";
        ResultSet rs = null;

        if (request.getParameter("Usr")!=null){
            StrUsr = request.getParameter("Usr").toString();
        }
        
        if (request.getParameter("Pwd")!=null){
            StrPwd = request.getParameter("Pwd").toString();
            System.out.println("PAss "+StrPwd);
        }
        
       if (request.getParameter("MsgValidaSupervisor")!=null){
            StrMsgValidaSupervisor = request.getParameter("MsgValidaSupervisor").toString();
        }
        
        if (request.getParameter("dsCategoria")!=null){
            StrdsCategoria = request.getParameter("dsCategoria").toString();
        }
        
         if(request.getParameter("clCategoria") != null){
            StrclCategoria = request.getParameter("clCategoria");
        }
        
        if(request.getParameter("dsSubCategoria") != null){
            StrdsSubCategoria= request.getParameter("dsSubCategoria").toString();
        }

        try{
            if (StrUsr.compareToIgnoreCase("")==0){
                blnAutorizado = false;
                StrMsgValidaSupervisor = StrMsgValidaSupervisor +  "Debe informar usuario...";                            
            }
            else{
                if (StrPwd.compareToIgnoreCase("")==0){
                    blnAutorizado = false;
                    StrMsgValidaSupervisor = StrMsgValidaSupervisor +  "Debe informar contraseña...";    
                }
                else{
                    rsAut = UtileriasBDF.rsSQLNP("sp_EncriptDesEncriptPassword '" + StrUsr + "',0,'', 0");  

                    if (rsAut.next()){
                        if (StrPwd.compareToIgnoreCase(rsAut.getString("password"))==0){
                             if (rsAut.getString("AutorizaExp").compareToIgnoreCase("0")==0){
                                    blnAutorizado = false;
                                    StrMsgValidaSupervisor = StrMsgValidaSupervisor +  "Usuario no autorizado...";   
                             }
                             else{
                                 blnAutorizado = true;
                                 StrclUsrAut = rsAut.getString("clUsrApp");
                             } 
                        }
                        else{
                             blnAutorizado = false;
                             StrMsgValidaSupervisor = StrMsgValidaSupervisor +  "Contraseña Incorrecta...";   
                        }
                    }
                    else{
                         blnAutorizado = false;
                         StrMsgValidaSupervisor = StrMsgValidaSupervisor +  "Usuario Incorrecto...";    
                    }
                }
                
            }
        }

        catch(Exception e){
            e.printStackTrace();
        }
        
         if (StrdsCategoria.equalsIgnoreCase("") || StrdsSubCategoria.equalsIgnoreCase("")){
              %><script> alert('Debe informar Categoria y/o SubCategoria');location.href='CSSubcategoria.jsp?clCategoria=<%=StrclCategoria%>&dsCategoria=<%=StrdsCategoria%>&dsSubCategoria=<%=StrdsSubCategoria%>&Usr=<%=StrUsr%>';</script><%
         }
         else{
            if (blnAutorizado==false){
                    %><script> alert('<%=StrMsgValidaSupervisor%>');location.href='CSSubcategoria.jsp?clCategoria=<%=StrclCategoria%>&dsCategoria=<%=StrdsCategoria%>&dsSubCategoria=<%=StrdsSubCategoria%>&Usr=<%=StrUsr%>';</script><%
            }else{
                System.out.println(" st_GuardaCSNuevaSubCategoria '"+StrclCategoria+"','"+StrdsSubCategoria+"','"+StrclUsrAut+"'");
                rs = UtileriasBDF.rsSQLNP(" st_GuardaCSNuevaSubCategoria '"+StrclCategoria+"','"+StrdsSubCategoria+"','"+StrclUsrAut+"'");
                if(rs.next()){
                    if(rs.getString("Error").equalsIgnoreCase("0")){
                        %><script>top.opener.fnLlenaDespuesdeGuardar('SubCategoria');</script><%
                    }else{
                        %><script> alert('Error  Consulte a su administrador.');</script><%
                    }
                }
                %><script>window.close();</script><%
            }
         }
            
        StrUsr = null;
        StrPwd = null;
        StrMsgValidaSupervisor = null;
        rsAut = null;
        StrclUsrAut = null;
        StrdsCategoria = null;
        StrclCategoria = null;
        StrdsSubCategoria = null;
        
     %>
        
   

     
    </body>
</html>
