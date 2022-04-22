<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Utilerias.ResultList,Seguridad.SeguridadC,Utilerias.ConnectionURL" errorPage="" %>
<html>
	<head>
		<title>Filtros Clave</title>
	</head> 
	<body class="cssBody">
		<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
		<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
		<%
		String strclUsr = "0";

		if (session.getAttribute("clUsrApp") != null) {
			strclUsr = session.getAttribute("clUsrApp").toString();
		}

		if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
			%>Fuera de Horario<%
			strclUsr = null;
			return;
		}

		String strClave = "";
		String strBIN = "";
                String strBIN1 = "";
		String strclCuenta = "";
		Integer NumReg = 0;
		String StrrsclCuenta = "";
		String strSql = "";
		ResultList rs = null;
		StringBuffer strSalida = new StringBuffer();
		//-------------------------Cuenta MasterCard----------------------------
		String Banco = "0";
		String Otorgar = "0";
		String Mensaje = "";
		String StrclCuenta = "";
		String urlWSMC = "";
		String StrParametro = "";
		String ICACode = "";
		String ICACountry = "";
		String ICALegalName = "";
		String ICARegion = "";
		String ICAState = "";
		String ParentICACode = "";
		String ICABin = "";
		String BenTod = "";
		String infoWS = "";
		String ProductCd = "";
		String prod = "0";
		String rc = "";
		String rm = "";
		String clBitacoraALS = "";
		String StrWarmTransfer = "";
		String StrMensajeNuevo = "";
		String StrAlertMsg = "";
		String StrCodPais = "BRA";
		String Pcd = "";
		String urlBack = "";
		String ProductName = "";

		if (request.getParameter("Pcd") != null) {
			Pcd = request.getParameter("Pcd").toString();
		}

		//-------------------------Cuenta MasterCard----------------------------
		if (request.getParameter("Clave") != null) {
			strClave = request.getParameter("Clave").toString().trim();
		}

		if (request.getParameter("clCuenta") != null) {
			strclCuenta = request.getParameter("clCuenta").toString().trim();
		}

		if ((strclCuenta.equalsIgnoreCase("1353") || strclCuenta.equalsIgnoreCase("1354")) && !strClave.equalsIgnoreCase("")) {
			if (strClave.length() < 16) { %>
				<script>
					alert("El campo clave tiene menos caracteres de los permitidos, ingrese los 16 dígitos de la tarjeta.");
					window.close();
				</script>
			<% } else if (strClave.length() > 16) { %>
				<script>
					alert("El campo clave tiene más caracteres de los permitidos, ingrese los 16 dígitos de la tarjeta.");
					window.close();
				</script>
			<% } else {
					strBIN = strClave.substring(0, 6);
                                        strBIN1 = strClave.substring(0, 1);
				}

			//---------------------Cuenta MasterCard----------------------------
			rs = new ResultList();
			rs.rsSQL("st_InsertaBitacoraALS '" + strclUsr + "','" + strBIN + "'");

			if (rs.next()) {
				clBitacoraALS = rs.getString("clBitacoraALS");
			}

			rs.close();
			rs = null;

			ConnectionURL url = new ConnectionURL();
			urlWSMC = "http://172.21.10.41:8084/MCWS_TEST/benefit.jsp?";
			//urlWSMC = "http://172.21.16.39:8080/MCWS_Capa/benefit.jsp?";
			StrParametro = "strBin=" + strClave + "&Pcd=" + Pcd + "&clCuenta=" + StrclCuenta;
			urlBack = "&urlBack=" + request.getRequestURL() + "";
			StrParametro = StrParametro + urlBack;
			StrParametro = StrParametro.replaceAll("%20", "%");
			infoWS = url.SendtoURL(urlWSMC, StrParametro);
			Mensaje = infoWS;
			Mensaje = Mensaje.replace("'", "<27>");
			//obteniedo mensajes de respuesta
			BenTod = url.getValueofTagD(Mensaje, "benTod");
			rc = url.getValueofTagD(Mensaje, "rscod");
			rm = url.getValueofTagD(Mensaje, "rsmsn");
			ProductCd = url.getValueofTagD(Mensaje, "prodCd");
			ProductName = url.getValueofTagD(Mensaje, "proname");

			if (!rc.equals("BENEFITINFO_VAL_005")) {
				Banco = url.getValueofTagD(Mensaje, "banco");
				ICACode = url.getValueofTagD(Mensaje, "codigo");
				ICACountry = url.getValueofTagD(Mensaje, "contry");
				ICALegalName = url.getValueofTagD(Mensaje, "legalName");
				ICARegion = url.getValueofTagD(Mensaje, "region");
				ICAState = url.getValueofTagD(Mensaje, "state");
				ParentICACode = url.getValueofTagD(Mensaje, "parentICACode");
				ProductCd = url.getValueofTagD(Mensaje, "prodCd");
				ICABin = url.getValueofTagD(Mensaje, "numcar");
				ICABin = ICABin.substring(0, 6);
				ProductName = url.getValueofTagD(Mensaje, "proname");
				BenTod = url.getValueofTagD(Mensaje, "benTod");
				rs = new ResultList();
				rs.rsSQL("st_ActualizaBitacoraALS '" + clBitacoraALS + "','" + BenTod + "'");
				rs.close();
				rs = null;

                                System.out.println(ProductCd);
                                System.out.println(ProductCd);
                                System.out.println(ProductCd);
                                System.out.println(ProductCd);

                                if (strBIN1.equalsIgnoreCase("5")){ // Valida solo MC
                                    rs = new ResultList();
                                    rs.rsSQL("st_ValidaProdxPais '" + ICACountry + "','" + ProductCd + "'");

                                    System.out.println("st_ValidaProdxPais '" + ICACountry + "','" + ProductCd + "'");

                                    if (rs.next()) {
                                            prod = rs.getString("BAND");
                                    }

                                    rs.close();
                                    rs = null;
                                    
                                    if (prod.equalsIgnoreCase("0")) {%>
					<script>
						alert("El código de país no está permitido, favor de referir al tarjetahabiente a su banco.");
						window.close();
					</script>
                                    <%}

                                } else {%>
					<script>
						top.opener.fnActualizaBinALS('<%=Banco%>', '<%=Otorgar%>', '<%=Mensaje%>', '<%=ICABin%>', '<%=ICACode%>', '<%=ICACountry%>', '<%=ICALegalName%>', '<%=ICARegion%>', '<%=ICAState%>', '<%=ParentICACode%>', '<%=BenTod%>', '', '', '<%=prod%>', '<%=ProductCd%>', '<%=ProductName%>');
					</script>
				<% }
			} else { %>
				<script type="text/javascript">
					top.opener.fnActualizaBinALS('<%=Banco%>', '<%=Otorgar%>', '<%=Mensaje%>', '<%=ICABin%>', '<%=ICACode%>', '<%=ICACountry%>', '<%=ICALegalName%>', '<%=ICARegion%>', '<%=ICAState%>', '<%=ParentICACode%>', '<%=BenTod%>', '', '', '<%=prod%>', '<%=ProductCd%>', '<%=ProductName%>');
				</script>
			<%
			}
			//---------------------Cuenta MasterCard----------------------------
		} else {
			if (strClave.compareToIgnoreCase("") != 0) {
				if (strclCuenta.compareToIgnoreCase("") == 0) {
					strSql = " st_DetalleValidaClavexPrefijo'" + strClave + "'";
				} else {
					strSql = " st_DetalleValidaClavexCuenta'" + strClave + "','" + strclCuenta + "'";
				}
					
				rs = new ResultList();
				rs.rsSQL(strSql.toString());
				if (rs.next()) {
					NumReg = rs.getRow();
					if (NumReg.toString().equalsIgnoreCase("1")) {
						StrrsclCuenta = rs.getString("clCuenta");
						if (StrrsclCuenta.compareToIgnoreCase(strclCuenta) != 0) {%>
							<div class='VTable' style='position:absolute; z-index:20; left:100px; top:50px;'>
								<table>
									<td class='cBTN'>El Prefijo de la Clave pertenece a otra Cuenta diferente a la seleccionada</td>
								</table>
							</div>
						<%} else {%>
							<script>
								top.opener.fnActualizaDatosCuenta('<%=rs.getString("Nombre")%>', '<%=StrrsclCuenta%>', '<%=rs.getString("clTipoValidacion")%>', '<%=rs.getString("Mask")%>', '<%=rs.getString("MaskUsr")%>', '<%=rs.getString("TotAgentes")%>');
								window.close();
							</script>
							<%return;
						}
					}
					rs.close();
					rs = null;
				} else {
					rs.close();
					rs = null;
					if (strclCuenta.compareToIgnoreCase("") == 0) { %>
						<script>window.close();</script>
					<%} else {
						strSql = "st_GetPrefijoxCuenta '" + strclCuenta + "'";
						rs = new ResultList();
						rs.rsSQL(strSql.toString());
						if (rs.next()) {
						if (rs.getString("TotPref").compareToIgnoreCase("0") == 0) {
						%><script>window.close();</script>
						<%} else {%>
						<div class='VTable' style='position:absolute; z-index:20; left:100px; top:50px;'>
						<table>
						<td class='cBTN'>El Prefijo de la Clave No coincide con los de la cuenta</td>
						</table>
						</div>
						<%strclCuenta = "";
						}
						} else {  %>
							<script>window.close();</script><%    
						}
						rs.close();
						rs = null;
					}
				}
			} else {
				%><script>window.close();</script><%
				return;
			}
			
			if (strclCuenta.compareToIgnoreCase("") != 0) {
				strSql = "sp_WebBuscaClaveGpo '" + strClave + "','" + strclCuenta + "'";
			} else {
				strSql = "sp_WebBuscaClave '" + strClave + "'";
			}
			
			MyUtil.InicializaParametrosC(346, Integer.parseInt("1"));%>
			<form id='Forma' name ='Forma' action='FiltrosClave.jsp' method='get'>
			<input type='hidden' id='strSQL' name='strSQL' value="sp_WebBuscaClave"/>
			<%=MyUtil.ObjInput("Prefijo", "Clave", strClave, true, true, 25, 90, "", false, false, 50)%>
			<p align='left'>
			<input type='button' value='BUSCAR...' onClick='document.getElementById("Forma").submit();' class='cBtn'/>
			</p>
			</form>
			<script>document.getElementById("Clave").readOnly = false;window.resizeTo(700, 500);</script>
			<br><br><br><br><br>
			<%
			rs = new ResultList();
			strSalida.append(rs.rsTable(strSql.toString()));
			rs.close();
			rs = null;
			%>
			<%=strSalida.toString()%>
			<%
		}
		strSalida.delete(0, strSalida.length());
		strClave = null;
		strBIN = null;
                strBIN1 = null;
		strclCuenta = null;
		StrrsclCuenta = null;
		strSql = null;
		%>        
	</body>
</html>