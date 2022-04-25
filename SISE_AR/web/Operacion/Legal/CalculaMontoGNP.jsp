<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.Connection,java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%  
String StrMontoDanoExterno="0";
String StrPorcEt1="1";
String StrPorcEt2="1";
String StrPorcEt3="1";
String StrPorcEt4="1";
String StrFechaCobroET1="0";
String StrFechaCobroET2="0";
String StrFechaCobroET3="0";
String StrFechaCobroET4="0";
String StrFechaCobroAmp="0";
String StrFechaCobroBand="0";


      if (request.getParameter("MontoDanoExterno")!= null)
        {
            StrMontoDanoExterno= request.getParameter("MontoDanoExterno").toString(); 
        }  
      if (request.getParameter("PorcEt1")!= null)
        {
            StrPorcEt1= request.getParameter("PorcEt1").toString(); 
        }  
      if (request.getParameter("PorcEt2")!= null)
        {
            StrPorcEt2= request.getParameter("PorcEt2").toString(); 
        }  
      if (request.getParameter("PorcEt3")!= null)
        {
            StrPorcEt3= request.getParameter("PorcEt3").toString(); 
        }  
      if (request.getParameter("PorcEt4")!= null)
        {
            StrPorcEt4= request.getParameter("PorcEt4").toString(); 
        }  
      if (request.getParameter("FechaCobroET1")!= null)
        {
            StrFechaCobroET1= request.getParameter("FechaCobroET1").toString(); 
        }  
      if (request.getParameter("FechaCobroET2")!= null)
        {
            StrFechaCobroET2= request.getParameter("FechaCobroET2").toString(); 
        }  
      if (request.getParameter("FechaCobroET3")!= null)
        {
            StrFechaCobroET3= request.getParameter("FechaCobroET3").toString(); 
        }  
      if (request.getParameter("FechaCobroET4")!= null)
        {
            StrFechaCobroET4= request.getParameter("FechaCobroET4").toString(); 
        }  
      if (request.getParameter("FechaCobroAmp")!= null)
        {
            StrFechaCobroAmp= request.getParameter("FechaCobroAmp").toString(); 
        }  
      if (request.getParameter("FechaCobroBand")!= null)
        {
            StrFechaCobroBand= request.getParameter("FechaCobroBand").toString(); 
        }  

      
    
        StringBuffer strSql= new StringBuffer();
        strSql.append("sp_CalculoCobroGeneradoGNP '").append(StrMontoDanoExterno).append("','").append(StrFechaCobroET1).append("','");
        strSql.append(StrFechaCobroET2).append("','").append(StrFechaCobroET3).append("','").append(StrFechaCobroET4).append("','");
        strSql.append(StrPorcEt1).append("','").append(StrPorcEt2).append("','").append(StrPorcEt3).append("','");
        strSql.append(StrPorcEt4).append("','").append(StrFechaCobroAmp).append("','").append(StrFechaCobroBand).append("'");
        
        ResultSet rs = UtileriasBDF.rsSQLNP(strSql.toString());
        strSql.delete(0,strSql.length());
        
       
                if (rs.next()){
        
                String StrMontoEtapa1=rs.getString("MontoEtapa1");
                String StrMontoEtapa2=rs.getString("MontoEtapa2");
                String StrMontoEtapa3=rs.getString("MontoEtapa3");
                String StrMontoEtapa4=rs.getString("MontoEtapa4");
                String StrMontoAmparo=rs.getString("MontoAmparo");
                String StrMontoBanderazo=rs.getString("MontoBanderazo");
                String StrTotal=rs.getString("Total");
            %>
            <script>top.opener.fnActualizaMontos('<%=StrMontoEtapa1%>','<%=StrMontoEtapa2%>','<%=StrMontoEtapa3%>','<%=StrMontoEtapa4%>','<%=StrMontoAmparo%>','<%=StrMontoBanderazo%>','<%=StrTotal%>')</script>
            <script>window.close();</script>
             <%}else{%>
            Error al Calcular los Montos
        <%}
        
        rs.close();
        rs=null;
        
%>
</body>
</html>