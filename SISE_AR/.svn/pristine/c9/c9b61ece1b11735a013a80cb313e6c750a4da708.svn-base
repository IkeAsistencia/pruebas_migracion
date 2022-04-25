<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" import="java.io.*,java.sql.ResultSet,org.apache.commons.fileupload.*,java.util.*,org.apache.commons.fileupload.util.Streams,org.apache.commons.fileupload.disk.DiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload,Utilerias.UtileriasBDF,java.lang.Exception;"%>


<html>
    <head>
        <title>Upload File</title>
    </head>
    <body>
        <script src='../Utilerias/Util.js' ></script>
        <%
            String path = "";
            String pathTC = "";
            String fileName = "";
            String CodigoAccesoUsr = "";
            String TipoFile = "", Obs = "";
            String Solicitud = "";

            //<<<<<<<<<<<<  Obtener el usuario que Restra >>>>>>>>>>>
            String clUsrApp = "";

            if (session.getAttribute("clUsrApp") != null) {
                clUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clSolicitud") != null) {
                Solicitud = session.getAttribute("clSolicitud").toString();
            }

            String strUrlBack = "";
            strUrlBack = "DetalleSolicitudSP.jsp";

            int Error = 0;

            try {
                //<<<<<<<<<<<<<<<<<<<<<<< Path  >>>>>>>>>>>>>>>>>>>
                path = "";
                pathTC = "";

                //<<<<<<<< Verificar si el request multipart (que se este enviando un file) >>>>>>
                boolean isMultipart = ServletFileUpload.isMultipartContent(request);

                System.out.println("Upload Files Is multipart = " + isMultipart);

                DiskFileItemFactory factory = new DiskFileItemFactory();

                //<<<<<<<<<<<<< maxima size que sera guardada en memoria >>>>>>>>>><
                factory.setSizeThreshold(4000000);

                //<<<<<<<<< si se excede de la anterior talla, se ira guardando temporalmente, en la sgte direccion >>>>>>>>>>
                factory.setRepository(new File(path));
                
                //<<<<<<<<<<<<<<
                ServletFileUpload upload = new ServletFileUpload(factory);

                List /* FileItem */ items = upload.parseRequest(request);

                Iterator iter = items.iterator();
                String clUpload = "";

                while (iter.hasNext()) {

                    FileItem item = (FileItem) iter.next();

                    if (item.isFormField()) {
                        String name = item.getFieldName();
                        String value = item.getString();

                        //<<<<<<<< Tipo de Archivo >>>>>>>>
                        if (name.equalsIgnoreCase("TipoFile")) {
                            TipoFile = value.toString();
                        }

                        if (name.equalsIgnoreCase("Obs")) {
                            Obs = value.toString();
                            System.out.println("Obs" + Obs);
                        }

                    } else {
                        // Process a file upload
                        //<<<<<<<<<<<< Obtener el Numero de Archivo xls >>>>>>>>>>>
                        ResultSet rsEx = UtileriasBDF.rsSQLNP("st_SPUploadFileHD " + Solicitud.toString());
                        System.out.println("st_SPUploadFileHD " + Solicitud.toString());

                        try {
                            if (rsEx.next()) {
                                clUpload = rsEx.getString("clUpload");
                                path = rsEx.getString("Path");
                                pathTC = rsEx.getString("PathTC");
                                
                                System.out.println("La ruta de carga es: " + path);
                                System.out.println("La ruta tomcat es: " + pathTC);
                            }

                            rsEx.close();
                            rsEx = null;
                        } catch (Exception ee) {
                            System.err.println("Catch Excepetion ee=" + ee);

                        }

                        //<<<<<<<<<<<<<<<<< Crear la Carpeta con El expediente >>>>>>>>>>>>>
                        path = path + "/" + Solicitud.toString();
                        pathTC = pathTC + "/" + Solicitud.toString();
                        
                        File file = new File(path);

                        if (!file.exists()) {
                            file.mkdir();
                        }

                        //<<<<<<<<<<< Se guarda el file enviado en el servidor local >>>>>>>>>>
                        fileName = "Archivo_" + clUpload + TipoFile;
                        item.write(new File(path, fileName));

                        UtileriasBDF.ejecutaSQLNP("st_GuardaArchivoxHDSP '" + Solicitud + "','" + path + "','" + pathTC + "','" + fileName + "','" + item.getSize() + "','" + clUsrApp + "','" + Obs + "'");
                    }
                }

            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
                Error = 1;
            }

            if (Error == 0) {
                System.out.println("Transferencia del Archivo...");

                boolean Proceso = true;

                if (Proceso) {

                    out.println("<script>alert('Archivo Procesado Correctamente...')</script>");
                    out.println("<script>window.opener.fnRecarga()</script>");
                    out.println("<script>window.close()</script>");

                } else {
                    out.println("<script>alert('No se Proceso el Archivo (Consulte a su administrador)')</script>");
                    //out.println("<script>window.opener.fnProcesoUpload(2)</script>");
                    out.println("<script>window.close()</script>");
                }

            } /*else {
             //out.println("Fallo la transferencia de archivo .."); 
             if (Error == 1) {
             out.println("<script>alert('Fallo la transferencia de archivo ..')</script>");
             //out.println("<script>window.opener.fnProcesoUpload(2)</script>");
             out.println("<script>window.close()</script>");
             }

             if (Error == 2) {
             out.println("<script>alert('Codigo de Acceso Incorrecto ..')</script>");
             // out.println("<script>window.opener.fnProcesoUpload(2)</script>");
             out.println("<script>window.close()</script>");
             }
             }*/

            //<<<<<<<<<<<< Limpiar Variables >>>>>>>>>>>>
            path = null;
            fileName = null;
            strUrlBack = null;
            CodigoAccesoUsr = null;
            TipoFile = null;
            Solicitud = null;

        %>

    </body>
</html>