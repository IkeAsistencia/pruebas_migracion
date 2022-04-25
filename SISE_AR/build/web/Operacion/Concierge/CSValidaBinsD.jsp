<%@page import="Utilerias.ConnectionURL"%>
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1250">
        <title>Valida BIN</title>
    </head>
    <body>

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>

        <%
            ResultSet rs = null;
            String Banco = "", Otorgar = "", Mensaje = "", strClave = "", StrclCuenta = "";

            String Banco1 = "", ICACode = "", ICACountry = "", ICALegalName = "", ICARegion = "",
                    ICAState = "", ParentICACode = "", ICABin = "", BenTod = "", StrSql = "", StrSQLB = "",
                    ProductCd = "", ProdPais = "", rc = "", rm = "", clBitacoraALS = "", cdpais = "", ProductName = "", Msjbd = "";

            String StrNomPag = "";
            String StrURL = "";
            String Pcd = "";
            String WarmTransfer = "";
            String ExisteBin = "";

            if (request.getParameter("ClaveBin") != null) {
                strClave = request.getParameter("ClaveBin").toString();
                //strClave = strClave.replace("-", "");
                strClave = strClave.trim();

            }

            if (request.getParameter("clCuenta") != null) {
                StrclCuenta = request.getParameter("clCuenta").toString();
                //StrclCuenta = StrclCuenta.replace("-", "");
                StrclCuenta = StrclCuenta.trim();

            }

            if (strClave.length() >= 6) {
                ICABin = strClave.substring(0, 6);
            }

            if (request.getParameter("Pcd") != null) {
                Pcd = request.getParameter("Pcd").toString();

            }

            if (request.getRequestURL() != null) {
                StrURL = request.getRequestURL().toString();
                StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
                //System.out.println("URL RQ(getRequestURL):..  " + StrURL);
                //System.out.println("Pagina.. " + StrNomPag);
            }

            //ICABin = strClave;
            //System.out.println("ICABin..."+ICABin);
            //ICABin = ICABin.substring(0, 6);
            //System.out.println("ICABin...==========" + ICABin);
            if (StrclCuenta.equalsIgnoreCase("1353")) {
                ConnectionURL url = new ConnectionURL();
                String urlWSMC = "";
                //PROD//String urlWSMC = "http://172.21.16.39:8080/MCWS_Capa/benefit.jsp";
                //String urlWSMC = "http://127.0.0.1:8084/MCWS/benefit.jsp?";            
                //String urlWSMC = "http://172.21.16.39:8080/MCWS/benefit.jsp?";
                //System.out.println("\n\n\n" + urlWSMC);
                String StrParametro = "?strBin=" + strClave + "&Pcd=" + Pcd + "&clCuenta=" + StrclCuenta;
                String urlBack = "&urlBack=" + request.getRequestURL() + "";
                StrParametro = StrParametro + urlBack;

                //System.out.println("URL.."+urlWSMC+StrParametro);
                StrParametro = StrParametro.replaceAll("%20", "%");
                String infoWS = url.SendtoURL(urlWSMC, StrParametro);

                Mensaje = infoWS;
                Mensaje = Mensaje.replace("'", "<27>");

                BenTod = url.getValueofTagE(Mensaje, "benTod");
                BenTod = BenTod.replace(">", "");
                BenTod = BenTod.replace("</", "");
                //System.out.println("benTod...==========" + BenTod);

                /**
                 * ******************************* Obteniendo mensaje de
                 * respuesta ***********************************************
                 */
                rc = url.getValueofTagE(Mensaje, "rscod");
                rc = rc.replace(">", "");
                rc = rc.replace("</", "");
                //System.out.println("\n\n\n\n\nrc...==========" + rc);

                rm = url.getValueofTagE(Mensaje, "rsmsn");
                rm = rm.replace(">", "");
                rm = rm.replace("</", "");
                //System.out.println("rm...==========" + rm);

                /**
                 * ******************* Valida codigo de error *********
                 */
                ProductCd = url.getValueofTagE(Mensaje, "prodCd");
                ProductCd = ProductCd.replace(">", "");
                ProductCd = ProductCd.replace("</", "");

                //System.out.println("\n\n\n\n\n\nProductcd...==========" + ProductCd);

                ProductName = url.getValueofTagE(Mensaje, "proname");
                ProductName = ProductName.replace(">", "");
                ProductName = ProductName.replace("</", "");
                //System.out.println("ProductName...==========" + ProductName);

                /**
                 * Condicion de mas de un porodurto *
                 */
                //System.out.println("\n\n\n\nRC = " + rc);

                if (!rc.equals("BENEFITINFO_VAL_005")) {

                    //System.out.println("\n\n\n\nRC = Aqui adentro");
                    /**
                     * ******************************* Obteniendo datos del
                     * banco ***********************************************
                     */
                    Banco1 = url.getValueofTagE(Mensaje, "banco");
                    Banco1 = Banco1.replace(">", "");
                    Banco1 = Banco1.replace("</", "");
                    //System.out.println("\n\n\nbanco...==========" + Banco1);

                    ICACode = url.getValueofTagE(Mensaje, "codigo");
                    ICACode = ICACode.replace(">", "");
                    ICACode = ICACode.replace("</", "");
                    //System.out.println("ICACod...==========" + ICACode);

                    ICACountry = url.getValueofTagE(Mensaje, "contry");
                    ICACountry = ICACountry.replace(">", "");
                    ICACountry = ICACountry.replace("</", "");
                    //System.out.println("ICACont...==========" + ICACountry);

                    ICALegalName = url.getValueofTagE(Mensaje, "legalName");
                    ICALegalName = ICALegalName.replace(">", "");
                    ICALegalName = ICALegalName.replace("</", "");
                    //System.out.println("ICALegalName...==========" + ICALegalName);

                    ICARegion = url.getValueofTagE(Mensaje, "region");
                    ICARegion = ICARegion.replace(">", "");
                    ICARegion = ICARegion.replace("</", "");
                    //System.out.println("ICARegion...==========" + ICARegion);

                    ICAState = url.getValueofTagE(Mensaje, "state");
                    ICAState = ICAState.replace(">", "");
                    ICAState = ICAState.replace("</", "");
                    //System.out.println("ICAState...==========" + ICAState);

                    ParentICACode = url.getValueofTagE(Mensaje, "parentICACode");
                    ParentICACode = ParentICACode.replace(">", "");
                    ParentICACode = ParentICACode.replace("</", "");
                    //System.out.println("ParentICACode...==========" + ParentICACode);

                    ProductCd = url.getValueofTagE(Mensaje, "prodCd");
                    ProductCd = ProductCd.replace(">", "");
                    ProductCd = ProductCd.replace("</", "");

                    if (Banco1.length() < 70) {
                        String Banco2 = Banco1.replace(">", "");
                        Banco = Banco2.replace("</", "");
                    } else {
                        Banco = "";
                    }

                    //System.out.println("ProductCd...==========" + ProductCd);
                    ProductName = url.getValueofTagE(Mensaje, "proname");
                    ProductName = ProductName.replace(">", "");
                    ProductName = ProductName.replace("</", "");
                    //System.out.println("\n\n\n\nProductName...==========" + ProductName);

                    /**
                     * ****************** Ejecuta Store validacion pais ****
                     */
                    cdpais = "ARG"; // El cdpais  es necesarios cambiarlos segun el pais 

                    StrSql = "st_ValidaProdxPais '" + ICACountry + "','" + ProductCd + "'"; // se agrego un nuevo parametro al store 
                    // asi mismo se modifico el store sp_s2_ValidaProdxPais

                    rs = UtileriasBDF.rsSQLNP(StrSql.toString());

                    if (rs.next()) {
                        ProdPais = rs.getString("BAND");
                    }
                    rs.close();

                    //System.out.println("\n\n\n\n\n\n\n--->" + ProdPais);
                    if (!ProdPais.equalsIgnoreCase("0")) {
                        /*
                         StrSql = "st_ValidaProdxPais '" + ICACountry + "','" + ProductCd + "'";
                         rs = UtileriasBDF.rsSQLNP(StrSql.toString());

                         if (rs.next()) {
                         Msjbd = rs.getString("MSJ");
                         }
                         rs.close();
                         ESTO QUE?*/
                        //System.out.println("top.opener.fnActualizaALS('" + Banco1 + "', '" + Otorgar + "', '" + Mensaje + "', '" + ICABin + "', '" + ICACode + "', '" + ICACountry + "', '" + ICALegalName + "', '" + ICARegion + "', '" + ICAState + "', '" + ParentICACode + "','" + BenTod + "','','','" + ProdPais + "','" + ProductCd + "');");
        %>
        <script type="text/javascript">
            top.opener.fnActualizaBinD('<%=Banco%>', '<%=Otorgar%>', '<%=Mensaje%>', '<%=ICABin%>', '<%=ICACode%>', '<%=ICACountry%>', '<%=ICALegalName%>', '<%=ICARegion%>', '<%=ICAState%>', '<%=ParentICACode%>', '<%=BenTod%>', '', '', '<%=ProdPais%>');
            window.close();
        </script>
        <%
            strClave = null;
            Banco = null;
            //rs= null;
        } else {

        %>
        <script type="text/javascript">
            alert("El codigo del pais no esta permitido ");
            window.close();
        </script>
        <%                            }

        } else {
        %>
        <script type="text/javascript">
            top.opener.fnActualizaBinD('<%=Banco%>', '<%=Otorgar%>', '<%=Mensaje%>', '<%=ICABin%>', '<%=ICACode%>', '<%=ICACountry%>', '<%=ICALegalName%>', '<%=ICARegion%>', '<%=ICAState%>', '<%=ParentICACode%>', '<%=BenTod%>', '', '', '<%=ProdPais%>');
            window.close();
        </script>
        <%
            }
        } else {
            //String StrSql="";

            StrSql = "st_CSObtenClave '" + strClave + "','" + StrclCuenta + "'";
            //System.out.println("\n\n----CSValidabins.jsp: " + StrSql);
            rs = UtileriasBDF.rsSQLNP(StrSql.toString());

            Banco = "0";
            Otorgar = "0";
            //String Mensaje = "";

            if (rs.next()) {
                Banco = rs.getString("Banco");
                Otorgar = rs.getString("Otorgar");
                Mensaje = rs.getString("Mensaje");
                WarmTransfer = rs.getString("WarmTransfer");
                ExisteBin = rs.getString("ExisteBin");
            }
        
            rs.close();
        %>
        <script>
            top.opener.fnActualizaBin('<%=Banco%>', '<%=Otorgar%>', '<%=Mensaje%>', '<%=WarmTransfer%>', '<%=ExisteBin%>');
            window.close();
        </script>
        <%
            }
        %>
    </body>
</html>


<%  // System.out.println(" "+urlWSMC+StrParametro);
    // String urlCom = urlWSMC + StrParametro;
    // System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + urlCom);
    //String infoWS = "";
    ///String infoWS2 = url.SendtoURLCom(urlCom);
    /*
     String StrSql="";

     StrSql="st_CSObtenClave '"+ strClave+"','"+StrclCuenta+"'";
     System.out.println(StrSql);
     ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
   
     String Banco="0";
     String Otorgar = "0";
     //String Mensaje = "";
        
     if (rs.next()){
     Banco = rs.getString("Banco");
     Otorgar = rs.getString("Otorgar");
     Mensaje = rs.getString("Mensaje");
     }
         
         
     */
    /*MensajeBit=Mensaje.replace("'", "<27>");
     MensajeBit=MensajeBit.replace("\"", "<28>");
     MensajeBit=MensajeBit.replace(" ", "");
     */
%>