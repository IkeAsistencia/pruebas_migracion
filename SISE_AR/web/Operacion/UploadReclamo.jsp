<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" import="java.io.*,java.sql.ResultSet,org.apache.commons.fileupload.*,java.util.*,org.apache.commons.fileupload.util.Streams,org.apache.commons.fileupload.disk.DiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload,Utilerias.UtileriasBDF,java.lang.Exception;"%>
<html>
    <head>
        <title>Upload File</title>
    </head>
    <body onload="alert(1);">
        <script src='../Utilerias/Util.js' ></script>
        <% System.out.println("LLego a Upload Reclamo !");
            String path = "";
            String fileName = "";
            String TipoFile = "", 
            Obs = "";
            String clReclamo = "";
            String clUsrApp = "";
            String strUrlBack = "";
            int Error = 0;
            
            if (session.getAttribute("clUsrApp") != null) {
                clUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clReclamo") != null) {
                clReclamo = session.getAttribute("clReclamo").toString();
            }

            strUrlBack = "SeguimienitoReclamo.jsp";
/*
            try {
                path = "";

                boolean isMultipart = ServletFileUpload.isMultipartContent(request);
                System.out.println("Upload Files Is multipart=" + isMultipart);
                DiskFileItemFactory factory = new DiskFileItemFactory();
                //<<<<<<<<<<<<< maxima size que sera guardada en memoria >>>>>>>>>>>
                factory.setSizeThreshold(4096);
                //<<<<<<<<< si se excede de la anterior talla, se ira guardando temporalmente, en la sgte direccion >>>>>>>>>>
                factory.setRepository(new File(path));
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = upload.parseRequest(request);

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
                        //<<<<<<<<<<<< Obtener el Numero de Archivo xls >>>>>>>>>>>
                        ResultSet rsEx = UtileriasBDF.rsSQLNP("sp_UploadSegReclamo " + clReclamo.toString());

                        try {
                            if (rsEx.next()) {
                                clUpload = rsEx.getString("clUpload");
                                path = rsEx.getString("Path");
                            }

                            rsEx.close();
                            rsEx = null;
                        } catch (Exception ee) {
                            System.err.println("Catch Excepetion ee=" + ee);
                        }

                        //<<<<<<<<<<<<<<<<< Crear la Carpeta con El expediente >>>>>>>>>>>>>
                        path = path + "/" + clReclamo.toString();

                        File file = new File(path);

                        if (!file.exists()) {
                            file.mkdir();
                        }

                        //<<<<<<<<<<< Se guarda el file enviado en el servidor local >>>>>>>>>>
                        fileName = "Archivo_" + clUpload + TipoFile;
                        item.write(new File(path, fileName));

                        System.out.println("sp_GuardaArchiSegReclamo '" + clReclamo + "','" + path + "','" + fileName + "','" + clUsrApp + "','" + Obs + "'");
                        UtileriasBDF.ejecutaSQLNP("sp_GuardaArchiSegReclamo '" + clReclamo + "','" + path + "','" + fileName + "','" + clUsrApp + "','" + Obs + "'");
                    }
                }

            } catch (Exception e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
                Error = 1;
            }

            if (Error == 0) {
                 System.out.println("Transferencia del Archivo...");

                boolean Proceso = true;

                if (Proceso) {
                    out.println("<script>alert('Archivo Procesado Correctamente...')</script>");
                    out.println("<script>window.opener.fnValidaResponse(1,'" + strUrlBack + "')</script>");
                    out.println("<script>window.close()</script>");

                } else {
                    out.println("<script>alert('No se Proceso el Archivo (Consulte a su administrador)')</script>");
                    out.println("<script>window.opener.fnProcesoUpload(2)</script>");
                    out.println("<script>window.close()</script>");
                }

            } else {
                if (Error == 1) {
                    out.println("<script>alert('Fallo la transferencia de archivo ..')</script>");
                    out.println("<script>window.opener.fnProcesoUpload(2)</script>");
                    out.println("<script>window.close()</script>");
                }

                if (Error == 2) {
                    out.println("<script>alert('Codigo de Acceso Incorrecto ..')</script>");
                    out.println("<script>window.opener.fnProcesoUpload(2)</script>");
                    out.println("<script>window.close()</script>");
                }
            }
*/
            
            
            path = null;
            fileName = null;
            strUrlBack = null;
            TipoFile = null;
            clReclamo = null;
        %>
    </body>
</html>
