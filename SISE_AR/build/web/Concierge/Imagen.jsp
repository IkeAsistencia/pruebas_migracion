<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" import="java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<%
    String StrsrcImg = "", 
           StrWidth="0", 
           StrHeight = "0", 
           StrNota="",
           StrLeft = "0",
           StrTop = "0",
           StrListaImg = "0",
           StrAsignaImg = "0";
    
    if (request.getParameter("srcImg")!= null){
        
        StrsrcImg = request.getParameter("srcImg").toString();
        
        if (!StrsrcImg.equalsIgnoreCase("")){
            StrsrcImg = StrsrcImg.substring(StrsrcImg.indexOf("Imagenes"),StrsrcImg.length());
        }
    }
    
    if (request.getParameter("Width")!= null){
        StrWidth = request.getParameter("Width").toString();
    }
    if (request.getParameter("Height")!= null){
        StrHeight = request.getParameter("Height").toString();
    }
    if (request.getParameter("Nota")!= null){
        StrNota = request.getParameter("Nota").toString();
    }
    
    if (request.getParameter("Top")!= null){
        StrTop = request.getParameter("Top").toString();
    }
    if (request.getParameter("Left")!= null){
        StrLeft = request.getParameter("Left").toString();
    }
    if (request.getParameter("ListaImg")!= null){
        StrListaImg= request.getParameter("ListaImg").toString();
    }
    
    if (request.getParameter("AsignaImg")!= null){
        StrAsignaImg= request.getParameter("AsignaImg").toString();
    }
    
    String StrclReferencia = "0";
      
    if (session.getAttribute("clReferencia")!= null){
        StrclReferencia= session.getAttribute("clReferencia").toString();
    }
      
      ResultSet rsImg = null;
      

%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html">
        <title>JSP Page</title>
           <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
         <script src='../Utilerias/Util.js' ></script>

        <form ACTION="UploadImagen.jsp" name="gestionafichero" id="gestionafichero" enctype="multipart/form-data" METHOD="post">  
            
            <input id="TipoFile" name="TipoFile" type="hidden" value="">
            
            <input id="Width" name="Width" type="hidden" value="<%=StrWidth%>">
            <input id="Height" name="Height" type="hidden" value="<%=StrHeight%>">
            <input id="Nota" name="Nota" type="hidden" value="<%=StrNota%>">
            <input id="Top" name="Top" type="hidden" value="<%=StrTop%>">
            <input id="Left" name="Left" type="hidden" value="<%=StrLeft%>">
            <input id="ListaImg" name="ListaImg" type="hidden" value="<%=StrListaImg%>">
            <input id="AsignaImg" name="AsignaImg" type="hidden" value="<%=StrAsignaImg%>">
            <input id="clReferencia" name="clReferencia" type="hidden" value="<%=StrclReferencia%>">

             <div id="ResBlock1" name="ResBlock1" class='cssBGDet' style='position:absolute; z-index:1; left:0px; top:0px; width:610px; height:100px;'><p class='cssTitDet'>Imagen</p>
                    <%if (!StrNota.equalsIgnoreCase("")){%>
                    <p class='FTable'><b>&nbsp;NOTA:</b> <%=StrNota%></p>
                    <%}%>
                    <p class='FTable'>&nbsp;&nbsp;Seleccionar Imagen<br>
                    &nbsp;&nbsp;<input type="file" name="fichero" class="VTable" size="60" onblur="fnVerificaFile(this);"   >
                    <div  class='VTable' style='position:absolute; z-index:4; left:460px; top:40px;'>
                        <input type="button" value="Subir Imagen" class="cBtn" onclick='fnProcesoFile();'  id="btnUpload">
                    </div>  
             </div>  
            
            <%if (!StrsrcImg.equalsIgnoreCase("")){%>
             <div  class='VTable' size='60'  style='position:absolute; z-index:0; left:0px; top:110px; background-color: #A9D0F5; layer-background-color: #848484; width: 608px; height: 10px;  ' align="center">
                <strong>SI LA IMAGEN SE VE DISTORCIONADA EN EL RECUADRO BLANCO HAY QUE INTENTAR CON OTRA</strong>
            </div>   

            <div id="ResBlock1" name="ResBlock1"  style='position:absolute; z-index:1; left:<%=StrLeft%>; top:<%=StrTop%>px; width:<%=Integer.parseInt(StrWidth)+30%>px; height: <%=Integer.parseInt(StrHeight)+20%>px; background-color: #FFFFFF;' align="center">
                <div id="ResBlock1" name="ResBlock1"  style='position:absolute; z-index:1; left:15px; top:10px;'>
                    <img src="../<%=StrsrcImg%>" width="<%=StrWidth%>" height="<%=StrHeight%>">
                </div>
            </div>

            <%}else {   
                if (StrListaImg.equalsIgnoreCase("0")){%>
             <div  class='VTable' size='60'  style='position:absolute; z-index:0; left:0px; top:110px; background-color: #FDEA7D; layer-background-color: #DB1900; width: 608px; height: 10px;  ' align="center">
                <strong>NO HAY IMAGEN </strong>
            </div>  
                <%}
             } %>
             
             
              <% if (StrListaImg.equalsIgnoreCase("1")){
                  
                  rsImg = UtileriasBDF.rsSQLNP("sp_CSImagenesxRef '"+StrclReferencia+"'");
                  int iCol = 0;
            %>
                <div  class='VTable' size='60'  style='position:absolute;left:0px; top:140px;'>
                <table border="0" bgcolor="#E6F2F9" border="0" >

                 <tr>
                    <% while(rsImg.next()){ iCol = iCol +1;
                    StrsrcImg = rsImg.getString("RutaArchivo")+rsImg.getString("NombreArchivo");
                    StrsrcImg = StrsrcImg.substring(StrsrcImg.indexOf("Imagenes"),StrsrcImg.length());
                    
                    if (iCol<7){
                    %><td><%
                    }
                    else {
                        iCol = 1;
                        %></tr><tr><td><%
                        }
                        %>
                        <img src="../<%=StrsrcImg%>"><center>
                            <%if (StrAsignaImg.equalsIgnoreCase("1")){%>                            
                                 <input type="radio" value="1" name="AsignaImg" onclick="fnAsignaImg('<%=rsImg.getString("clImagen")%>');">
                            <%}%>
                        </center>
                        </td> 
                    <% 
                    }%>
                    </tr>
                </table>
            </div>
              <%rsImg.close(); rsImg = null; } %>
             
             
        <%
           StrsrcImg = null;
           StrWidth= null; 
           StrHeight = null; 
           StrNota=null;
           StrLeft = null;
           StrTop = null;
           StrListaImg = null;
           StrAsignaImg = null;
        %>      
        </form>
    </body>
    
        <script>
      
         function fnCloseAsigImg(){
                    parent.fnCloseImg();
         }
         
        function fnAsignaImg(clImagen){
             if (confirm ("¿DESEA ASIGNAR LA IMAGEN?") == true) {
                window.open('../Operacion/Concierge/CSAsignaImgxRef.jsp?clReferencia='+document.all.clReferencia.value+'&clImagen='+clImagen,'','scrollbars=no,status=yes,width=10,height=10');
            }
        }    
        function fnProcesoFile(){
        
            var MSG = "Falta informar: ";
            
             if (document.all.fichero.value==''){
                MSG = MSG + "Imagen. ";
            }
            
            if (MSG!='Falta informar: '){
                alert(MSG);
            }
            else{
                //fnProcesoUpload(1);
                fnOpenWindow();
                document.all.gestionafichero.target="WinSave";
                document.all.gestionafichero.submit();
            }
        }
        
         function fnVerificaFile (file){

            if(file.value!="")  { 
                fail=file.value.substring(file.value.length-4) 
                    if(fail==".jpg" || fail==".JPG" || fail==".gif" || fail==".GIF"  || fail==".png" || fail==".PNG"  )  { 
                        document.all.TipoFile.value=fail;
                        return true;
                        
                    } 
                    else  { 
                        alert("Sólo puedes elegir los archivos:  JPG, GIF o PNG") 
                        file.focus() 
                        return false ;
                    } 
            } 
        }
        </script>
    
</html>
