<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page  import="com.ike.model.DAOTieneAsistencia,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,javax.servlet.http.HttpSession,com.ike.concierge.DAOConciergeZona,com.ike.concierge.to.ConciergeZona;" %>

<html>
    <head>
        <title>ZONA</title>
    </head>
    <body class="cssBody" onload="fnLlenaPais();">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/UtilStore.js'></script>
        <script src='../../Utilerias/Util.js'></script>

              <%
            String strclUsr = "0";
            String strclPais= "0";
            String strclZona ="0";
            

            if (session.getAttribute("clUsrApp")!= null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true)
            {%>Fuera de Horario<%

            strclUsr=null;
            return;}
            
            if (request.getParameter("clPais")!=null){
                  strclPais=request.getParameter("clPais").toString(); 
            }
            
            if (request.getParameter("clZona")!=null){
                  strclZona=request.getParameter("clZona").toString(); 
            }

        DAOConciergeZona daoConciergeZona = null;
        ConciergeZona CZ = null;

            daoConciergeZona = new DAOConciergeZona();
            CZ = daoConciergeZona.getConciergeZona(strclZona.toString());

    String StrclPaginaWeb = "893";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
  <%//servlet generico
        String Store="";

        Store="st_GuardaCSNuevaZona";

        session.setAttribute("sp_Stores",Store);

        String Commit="";
        Commit="clZona";

        session.setAttribute("Commit",Commit);


        %>        
        
        <%MyUtil.InicializaParametrosC(893,Integer.parseInt(strclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP","fnLlenaPais();","fnsp_Guarda();")%>
      
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="CSZona.jsp?'>"%>
        <%  int iY = 40; %>   
        
        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden"  VALUE="dsPais,dsZona">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden">
        
        <input id="clPais" name="clPais" type="hidden" value="">        
        <input id="clZona" name="clZona" type="hidden" value="<%=CZ!=null ? CZ.getclZona():"" %>">
        
        <%=MyUtil.ObjComboC("Pais","dsPais",CZ != null ? CZ.getDsPais():"",true,true,30,80,"","select clPais, dsPais from cPais ","","",20,true,false)%>
        <!--%=MyUtil.ObjComboC("Pais","clPais",strdsPais,true,true,30,220,"115","Select clPais,dsPais from cPais order by dsPais","","",30,false,false)%-->
        <%=MyUtil.ObjInput("Zona","dsZona",CZ != null ? CZ.getDsZona(): "",true,true,260,80,"",false,false,40)%> 
        
        <%=MyUtil.DoBlock("Nueva Zona",40,20)%>                
        
        <%strclZona = null;%> 
        
        <%=MyUtil.GeneraScripts()%> 
                
        <%StrclPaginaWeb=null; %>
        
        
        <%
            if (CZ!=null){
            %><script>
            
                top.opener.fnLlenaDespuesdeGuardar('Zona');
                window.close();
                </script><%
            }
        %>
        
        <script>
            function fnLlenaPais(){
                Pais=<%=strclPais%>;
                if (Pais!=0){
                    document.all.dsPais.value=Pais;
                    document.all.dsPaisC.value=Pais;
                }
            }
        </script>
        
       </body>
</html>