<%@page contentType="text/html"%>
<%@ page import="java.io.*"%>
<%@ page import="java.awt.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="javax.imageio.ImageIO"%>

<%@ page import="java.sql.ResultSet"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.util.Streams"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="Utilerias.UtileriasBDF"%>

<%@page pageEncoding="ISO-8859-1"%>

<html>
    <head>
        <title>Upload Imagen</title>
    </head>
    <body>

   <%
        String StrPath = "";
        String StrNombreImagen = "";
        String StrNombreImagenTmp = "";
        String StrTipoImagen = "";
        String StrTipoFile = "";
        String StrclCuenta = "";
        String StrclReferencia = "0";
        String StrParametrosURL = "";
        
        int iWidthImg = 0, iHeightImg = 0;
        
       //<<<<<<<<<<<<  Obtener el usuario que Restra >>>>>>>>>>>
        String clUsrApp = "";

        
        if (session.getAttribute("clUsrApp")!=null){
            clUsrApp = session.getAttribute( "clUsrApp" ).toString();
        }
        
       if (session.getAttribute("clCuenta")!=null){
            StrclCuenta = session.getAttribute("clCuenta").toString();
        }
        
        
        if ( session.getAttribute( "TipoImagen" ) != null ){
            StrTipoImagen = session.getAttribute( "TipoImagen" ).toString();  
        }
        
        if (session.getAttribute("clReferencia")!=null){
            StrclReferencia = session.getAttribute("clReferencia").toString();
        }
        

            
       String strUrlBack="";
       strUrlBack ="Imagen.jsp?srcImg=";
        
            
         int Error=0;     
       
            
        try {   
            //<<<<<<<<<<<<<<<<<<<<<<< StrPath  >>>>>>>>>>>>>>>>>>>
            StrPath="";
            
            //<<<<<<<< Verificar si el request multipart (que se este enviando un file) >>>>>>
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            System.out.println("Upload Files Is multipart="+isMultipart);

            DiskFileItemFactory factory = new DiskFileItemFactory();
   
            //<<<<<<<<<<<<< maxima size que sera guardada en memoria >>>>>>>>>><
            factory.setSizeThreshold(4096);
            
            //<<<<<<<<< si se excede de la anterior talla, se ira guardando temporalmente, en la sgte direccion >>>>>>>>>>
            factory.setRepository(new File(StrPath));
            
            //<<<<<<<<<<<<<<
            ServletFileUpload upload = new ServletFileUpload(factory);
            
            List  items = upload.parseRequest(request);
 
            Iterator iter = items.iterator();
            String StrclImagen="";

            while (iter.hasNext()) {
                
                FileItem item = (FileItem) iter.next();
                
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    String value = item.getString();

                    //<<<<<<<< Tipo de Archivo >>>>>>>>
                    if (name.equalsIgnoreCase("TipoFile")){
                        StrTipoFile = value.toString();
                    }
                              
                    
                    if (name.equalsIgnoreCase("Width")){
                        StrParametrosURL = StrParametrosURL +"&Width="+ value.toString();
                    }  
                    if (name.equalsIgnoreCase("Height")){
                        StrParametrosURL = StrParametrosURL +"&Height="+ value.toString();
                    }  
                    if (name.equalsIgnoreCase("Nota")){
                        StrParametrosURL = StrParametrosURL +"&Nota="+ value.toString();
                    }  
                    if (name.equalsIgnoreCase("Top")){
                        StrParametrosURL = StrParametrosURL +"&Top="+ value.toString();
                    }  
                    if (name.equalsIgnoreCase("Left")){
                        StrParametrosURL = StrParametrosURL +"&Left="+ value.toString();
                    }   
                    if (name.equalsIgnoreCase("ListaImg")){
                        StrParametrosURL = StrParametrosURL +"&ListaImg="+ value.toString();
                    }   
                    
                    if (name.equalsIgnoreCase("AsignaImg")){
                        StrParametrosURL = StrParametrosURL +"&AsignaImg="+ value.toString();
                    } 
                    
                }
                
                else {
                     // Process a file upload
                    System.out.println("sp_CSUploadImagen '"+StrTipoImagen+"','"+StrclCuenta+"','"+StrclReferencia+"'");
                    ResultSet rsImg=UtileriasBDF.rsSQLNP("sp_CSUploadImagen '"+StrTipoImagen+"','"+StrclCuenta+"','"+StrclReferencia+"'");

                    try {
                        if (rsImg.next()){
                            StrclImagen=rsImg.getString("clImagen");
                            StrPath=rsImg.getString("Path");
                            StrNombreImagen = rsImg.getString("NombreImagen");
                            StrNombreImagenTmp = rsImg.getString("NombreImagenTmp");
                            iWidthImg = Integer.parseInt(rsImg.getString("Width"));
                            iHeightImg = Integer.parseInt(rsImg.getString("Height"));
                        }   
                        
                        rsImg.close();
                        rsImg = null;
                    }
                    catch(Exception ee){
                        System.err.println("Catch Excepetion ee="+ee); 
                        
                    }
                   

                    //<<<<<<<<<<<<<<<<< Crear la Carpeta  >>>>>>>>>>>>>
                    File file = new File(StrPath);                    

                    if (!file.exists()){
                        file.mkdir();
                    }
            
                    
                    if (iWidthImg!=0 && iHeightImg!=0){
                    
                        StrNombreImagenTmp=StrNombreImagenTmp+StrTipoFile;
                        item.write(new File(StrPath, StrNombreImagenTmp));
                        
                        
                        //<<<<<<<<<<<<<<< Verificar el Tamaño de la Imagen >>>>>>>>>>>>>>
                        

                        StrNombreImagen = StrNombreImagen +StrTipoFile;
                        //<<<<<<<<<<<<<<< Ajustar la Imagen Cargada a un Tamaño especifico >>>>>>>>>>>>>>>>
                        Color background = new Color(255,255,255);
                        BufferedImage cpimg =new BufferedImage(iWidthImg,iHeightImg,BufferedImage.TYPE_3BYTE_BGR);

                        Graphics g = cpimg.createGraphics();
                        BufferedImage img2 = null;
                        int posx=0, posy=0;
                        img2 = ImageIO.read(new File(StrPath+StrNombreImagenTmp));

                        int img2w=0, img2h = 0;
                        img2w = img2.getWidth(null);
                        img2h = img2.getHeight(null);

                        g.fillRect(posx, posy, iWidthImg, iHeightImg);
                        g.drawImage(img2, posx, posy,iWidthImg,iHeightImg,null);
                        //g.drawImage(img2, (iWidthImg/2) -(img2w/2), (iHeightImg/2)-(img2h/2), (iHeightImg/2)+(img2h/2), (iWidthImg/2) + (img2w/2), 0,0, iWidthImg, iHeightImg, null);
                        g.setColor(background);

                        File file2 = new File(StrPath+StrNombreImagen);
                        try {
                            ImageIO.write(cpimg,StrTipoFile.substring(1,StrTipoFile.length()),file2);
                        } catch(IOException e) {
                            System.out.println("Write error for " + file2.getPath() +": " + e.getMessage());
                        }
                        
                        File file3 = new File(StrPath+StrNombreImagenTmp);        
                        
                        if (file3.exists()){
                            file3.delete();
                            System.out.println("Se elimina el archivo tmp: "+StrPath+StrNombreImagenTmp);
                            
                        }
                        
                       
                        
                        System.out.println("sp_CSGuardaUploadImagen '"+StrTipoImagen+"','"+StrclCuenta+"','"+StrclReferencia+"','"+StrPath+"','"+StrNombreImagen+"','"+file2.length()+"','"+clUsrApp+"',1");
                        UtileriasBDF.ejecutaSQLNP("sp_CSGuardaUploadImagen '"+StrTipoImagen+"','"+StrclCuenta+"','"+StrclReferencia+"','"+StrPath+"','"+StrNombreImagen+"','"+file2.length()+"','"+clUsrApp+"',1");
                        
                        file2 = null;
                        file3 = null;
            
                    }
                    else{
                         StrNombreImagen = StrNombreImagen +StrTipoFile;
                         item.write(new File(StrPath, StrNombreImagen));
                         file = null;
                         
                         System.out.println("sp_CSGuardaUploadImagen '"+StrTipoImagen+"','"+StrclCuenta+"','"+StrclReferencia+"','"+StrPath+"','"+StrNombreImagen+"','"+item.getSize()+"','"+clUsrApp+"',1");
                         UtileriasBDF.ejecutaSQLNP("sp_CSGuardaUploadImagen '"+StrTipoImagen+"','"+StrclCuenta+"','"+StrclReferencia+"','"+StrPath+"','"+StrNombreImagen+"','"+item.getSize()+"','"+clUsrApp+"',1");
                    }
                                         
                    strUrlBack = strUrlBack + StrPath + StrNombreImagen+StrParametrosURL;
                    System.out.println(strUrlBack);
                }   
            }
            
        } catch(Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            Error = 1;
        }

        
         if(Error==0){
            //System.out.println("Transferencia del Archivo...");
     
            boolean Proceso=true;
            
              if (Proceso){
                    //out.println("<script>window.opener.fnValidaResponse(1,'"+ strUrlBack +"')</script>");
                    out.println("<script>alert('Archivo Procesado Correctamente...')</script>");
                    out.println("<script>window.opener.fnValidaResponse(1,'"+ strUrlBack +"')</script>");
                        
                }
                else{
                    out.println("<script>alert('No se Proceso el Archivo (Consulte a su administrador)')</script>");    
                    out.println("<script>window.opener.fnProcesoUpload(2)</script>");
                    out.println("<script>window.close()</script>");
                }
            
        } else{
            //out.println("Fallo la transferencia de archivo .."); 
            if (Error==1){
                out.println("<script>alert('Fallo la transferencia de archivo ..')</script>"); 
                out.println("<script>window.opener.fnProcesoUpload(2)</script>");
                out.println("<script>window.close()</script>");
            }
              
            if (Error==2){
                 out.println("<script>alert('Codigo de Acceso Incorrecto ..')</script>"); 
                 out.println("<script>window.opener.fnProcesoUpload(2)</script>");
                 out.println("<script>window.close()</script>");
            }
        }
        
            
        //<<<<<<<<<<<< Limpiar Variables >>>>>>>>>>>>
        StrPath=null;
        StrNombreImagen=null;
        StrNombreImagenTmp=null;
        StrTipoImagen = null;
        strUrlBack=null;
        StrTipoFile = null;
        
        StrclCuenta = null;
        StrclReferencia = null;
        StrParametrosURL = null;
        
    %>
    
    </body>
</html>
