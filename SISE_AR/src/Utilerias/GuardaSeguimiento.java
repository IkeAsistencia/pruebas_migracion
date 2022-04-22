package Utilerias;

import ar.com.ike.geo.hogar.CancelaCita;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.Map;
import java.util.Map.Entry;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GuardaSeguimiento extends HttpServlet {
  
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  
  }
  
  public void destroy() {
  }
  
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    HttpSession sessionH = request.getSession(false);
    
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    
    out.println("<html>");
    out.println("<head>");
    out.println("<title>Guarda Seguimiento</title>");
    out.println("</head>");
    out.println("<body>");
    for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
      System.out.println("GuardaSeguimiento: " + (String)entry.getKey() + ":" + ((String[])entry.getValue())[0]);
    }
    String strTipoSeguimiento = "";
    if (request.getParameter("TipoSeg0") != null)
    {
      strTipoSeguimiento = request.getParameter("TipoSeg0");
    }
    else if (request.getParameter("TipoSeg1") != null)
    {
      strTipoSeguimiento = request.getParameter("TipoSeg1");
    }
    else
    {
      out.println("<p class='class='cssTitDet'>Error en el Tipo de Seguimiento. Consulte a su Administrador.</p>");
      out.println("</body>");
      out.println("</html>");
      return;
    }
    ResultSet rsEx = null;
    String StrclExpediente = "0";
    String StrclExpedienteBK = "0";
    String StrclEstatus = "0";
    String StrclProveedor = "0";
    String StrObservaciones = "";
    String StrURLBACK = "";
    String StrclUsrApp = "0";
    String StrclMotivo = "0";
    String StrFechaReco = "";
    String StrHoraReco = "";
    if (sessionH.getAttribute("clUsrApp") != null)
    {
      StrclUsrApp = sessionH.getAttribute("clUsrApp").toString();
    }
    else
    {
      out.println("<p class='class='cssTitDet'>No ha iniciado sesión o caducó. Por favor ingrese de nuevo.</p>");
      out.println("</body>");
      out.println("</html>");
      out.close();
      return;
    }
    System.out.println(request.getParameter("clProveedor1"));
    System.out.println(request.getParameter("clProveedor0"));
    if ((null != request.getParameter("clProveedor1")) && (!request.getParameter("clProveedor1").isEmpty()) && (!request.getParameter("clProveedor1").equals("0")))
    {
      StrclProveedor = request.getParameter("clProveedor1");
      System.out.println("UTILIZA: clProveedor1:" + StrclProveedor);
    }
    else if ((null != request.getParameter("clProveedor0")) && (!request.getParameter("clProveedor0").isEmpty()))
    {
      StrclProveedor = request.getParameter("clProveedor0");
      System.out.println("UTILIZA: clProveedor0:" + StrclProveedor);
    }
    else
    {
      out.println("<p class='class='cssTitDet'>Debe informar proveedor.</p>");
      out.println("</body>");
      out.println("</html>");
      return;
    }
    switch (Integer.parseInt(strTipoSeguimiento))
    {
    case 0: 
      if (request.getParameter("clEstatus0") != null)
      {
        StrclEstatus = request.getParameter("clEstatus0").toString();
        if (request.getParameter("clEstatus0").toString().compareToIgnoreCase("") != 0)
        {
          StrclEstatus = request.getParameter("clEstatus0").toString();
        }
        else
        {
          out.println("<p class='class='cssTitDet'>Debe informar estatus.</p>");
          out.println("</body>");
          out.println("</html>");
          out.close();
        }
      }
      else
      {
        out.println("<p class='class='cssTitDet'>Debe informar estatus.</p>");
        out.println("</body>");
        out.println("</html>");
        out.close();
        return;
      }
      if (sessionH.getAttribute("clExpediente") != null) {
        StrclExpediente = sessionH.getAttribute("clExpediente").toString();
      }
      if (request.getParameter("URLBACK0") != null)
      {
        StrURLBACK = request.getParameter("URLBACK0").toString();
      }
      else
      {
        out.println("<p class='class='cssTitDet'>Error en la carga de información. Consulte a su Administrador.</p>");
        out.println("</body>");
        out.println("</html>");
        out.close();
        return;
      }
      if (request.getParameter("Observaciones0") != null) {
        StrObservaciones = request.getParameter("Observaciones0").toString();
      }
      if (request.getParameter("clMotivo0") != null) {
        StrclMotivo = request.getParameter("clMotivo0").toString();
      }
      
      if (request.getParameter("FechaReco") != null) {
        StrFechaReco = request.getParameter("FechaReco");
      }
      if (request.getParameter("HoraReco") != null) {
        StrHoraReco = request.getParameter("HoraReco");
      }
      
      break;
    case 1: 
      if (request.getParameter("clEstatus1") != null)
      {
        StrclEstatus = request.getParameter("clEstatus1").toString();
        if (request.getParameter("clEstatus1").toString().compareToIgnoreCase("") != 0)
        {
          StrclEstatus = request.getParameter("clEstatus1").toString();
        }
        else
        {
          out.println("<p class='class='cssTitDet'>Debe informar estatus.</p>");
          out.println("</body>");
          out.println("</html>");
          out.close();
        }
      }
      else
      {
        out.println("<p class='class='cssTitDet'>Debe informar estatus.</p>");
        out.println("</body>");
        out.println("</html>");
        out.close();
        return;
      }
      if (sessionH.getAttribute("clExpediente") != null) {
        StrclExpediente = sessionH.getAttribute("clExpediente").toString();
      }
      if (request.getParameter("URLBACK1") != null)
      {
        StrURLBACK = request.getParameter("URLBACK1").toString();
      }
      else
      {
        out.println("<p class='class='cssTitDet'>Error en la carga de informaci?n. Consulte a su Administrador.</p>");
        out.println("</body>");
        out.println("</html>");
        out.close();
        return;
      }
      if (request.getParameter("Observaciones1") != null) {
        StrObservaciones = request.getParameter("Observaciones1");
      }
      if (request.getParameter("FechaReco") != null) {
        StrFechaReco = request.getParameter("FechaReco");
      }
      if (request.getParameter("HoraReco") != null) {
        StrHoraReco = request.getParameter("HoraReco");
      }
      break;
    }
    try
    {
      String sTmpMotivo = "27".equals(StrclMotivo) ? "NU Reprograma Cita" : "25".equals(StrclMotivo) ? "PVD Reprograma Cita" : "26".equals(StrclMotivo) ? "PVD Cancela Cita" : "28".equals(StrclMotivo) ? "NU Cancela Cita" : "Cita Mal Cargada";
      
      sTmpMotivo = ("1".equals(strTipoSeguimiento)) && ("4".equals(StrclEstatus)) ? "PVD Cancelado" : sTmpMotivo;
      System.out.println("MotivoCancela:" + sTmpMotivo);
      if ((("1".equals(strTipoSeguimiento)) && ("4".equals(StrclEstatus))) || (("0".equals(strTipoSeguimiento)) && ((("49".equals(StrclEstatus)) && (("28".equals(StrclMotivo)) || ("26".equals(StrclMotivo)) || ("25".equals(StrclMotivo)) || ("27".equals(StrclMotivo)))) || (("52".equals(StrclEstatus)) && ("29".equals(StrclMotivo)))))) {
        if (StrclProveedor != null)
        {
          String sSql = "st_GetCitaGeoXExpPVD " + StrclExpediente + ", " + StrclProveedor;
          rsEx = UtileriasBDF.rsSQLNP(sSql);
          System.out.println(sSql);
          if (rsEx.next())
          {
            if (rsEx.getInt("clCita") != 0)
            {
              CancelaCita cc = new CancelaCita();
              if (cc.Cancelar(rsEx.getInt("clCita"), "49", sTmpMotivo)) {
                System.out.println("GeoHogar.CancelacionCita:Exitosa");
              } else {
                System.out.println("GeoHogar.CancelacionCita:NO SE PUDO CANCELAR");
              }
            }
            else
            {
              System.out.println("Cancelacion de Cita=clCita=0");
            }
          }
          else {
            System.out.println("No se encontro registros para enviar la cancelacion a GeoHogar");
          }
        }
        else
        {
          System.out.println("GuardaSeguimiento.clProveedor:0");
        }
      }
    }
    catch (Exception e)
    {
      System.out.println("Utilerias.GuardaSeguimiento.java.Error:" + e.toString());
    }
    try
    {
      String sSql = "sp_GuardaSeguimiento " + StrclExpediente + ", " + StrclEstatus + ", " + StrclMotivo + ",'" + StrObservaciones + "', " + StrclUsrApp + ", " + StrclProveedor + ", '" + StrFechaReco + "','" + StrHoraReco + "'";
      rsEx = UtileriasBDF.rsSQLNP(sSql);
      System.out.println(sSql);
      if (rsEx.next())
      {
        String strclExpedienteRt = rsEx.getString("clExpediente");
        if (strclExpedienteRt != null)
        {
          StrclExpedienteBK = strclExpedienteRt.toString();
          if (StrclExpedienteBK.compareToIgnoreCase("0") == 0)
          {
            out.println("<p class='class='cssTitDet'>" + rsEx.getString("Mensaje").toString() + "</p>");
            out.println("</body>");
            out.println("</html>");
            out.close();
            return;
          }
          out.println("<script>location.href=\"" + StrURLBACK + "\"</script>");
        }
        else
        {
          out.println("<p class='class='cssTitDet'>Error en la transacci?n. Consulte a su Administrador.</p>");
          out.println("</body>");
          out.println("</html>");
          out.close();
          return;
        }
        rsEx.close();
      }
      try
      {
        if (rsEx != null)
        {
          rsEx.close();
          rsEx = null;
        }
      }
      catch (Exception ee)
      {
        ee.printStackTrace();
      }
      out.println("</body>");
    }
    catch (Exception e)
    {
      out.close();
      e.printStackTrace();
    }
    finally
    {
      try
      {
        if (rsEx != null)
        {
          rsEx.close();
          rsEx = null;
        }
      }
      catch (Exception ee)
      {
        ee.printStackTrace();
      }
    }
    out.println("</html>");
    out.close();
  }
  
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    processRequest(request, response);
  }
  
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    processRequest(request, response);
  }
  
  public String getServletInfo()
  {
    return "Short description";
  }
}