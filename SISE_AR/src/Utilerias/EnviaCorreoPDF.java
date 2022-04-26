/*
 *
 * @author
 * escobarm
 */
package Utilerias;

import com.ike.pdf.PDFCartaBienvenida;
import java.sql.SQLException;
import javax.mail.*;
import javax.mail.Address;
import javax.mail.internet.*;
import javax.activation.*;
import java.util.StringTokenizer;
import java.util.Properties;
import java.util.ArrayList;
import java.util.Date;
import java.sql.ResultSet;
import java.io.*;

public class EnviaCorreoPDF {

    private static ResultSet rs = null;
    private static ResultSet rs1 = null;
    private static ResultSet rs2 = null;
    private static boolean isStarted = false;

    public EnviaCorreoPDF() {
    }

    public static boolean getEstatus() {
        return isStarted;
    }

    public static synchronized void EnviaCorreos() {

        String from = "";
        String destinatarios = "";
        String smtpHost = "";
        String rMail = "";
        String Archivo = "";
        String Imagen = "";
        String figura = "";
        String Adjunto = "";
        String ArchivoAdjStr = "";
        String clMensajeStr = "";
        String PDFOrigen = "";
        String PDFDest = "";
        String StrNecAut = "0";
        String smtpPort = "";
        String smtpProtocol = "";
        String smtpStartTLS = "";

        StringTokenizer st = null;

        try {

            rs1 = UtileriasBDF.rsSQLNP("sp_GetHostMail");
            if (rs1.next()) {
                smtpHost = rs1.getString("Host");
                smtpPort = rs1.getString("Puerto");
                smtpProtocol = rs1.getString("Protocolo");
                StrNecAut = rs1.getString("NecAut");
                smtpStartTLS = rs1.getString("StartTLS");
            }
            rs1.close();
            rs1 = null;

            rs = UtileriasBDF.rsSQLNP(" st_getMensajesMailPDF ");

            while (rs.next()) {

                PDFOrigen = rs.getString("PDFOrigen");
                PDFDest = rs.getString("PDFDest");

                PDFCartaBienvenida.generaPDF(rs.getString("Monto"), PDFOrigen, PDFDest);

                clMensajeStr = rs.getString("clMensaje");
                destinatarios = rs.getString("Destinatario").toString().trim();
                from = rs.getString("Correo").toString().trim();

                /*smtpHost = "172.21.16.15";

                 Properties props = System.getProperties();
                 props.put("mail.smtp.host", smtpHost);
                 //props.put("mail.smtp.auth", "true");
                 props.put("mail.smtp.auth", "false");

                 Authenticator auth = new Autenticador();
                 Session sesion = Session.getDefaultInstance(props, auth);*/
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
                    Authenticator auth = new EnviaCorreoPDF.Autenticador();
                    sesion = Session.getDefaultInstance(props, auth);
                } else {//--------- Mod2:Sin Autenticación ---------------------
                    sesion = Session.getDefaultInstance(props, null);
                    //---------------------------------------------------
                }

                Message mensaje = new MimeMessage(sesion);

                mensaje.setSubject(rs.getString("Asunto").toString());
                mensaje.setFrom(new InternetAddress(from));

                destinatarios = destinatarios.replace("||", "| |"); // se pone un espacio para enviar ocultos (BCC) si no hay copia (CC)

                st = new StringTokenizer(destinatarios, "|");
                ArrayList recipientes = new ArrayList();
                ArrayList Destinatarios = new ArrayList();

                while (st.hasMoreTokens()) {
                    rMail = st.nextToken();
                    recipientes.add(rMail.trim());
                }

                Address mail = null;

                for (int i = 0; i < recipientes.size(); i++) {
                    st = new StringTokenizer(recipientes.get(i).toString(), ",");
                    while (st.hasMoreTokens()) {
                        mail = new InternetAddress(st.nextToken().toString());
                        Destinatarios.add(mail);
                    }
                    if (i == 0) { // TO
                        mensaje.addRecipients(Message.RecipientType.TO, obtenerListaDeDirecciones(mensaje, Destinatarios));
                    } else if (i == 1) { // CC
                        mensaje.addRecipients(Message.RecipientType.CC, obtenerListaDeDirecciones(mensaje, Destinatarios));
                    } else if (i == 2) { // BCC
                        mensaje.addRecipients(Message.RecipientType.BCC, obtenerListaDeDirecciones(mensaje, Destinatarios));
                    }
                }
//---------------------------------------------------------------------------------------------------------------------------*/
                // Crear un Multipart de tipo multipart/related
                Multipart multipart = new MimeMultipart("related");

                // Rellenar el MimeBodyPart con el fichero e indicar que es un fichero HTML
                BodyPart texto = new MimeBodyPart();
                texto.setContent(rs.getString("Cuerpo").toString(), "text/html");
                multipart.addBodyPart(texto);

//--------------------------------------- Mod: Adjunta imagenes en el correo (Embebidas) ---------------------------------------------------
                Archivo = rs.getString("Archivo").toString().trim();

                ArrayList Imagenes = null;

                if (Archivo.indexOf("/") != -1 || Archivo.indexOf("\\") != -1) {
                    st = new StringTokenizer(Archivo, "|");
                    Imagenes = new ArrayList();

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

                //----------------Mod 1: Adjunta Todo tipo de archivos en el correo    ---*/
                Adjunto = rs.getString("Adjuntos").toString().trim();

                ArrayList ArchivosAdjuntos = null;
                if (Adjunto.indexOf("/") != -1 || Adjunto.indexOf("\\") != -1) {
                    st = new StringTokenizer(Adjunto, "|");
                    ArchivosAdjuntos = new ArrayList();

                    while (st.hasMoreTokens()) {
                        ArchivoAdjStr = st.nextToken();
                        ArchivosAdjuntos.add(ArchivoAdjStr);
                    }

                    MimeBodyPart ArchivoAdj[] = new MimeBodyPart[ArchivosAdjuntos.size()];
                    DataSource fds[] = new DataSource[ArchivosAdjuntos.size()];

                    File path = null;
                    for (int i = 0; i < ArchivosAdjuntos.size(); i++) {
                        ArchivoAdj[i] = new MimeBodyPart();
                        path = new File(ArchivosAdjuntos.get(i).toString());
                        fds[i] = new FileDataSource(path);
                        ArchivoAdj[i].setDataHandler(new DataHandler(fds[i]));
                        ArchivoAdj[i].setFileName(path.getName());
                        multipart.addBodyPart(ArchivoAdj[i]);
                    }
                    path = null;
                }
                //------------------------------------------------------------------------*/
                mensaje.setContent(multipart);
                mensaje.setSentDate(new Date());

                try {
                    Transport.send(mensaje);
                    System.out.println("mail enviado ");
                    EjecutaActualizaMensajesMailPDF.ActualizaEnviado(Integer.valueOf(clMensajeStr), 1);

                    System.out.println("borrar archivo...");

                    File pdf = new File(PDFDest);

                    if (!pdf.exists()) {
                        System.err.println("No existe el archivo: " + pdf.getName());
                        return;
                    }

                    if (pdf.delete()) {
                        System.err.println("Archivo Borrado: " + PDFDest);
                    } else {
                        System.err.println("Fallo el borrado de: " + PDFDest);
                    }

                    pdf = null;

                } catch (MessagingException ex) {
                    EjecutaActualizaMensajesMailPDF.ActualizaEnviado(Integer.valueOf(clMensajeStr), 2);
                    System.out.println("Error en send(mensaje)");
                    ex.printStackTrace();
                }
            }

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
                PDFOrigen = null;
                PDFDest = null;
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
                st = null;

            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    public static Address[] obtenerListaDeDirecciones(Message mensaje, ArrayList Destinatarios) throws javax.mail.MessagingException {
        Address address[] = new Address[Destinatarios.size()];
        for (int j = 0; j < Destinatarios.size(); j++) {
            address[j] = (InternetAddress) Destinatarios.get(j);
        }
        Destinatarios.clear();
        return address;
    }

    public static void Start() {
        chStatus(true);
        TimerEnviaCorreoPDF.Start();
    }

    public static void Stop() {
        chStatus(false);
    }

    private static void chStatus(boolean pEstatus) {
        isStarted = pEstatus;
    }

    /*------------------------------------ Mod2: Autenticación ------------------------------------*/
    private static class Autenticador extends Authenticator {

        /*ATENCION MONITOREAR MEMORIA SE AGREGARON 2 RS NUEVOS YA QUE MARCABA ERROR AL INTENTAR REUTILIZAR EL MISMO!!! 20140704 - mramirez*/
        //ResultSet rs = null; 
        public PasswordAuthentication getPasswordAuthentication() {
            String StrUSR = "";
            String StrPWD = "";

            rs2 = UtileriasBDF.rsSQLNP("st_MailAutentification");

            try {
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
            }
        }
    }
}