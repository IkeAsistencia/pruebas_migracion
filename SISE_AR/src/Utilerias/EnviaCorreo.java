package Utilerias;

import javax.mail.*;
import javax.mail.Address;
import javax.mail.internet.*;
import javax.activation.*;
import java.util.StringTokenizer;
import java.util.Properties;
import java.util.ArrayList;
import java.util.Date;
import java.io.*;
//import java.sql.ResultSet;

public class EnviaCorreo {

    private static Transport bus = null;
    private static StringTokenizer st;
    private static boolean isStarted = false;
    //private static ResultSet rs1 = null;
    //private static ResultSet rs = null;
    //private static ResultSet rs2 = null;

    public EnviaCorreo() {
    }

    public static boolean getEstatus() {
        return isStarted;
    }

    public static synchronized void EnviaCorreos() {
        String from = "";
        String destinatarios = "";
        String StrNecAut = "0";
        String smtpHost = "";
        String smtpPort = "";
        String smtpProtocol = "";
        String smtpStartTLS = "";
        String rMail = "";
        String Archivo = "";
        String Imagen = "";
        String figura = "";
        String Adjunto = "";
        String ArchivoAdjStr = "";
        String clMensajeStr = "";
        ResultList rs = null;
        boolean bParseAddress = false;
        try {
            rs = new ResultList();
            rs.rsSQL("sp_GetHostMail");
            if (rs.next()) {
                smtpHost = rs.getString("Host");
                smtpPort = rs.getString("Puerto");
                smtpProtocol = rs.getString("Protocolo");
                StrNecAut = rs.getString("NecAut");
                smtpStartTLS = rs.getString("StartTLS");
            }
            rs.close();
            rs = null;

            rs = new ResultList();
            rs.rsSQL("st_getMensajesMail");

            while (rs.next()) {
                // Obtener el from y los destinatarios recibidos como parámetros
                destinatarios = rs.getString("Destinatario").toString().trim();
                from = rs.getString("Correo").toString().trim();
                // Obtener las propiedades del sistema y establecer el servidor
                // SMTP que vamos a usar
                System.out.println("smtpHost=" + smtpHost);
                System.out.println("smtpPort=" + smtpPort);
                System.out.println("smtpProtocol=" + smtpProtocol);
                System.out.println("StrNecAut=" + StrNecAut);
                System.out.println("smtpStartTLS=" + smtpStartTLS);

                Properties props = System.getProperties();
                props.put("mail.smtp.host", smtpHost);
                props.put("mail.smtp.port", smtpPort);
                props.put("mail.transport.protocol", smtpProtocol);
                Session sesion = null;
                if (StrNecAut.equalsIgnoreCase("1")) {
                    //--------- Mod2: Autenticación ---------------------
                    props.put("mail.smtp.auth", "true");
                    if (smtpStartTLS.equalsIgnoreCase("1")) {
                        props.put("mail.smtp.starttls.enable", "true");
                    }
                    Authenticator auth = new Autenticador();
                    sesion = Session.getDefaultInstance(props, auth);
                } else {//--------- Mod2:Sin Autenticación ---------------------
                    sesion = Session.getDefaultInstance(props, null);
                    //---------------------------------------------------
                }
                Message mensaje = new MimeMessage(sesion);
                // Rellenar los atributos y el contenido
                // Asunto
                mensaje.setSubject(rs.getString("Asunto").toString());
                // Emisor del mensaje
                mensaje.setFrom(new InternetAddress(from));
                //--------------------- Mod: Prepara los recipientes para el envio de correo ---
                //Separo con "|" los distintos destinatarios (luego pueden ser principal, Bcc o cc).
                st = new StringTokenizer(destinatarios, "|");
                ArrayList recipientes = new ArrayList();
                ArrayList Destinatarios = new ArrayList();
                
                while (st.hasMoreTokens()) {
                    rMail = st.nextToken();
                    recipientes.add(rMail.trim());
                }
                
                for (int i = 0; i < recipientes.size(); i++) {
                    //Separo con "," el destinatario principal, el BCC y el CC.
                    st = new StringTokenizer(recipientes.get(i).toString(), ",");
                    while (st.hasMoreTokens()) {
                        String addr = st.nextToken().toString();
                        try {
                            Address mail = new InternetAddress(addr);
                            Destinatarios.add(mail);
                            if (i == 0) { // TO
                                mensaje.addRecipients(Message.RecipientType.TO, obtenerListaDeDirecciones(mensaje, Destinatarios));
                            } else if (i == 1) { // BCC Con Copia Oculta
                                mensaje.addRecipients(Message.RecipientType.BCC, obtenerListaDeDirecciones(mensaje, Destinatarios));
                            } else if (i == 2) { // CC  Con Copia
                                mensaje.addRecipients(Message.RecipientType.CC, obtenerListaDeDirecciones(mensaje, Destinatarios));
                            }
                            bParseAddress = true;
                        }
                        catch (Exception e ) {
                            System.out.println("Error en destinatario:" + addr + e.toString());
                            bParseAddress = false;
                        }
                    }
                }
                //------------------------------------------------------------------------------
                // Crear un Multipart de tipo multipart/related
                Multipart multipart = new MimeMultipart("related");
                // Rellenar el MimeBodyPart con el fichero e indicar que es un fichero HTML
                BodyPart texto = new MimeBodyPart();
                texto.setContent(rs.getString("Cuerpo").toString(), "text/html");
                multipart.addBodyPart(texto);
                //------------------------ Mod: Adjunta imagenes en el correo (Embebidas) ------
                Archivo = rs.getString("Archivo").toString().trim();
                if (Archivo.indexOf("/") != -1 || Archivo.indexOf("\\") != -1) {
                    st = new StringTokenizer(Archivo, "|");
                    ArrayList Imagenes = new ArrayList();
                    while (st.hasMoreTokens()) {
                        Imagen = st.nextToken();
                        Imagenes.add(Imagen);
                    }
                    MimeBodyPart imagen[] = new MimeBodyPart[Imagenes.size()];
                    DataSource fds[] = new DataSource[Imagenes.size()];
                    for (int i = 0; i < Imagenes.size(); i++) {
                        imagen[i] = new MimeBodyPart();
                        fds[i] = new FileDataSource(Imagenes.get(i).toString());
                        imagen[i].setDataHandler(new DataHandler(fds[i]));
                        figura = "<figura" + (i + 1) + ">";
                        imagen[i].setHeader("Content-ID", figura);
                        multipart.addBodyPart(imagen[i]);
                    }
                }
                //------------------ Mod 1: Adjunta Todo tipo de archivos en el correo ---------
                Adjunto = rs.getString("Adjuntos").toString().trim();
                if (Adjunto.indexOf("/") != -1 || Adjunto.indexOf("\\") != -1) {
                    st = new StringTokenizer(Adjunto, "|");
                    ArrayList ArchivosAdjuntos = new ArrayList();
                    while (st.hasMoreTokens()) {
                        ArchivoAdjStr = st.nextToken();
                        ArchivosAdjuntos.add(ArchivoAdjStr);
                    }
                    MimeBodyPart ArchivoAdj[] = new MimeBodyPart[ArchivosAdjuntos.size()];
                    DataSource fds[] = new DataSource[ArchivosAdjuntos.size()];
                    for (int i = 0; i < ArchivosAdjuntos.size(); i++) {
                        ArchivoAdj[i] = new MimeBodyPart();
                        File path = new File(ArchivosAdjuntos.get(i).toString());
                        fds[i] = new FileDataSource(path);
                        ArchivoAdj[i].setDataHandler(new DataHandler(fds[i]));
                        ArchivoAdj[i].setFileName(path.getName());
                        multipart.addBodyPart(ArchivoAdj[i]);
                    }
                }
                //------------------------------------------------------------------------------
                mensaje.setContent(multipart);
                mensaje.setSentDate(new Date());
                clMensajeStr = rs.getString("clMensaje");
                try {
                    if ( bParseAddress ) {
                        Transport.send(mensaje);
                        System.out.println("EnviaCorreo.java: ENVIAR MENSAJE MAIL");
                        EjecutaActualizaMensajesMail.ActualizaEnviado(Integer.valueOf(clMensajeStr), 1);
                        System.out.println("EnviaCorreo.java: ACTUALIZAR MENSAJE EN TABLA COMO ENVIADO OK");
                    }
                    else {
                        System.out.println("EnviaCorreo.java:Error: Error al parsear direcciones" + Integer.valueOf(clMensajeStr) );
                        EjecutaActualizaMensajesMail.ActualizaEnviado(Integer.valueOf(clMensajeStr), 2);
                    }
                      
                } catch (Exception ex) { // USAR -> catch (MessagingException ex) {
                    EjecutaActualizaMensajesMail.ActualizaEnviado(Integer.valueOf(clMensajeStr), 2);
                    System.out.println("EnviaCorreo.java:Error: en Transport.send(mensaje)");
                    ex.printStackTrace();
                }
            }
            System.out.println("Fin del codigo en try antes de catch");
        } catch (Exception e) {
            //e.printStackTrace();
            System.out.println("Error en try principal: " + e);
        } finally {
            try { 
                rs.close();
                rs = null;
                from = null;
                destinatarios = null;
                smtpHost = null;
                rMail = null;
                Archivo = null;
                Imagen = null;
                figura = null;
                Adjunto = null;
                ArchivoAdjStr = null;
                clMensajeStr = null;
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
//------------------------------------------------------------------------------

    public static Address[] obtenerListaDeDirecciones(Message mensaje, ArrayList Destinatarios) throws javax.mail.MessagingException {
        Address address[] = new Address[Destinatarios.size()];
        for (int j = 0; j < Destinatarios.size(); j++) {
            address[j] = (InternetAddress) Destinatarios.get(j);
        }
        Destinatarios.clear();
        return address;
    }
//------------------------------------------------------------------------------

    public static void Start() {
        chStatus(true);
        TimerEnviaCorreo.Start();
    }
//------------------------------------------------------------------------------

    public static void Stop() {
        chStatus(false);
    }
//------------------------------------------------------------------------------

    private static void chStatus(boolean pEstatus) {
        isStarted = pEstatus;
    }
//------------------------------------ Mod2: Autenticación ---------------------

    private static class Autenticador extends Authenticator {

        /*ATENCION MONITOREAR MEMORIA SE AGREGARON 2 RS NUEVOS YA QUE MARCABA ERROR AL INTENTAR REUTILIZAR EL MISMO!!! 20140704 - mramirez*/
        //ResultSet rs = null; 
        public PasswordAuthentication getPasswordAuthentication() {
            String StrUSR = "";
            String StrPWD = "";
            ResultList rs = null;

            //rs2 = UtileriasBDF.rsSQLNP("st_MailAutentification");

            /*try {
             if (rs2.next()) {
             StrUSR = rs2.getString("usr");
             StrPWD = rs2.getString("pwd");
             return new PasswordAuthentication(StrUSR, StrPWD);
             } else {
             return new PasswordAuthentication("", "");
             }
             } catch (Exception ex) {
             ex.printStackTrace();
             return new PasswordAuthentication("", "");
             } finally {
             try {
             rs2.close();
             rs2 = null;
             StrUSR = null;
             StrPWD = null;
             } catch (Exception ex) {
             ex.printStackTrace();
             }
             }*///20141007
            rs = new ResultList();
            rs.rsSQL("st_MailAutentification");

            try {
                if (rs.next()) {
                    StrUSR = rs.getString("usr");
                    StrPWD = rs.getString("pwd");
                    return new PasswordAuthentication(StrUSR, StrPWD);
                } else {
                    return new PasswordAuthentication("", "");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                return new PasswordAuthentication("", "");
            } finally {
                try {
                    rs.close();
                    rs = null;
                    StrUSR = null;
                    StrPWD = null;
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
}
/*
 Se cambia a ResaultList 20141007
 */
