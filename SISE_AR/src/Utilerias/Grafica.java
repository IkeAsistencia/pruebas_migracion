package Utilerias;

import com.ike.tmk.DAOGrafica;
import com.ike.model.to.PermisoGrafica;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;

public class Grafica extends HttpServlet {

    public String sentenciaSQL = "";
    public String clPagina = "";
    private String MesA = "";
    private String MesAN = "";
    private String MesAC = "";
    private String MesC = "0";
    public String clTipoGrafica = "0";
    ResultSet rs = null;

    public Grafica() {
    }

    public String doGet1(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        try {
            DAOGrafica daos = new DAOGrafica();
            PermisoGrafica permisografica = daos.getPermisoGrafica(clPagina);
            String param = (sentenciaSQL.trim().replaceAll(" ", "%20"));
            if (clPagina.equalsIgnoreCase("6") || clPagina.equalsIgnoreCase("27")) {
                rs = UtileriasBDF.rsSQLNP(sentenciaSQL.trim().replaceAll("%20", " "));
                while (rs.next()) {
                    MesC = rs.getString("consecutivo");
                    if (MesC.equalsIgnoreCase("4")) {
                        MesAN = rs.getString("Porcentaje");
                    }
                    if (MesC.equalsIgnoreCase("5")) {
                        MesA = rs.getString("Porcentaje");
                    }
                    if (MesC.equalsIgnoreCase("6")) {
                        MesAC = rs.getString("Porcentaje");
                    }


                }
                if (clPagina.equalsIgnoreCase("6")) {
                    return ("<IMG SRC=..\\SGrafica?type=" + param + "&dsCampo=" + permisografica.getDsCampo() + "&dsCampoCan=" + permisografica.getDsCampoCan() + "&Tipo=" + permisografica.getTipo() + "&Pagina=" + clPagina.toString().trim() + " BORDER=1 WIDTH=550 HEIGHT=320/><br><br>"
                            + "<TABLE>"
                            + "<tr>"
                            + "<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp"
                            + ";&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>"
                            + "<td><font face='Verdana, Arial, Helvetica, sans-serif' size='1' style='normal' color='#000000' ><strong>ACUMULADO </strong></font></td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>"
                            + "<td ><font face='Verdana, Arial, Helvetica, sans-serif' size='1' style='normal' color='#000000' ><strong> MES ANTERIOR </strong></font></td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>"
                            + "<td><font face='Verdana, Arial, Helvetica, sans-serif' size='1' style='normal' color='#000000' ><strong> MES ACTUAL </strong></font></td>"
                            + "</tr><br>"
                            + "<tr>"
                            + "<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp"
                            + ";&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>"
                            + "<td>&nbsp;&nbsp;<img src='../Imagenes/medalla1.JPG' width='59' height='73'></td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>"
                            + "<td>&nbsp;&nbsp;&nbsp;&nbsp;<img src='../Imagenes/medalla2.JPG' width='59' height='73'> </td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>"
                            + "<td>&nbsp;<img src='../Imagenes/medalla3.JPG' width='59' height='73'> </td>"
                            + "</tr><br>"
                            + "</TABLE>"
                            + "<div class='VTable' style='position:absolute; z-index:; left:146px; top:510px;'><font face='Verdana, Arial, Helvetica, sans-serif' size='1' style='normal' color='#000000' ><strong>" + MesAC + "</font></div>"
                            + "<div class='VTable' style='position:absolute; z-index:; left:254px; top:510px;'><font face='Verdana, Arial, Helvetica, sans-serif' size='1' style='normal' color='#000000' ><strong>" + MesAN + "</font></div>"
                            + "<div class='VTable' style='position:absolute; z-index:; left:352px; top:510px;'><font face='Verdana, Arial, Helvetica, sans-serif' size='1' style='normal' color='#000000' ><strong>" + MesA + "</font></div>");

                } else {
                    return ("<IMG SRC=..\\SGrafica?type=" + param + "&dsCampo=" + permisografica.getDsCampo() + "&dsCampoCan=" + permisografica.getDsCampoCan() + "&Tipo=" + permisografica.getTipo() + "&Pagina=" + clPagina.toString().trim() + " BORDER=1 WIDTH=550 HEIGHT=320/><br><br>"
                            + " <TABLE>"
                            + "<tr>"
                            + "<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;"
                            + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                            + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>"
                            + "<td><font face='Verdana, Arial, Helvetica, sans-serif' size='1' style='normal' color='#000000' ><strong>ACUMULADO </strong></font></td><td>&nbsp;&nbsp;</td>"
                            + "</tr><br>"
                            + "<tr>"
                            + "<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                            + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                            + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>"
                            + "<td>&nbsp;&nbsp;<img src='../Imagenes/medalla1.JPG' width='59' height='73'></td><td>&nbsp;&nbsp;</td>"
                            + "</tr><br>"
                            + "<div class='VTable' style='position:absolute; z-index:; left:262px; top:511px;'><font face='Verdana, Arial, Helvetica, sans-serif' size='1' style='normal' color='#000000' ><strong>" + MesAC + "</font></div>"
                            + "</TABLE>");
                }
            } else {
                if (clPagina.equalsIgnoreCase("23")) {
                    return ("<IMG SRC=..\\SGrafica?type=" + param + "&dsCampo=" + permisografica.getDsCampo() + "&dsCampoCan=" + permisografica.getDsCampoCan() + "&Tipo=" + permisografica.getTipo() + "&Pagina=" + clPagina.toString().trim() + " BORDER=1 WIDTH=680 HEIGHT=540/>");
                } else {
                    if (clPagina.equalsIgnoreCase("17") || clPagina.equalsIgnoreCase("19") || clPagina.equalsIgnoreCase("20") || clPagina.equalsIgnoreCase("21")) {
                        return ("<IMG SRC=..\\SGrafica?type=" + param + "&dsCampo=" + permisografica.getDsCampo() + "&dsCampoCan=" + permisografica.getDsCampoCan() + "&Tipo=" + permisografica.getTipo() + "&Pagina=" + clPagina.toString().trim() + " BORDER=1 WIDTH=700 HEIGHT=600/>");
                    } else {
                        return ("<IMG SRC=..\\SGrafica?type=" + param + "&dsCampo=" + permisografica.getDsCampo() + "&dsCampoCan=" + permisografica.getDsCampoCan() + "&Tipo=" + permisografica.getTipo() + "&Pagina=" + clPagina.toString().trim() + " BORDER=1 WIDTH=800 HEIGHT=600/>");
                    }
                }
            }
        } catch (Exception e) {
            System.err.println(e.toString());
            return "";
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                    sentenciaSQL = null;
                    clPagina = null;
                    MesA = null;
                    MesAN = null;
                    MesAC = null;
                    MesC = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
    }
}