<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>ALTA BENEFI</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilServicio.js' ></script>

<%  

    String StrclExpediente = "0";   
    StringBuffer StrSql = new StringBuffer(); 
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
    String StrclDerechoHab = "0";
    String StrclAfiliadoNU = "0";
    String StrclLlamaAltaNU = "0";
    String StrNumActivos = "0";
    String StrAseg ="";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) 
     {
       %>Fuera de Horario<%
         
         return;
     }    

     if (request.getParameter("clAfiliadoNU")!= null)
        {
            StrclAfiliadoNU= request.getParameter("clAfiliadoNU").toString(); 
        }  
        else{
            if (session.getAttribute("clAfiliadoNU")!= null)
            {
                StrclAfiliadoNU= session.getAttribute("clAfiliadoNU").toString(); 
            }  
            else
          { 
            %>Primero Nececita Ingresar Un Usuario<%
            return;
          }
        }
     
         if (request.getParameter("clDerechoHab")!= null)
          {
          StrclDerechoHab= request.getParameter("clDerechoHab").toString(); 
          
          }  
      StrSql.append(" Select coalesce(Nombre,'') as Nombre,clLlamaAltaNU ");
     StrSql.append(" from LlamaAltaNU ");
     StrSql.append(" where clAfiliado =").append(StrclAfiliadoNU);
     ResultSet rsD = UtileriasBDF.rsSQLNP( StrSql.toString());
     StrSql.delete(0,StrSql.length());
     if (rsD.next())
     {
     StrAseg=rsD.getString("Nombre");
             StrclLlamaAltaNU = rsD.getString("clLlamaAltaNU");
         session.setAttribute("clLlamaAltaNU",StrclLlamaAltaNU);
     }
    %><script>fnOpenLinks()</script><%
    
     StrSql.append(" Select count(*) 'Activos'");
     StrSql.append(" from cDerechoHab ");
     StrSql.append(" where clAfiliado =").append(StrclAfiliadoNU).append(" and Activo=1");
     ResultSet rsE = UtileriasBDF.rsSQLNP( StrSql.toString());
     StrSql.delete(0,StrSql.length());
     if (rsE.next())
     {
     StrNumActivos=rsE.getString("Activos");
       
     }
        
     StrSql.append(" Select clDerechoHab,clAfiliado,coalesce(DerechoHab,'') as DerechoHab, coalesce(Parentesco,'') as Parentesco, coalesce (Sexo,'0') as Sexo,coalesce (Activo,'0') as Activo ");
     StrSql.append(" from cDerechoHab ");
     StrSql.append(" where clDerechoHab =").append(StrclDerechoHab);
     ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
     
    StrclPaginaWeb = "553";       
    MyUtil.InicializaParametrosC(553,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

    %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>

    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>AltaBeneficiario.jsp?'>
    <%
    
    
    if (rs.next()) {  
        
       
        %>
        <INPUT id='clDerechoHab' name='clDerechoHab' type='hidden' value='<%=rs.getString("clDerechoHab")%>'>
        <INPUT id='clAfiliado' name='clAfiliado' type='hidden' value='<%=rs.getString("clAfiliado")%>'>
        <%=MyUtil.ObjInput("Asegurado","NombreVTR",StrAseg,false,false,30,100,StrAseg,false,false,45)%>
        <%=MyUtil.ObjInput("Beneficiario","DerechoHab",rs.getString("DerechoHab"),true,false,30,135,"",true,true,45)%>
        <%=MyUtil.ObjInput("Parentesco","Parentesco",rs.getString("Parentesco"),true,true,300,135,"",true,true,12)%>            
        <%=MyUtil.ObjChkBox("Sexo","Sexo",rs.getString("Sexo"),true,true,460,130,"0","MASCULINO","FEMENINO","")%>
        <%=MyUtil.ObjChkBox("Activo","Activo",rs.getString("Activo"),true,true,570,130,"1","Activo","Inactivo","fnActivos();")%>
        <%=MyUtil.DoBlock("Alta de Beneficiario",0,0)%>
      
    <%
    } 
    else { 
        %>
       <INPUT id='clDerechoHab' name='clDerechoHab' type='hidden' value=''>
        <INPUT id='clAfiliado' name='clAfiliado' type='hidden' value='<%=StrclAfiliadoNU%>'>
  
        <%=MyUtil.ObjInput("Asegurado","NombreVTR",StrAseg,false,false,30,100,StrAseg,false,false,45)%>
        <%=MyUtil.ObjInput("Beneficiario","DerechoHab","",true,false,30,135,"",true,true,45)%>
        <%=MyUtil.ObjInput("Parentesco","Parentesco","",true,true,300,135,"",true,true,25)%>  
        <%=MyUtil.ObjChkBox("Sexo","Sexo","",true,true,460,130,"0","MASCULINO","FEMENINO","")%>
        <%=MyUtil.ObjChkBox("Activo","Activo","",true,true,570,130,"1","Activo","Inactivo","fnActivos();")%>
        <%=MyUtil.DoBlock("Alta de Beneficiario",0,0)%>
       
    
    <%
    }    
    %><%=MyUtil.GeneraScripts()%><%
    rs.close();
    rs=null;
    rsD.close();
    rsD=null;
    rsE.close();
    rsE=null;
    
 %>
 <script>
 function fnActivos(){
    var NumActivos=<%=StrNumActivos%>;
    if ((NumActivos>=10)&&(document.all.ActivoC.checked==true)){
        alert("El Asegurado ya tiene el máximo de Beneficiarios Activos Permitidos");
        document.all.ActivoC.checked=false;
        document.all.Activo.value=0;
        document.all.ActivoLabel.value="Inactivo";
    }
}
</script>
</body>
</html>



