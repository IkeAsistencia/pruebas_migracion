/*
 * Correo.java
 *
 * Created on 15 de noviembre de 2005, 04:31 PM
 */
package Utilerias;

import java.util.*;
import java.io.*;
import java.sql.ResultSet;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class Correo {

    public static String mensaje = null;
    private static ResultSet rs1 = null;

    public Correo() {
    }

    public static void EnviaMail(String from, String correo, String asunto, String archivo, String host) {

        String to = correo;
        from = from + "@ikeasistencia.com";

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.debug", "false");
        Session session = Session.getInstance(props);

        try {
            
            rs1 = UtileriasBDF.rsSQLNP("sp_GetHostMail");
            if (rs1.next()) {
                host = rs1.getString("Host");
            }
            rs1.close();
            rs1 = null;
            
            Transport bus = session.getTransport("smtp");
            bus.connect(host, from, from);
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            InternetAddress[] address = {new InternetAddress(to)};
            msg.setRecipients(Message.RecipientType.TO, address);
            msg.setSubject(asunto);
            msg.setSentDate(new Date());
            setFileAsAttachment(msg, archivo);
            msg.saveChanges();
            bus.sendMessage(msg, address);
            bus.close();
        } catch (Exception mex) {
            System.out.println("Error en Correo " + mex);
            System.out.println("Error en Correo " + mex);
        }
    }

    public static void setTextContent(Message msg) throws MessagingException {
        String mytxt = mensaje;
        msg.setText(mytxt);
        msg.setContent(mytxt, "text/plain");
    }

    public static void setMultipartContent(Message msg) throws MessagingException {
        MimeBodyPart p1 = new MimeBodyPart();
        p1.setText("I M P O R T A N T E: Para evitar que se llene su bandeja de entrada, guarde el archivo anexo y elimine este correo y de elementos eliminados tambien.");
        MimeBodyPart p2 = new MimeBodyPart();
        p2.setText("", "us-ascii");
        Multipart mp = new MimeMultipart();
        mp.addBodyPart(p1);
        mp.addBodyPart(p2);
        msg.setContent(mp);
    }

    public static void setFileAsAttachment(Message msg, String filename) throws MessagingException {

        MimeBodyPart p1 = new MimeBodyPart();
        p1.setText("I M P O R T A N T E: Para evitar que se llene su bandeja de entrada, guarde el archivo anexo y elimine este correo y de elementos eliminados tambien.");
        MimeBodyPart p2 = new MimeBodyPart();
        FileDataSource fds = new FileDataSource(filename);
        p2.setDataHandler(new DataHandler(fds));
        p2.setFileName(fds.getName());
        Multipart mp = new MimeMultipart();
        mp.addBodyPart(p1);
        mp.addBodyPart(p2);
        msg.setContent(mp);
    }

    static class HTMLDataSource implements DataSource {

        private String html;

        public HTMLDataSource(String htmlString) {
            html = htmlString;
        }

        public InputStream getInputStream() throws IOException {
            if (html == null) {
                throw new IOException("Null HTML");
            }
            return new ByteArrayInputStream(html.getBytes());
        }

        public OutputStream getOutputStream() throws IOException {
            throw new IOException("This DataHandler cannot write HTML");
        }

        public String getContentType() {
            return "text/html";
        }

        public String getName() {
            return "JAF text/html dataSource to send e-mail only";
        }
    }
}