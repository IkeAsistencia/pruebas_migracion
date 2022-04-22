<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <meta http-equiv="refresh" content="20"> 
    <head>
        <title></title>
        <style>
            .Bordes{border-width:1px; 
                    border-style:solid;
                    border-color:#586880;
            }
            .InputFont{ background-color: #1F497D;
                        font-size: 14pt;
                        color: #FFFFFF; 
                        letter-spacing : 2px;
            }
        </style>
    </head>
    <body class="cssBody" onload="mueveReloj();">
        <link href="../../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <!--script src='../Utilerias/Util.js'></script-->
        
        <%
        String StrclPais = "";
        String StrdsPais = "";
        String StrLogoPais = "";
        String BlackAsistxProd = "0";
        String PlatAsistxProd = "0";
        
        String AsistEnProc_Cero = "0";
        String AsistEnProc_1a2 = "0";
        String AsistEnProc_2a4 = "0";
        String AsistEnProc_4a8 = "0";
        String AsistEnProc_8a16 = "0";
        String AsistEnProc_16a24 = "0";
        String AsistEnProc_24a48 = "0";
        String AsistEnProc_48a72 = "0";
        String AsistEnProc_72Sup = "0";
        
        String Year2Date = "0";
        
        String VerdeTENU = "0";
        String AmarilloTENU = "0";
        String RojoTENU = "0";
        
        String VerdeTENP = "0";
        String AmarilloTENP = "0";
        String RojoTENP = "0";
        
        String VerdeCITAS = "0";
        String AmarilloCITAS = "0";
        String RojoCITAS = "0";
        
        String VerdeTCONTAC = "0";
        String AmarilloTCONTAC = "0";
        String RojoTCONTAC = "0";
        
        String StrAsistConcluidas = "0";
        String StrAsistCanceladas = "0";
        String StrAsistNoCompletadas = "0";
        String StrAsistNoContactadas = "0";
        
        String StrAsistRegistradosMesAnt = "0";
        String StrAsistConcluidasMesAnt = "0";
        String StrAsistCanceladasMesAnt = "0";
        String StrAsistNoCompletadasMesAnt = "0";
        String StrAsistNoContactadasMesAnt = "0";
        
        String StrAsistRegistradosMesAct = "0";
        String StrAsistConcluidasMesAct = "0";
        String StrAsistCanceladasMesAct = "0";
        String StrAsistNoCompletadasMesAct = "0";
        String StrAsistNoContactadasMesAct = "0";
        
        if(request.getParameter("clPais") != null){
            StrclPais = request.getParameter("clPais").toString();
        }
        
        if(StrclPais.equalsIgnoreCase("1")){
            StrdsPais = "Argentina";
            StrLogoPais = "ikeargentina.png";
        }
        
        if(StrclPais.equalsIgnoreCase("2")){
            StrdsPais = "Brasil";
            StrLogoPais = "ikebrasil.png";
        }
        
        if(StrclPais.equalsIgnoreCase("3")){
            StrdsPais = "México";
            StrLogoPais = "ikemexico.png";
        }
        
        ResultSet rsAsistxProd = UtileriasBDF.rsSQLNP(" st_CS_MCrpt_AsistxProd "+StrclPais);
        
        while(rsAsistxProd.next()){
            if(rsAsistxProd.getString("clTipoTarjeta").equalsIgnoreCase("2")){
                BlackAsistxProd = rsAsistxProd.getString("TotAsistencias");
            }
            
            if(rsAsistxProd.getString("clTipoTarjeta").equalsIgnoreCase("1")){
                PlatAsistxProd = rsAsistxProd.getString("TotAsistencias");
            }
        }
        
        ResultSet rsAsistEnProc = UtileriasBDF.rsSQLNP(" st_CS_MCrpt_AsistEnProc "+StrclPais);
        
        while(rsAsistEnProc.next()){
            if(rsAsistEnProc.getString("Tiempo").equalsIgnoreCase("0")){
                AsistEnProc_Cero = rsAsistEnProc.getString("TotAsistencias");
            }
            
            if(rsAsistEnProc.getString("Tiempo").equalsIgnoreCase("1-2")){
                AsistEnProc_1a2 = rsAsistEnProc.getString("TotAsistencias");
            }
            
            if(rsAsistEnProc.getString("Tiempo").equalsIgnoreCase("2-4")){
                AsistEnProc_2a4 = rsAsistEnProc.getString("TotAsistencias");
            }
            
            if(rsAsistEnProc.getString("Tiempo").equalsIgnoreCase("4-8")){
                AsistEnProc_4a8 = rsAsistEnProc.getString("TotAsistencias");
            }
            
            if(rsAsistEnProc.getString("Tiempo").equalsIgnoreCase("8-16")){
                AsistEnProc_8a16 = rsAsistEnProc.getString("TotAsistencias");
            }
            
            if(rsAsistEnProc.getString("Tiempo").equalsIgnoreCase("16-24")){
                AsistEnProc_16a24 = rsAsistEnProc.getString("TotAsistencias");
            }
            
            if(rsAsistEnProc.getString("Tiempo").equalsIgnoreCase("24-48")){
                AsistEnProc_24a48 = rsAsistEnProc.getString("TotAsistencias");
            }
            
            if(rsAsistEnProc.getString("Tiempo").equalsIgnoreCase("48-72")){
                AsistEnProc_48a72 = rsAsistEnProc.getString("TotAsistencias");
            }
            
            if(rsAsistEnProc.getString("Tiempo").equalsIgnoreCase(">72")){
                AsistEnProc_72Sup = rsAsistEnProc.getString("TotAsistencias");
            }
        }
        
        ResultSet rsYear2Date = UtileriasBDF.rsSQLNP(" st_CS_MCrpt_AsistYear2Date "+StrclPais);
        
        if(rsYear2Date.next()){
            Year2Date = rsYear2Date.getString("TotAsistencias");
        }
        
        ResultSet rsSemaforoTENU = UtileriasBDF.rsSQLNP(" st_CS_MCrpt_SemaforoTENU "+StrclPais);
        
        while(rsSemaforoTENU.next()){
            if(!rsSemaforoTENU.getString("Verde").equalsIgnoreCase("0")){
                VerdeTENU = rsSemaforoTENU.getString("Verde");
            }

            if(!rsSemaforoTENU.getString("Amarillo").equalsIgnoreCase("0")){
                AmarilloTENU = rsSemaforoTENU.getString("Amarillo");
            }
            
            if(!rsSemaforoTENU.getString("Rojo").equalsIgnoreCase("0")){
                RojoTENU = rsSemaforoTENU.getString("Rojo");
            }
        }
        
        ResultSet rsSemaforoTENP = UtileriasBDF.rsSQLNP(" st_CS_MCrpt_SemaforoTENP "+StrclPais);
        
        while(rsSemaforoTENP.next()){
            if(!rsSemaforoTENP.getString("Verde").equalsIgnoreCase("0")){
                VerdeTENP = rsSemaforoTENP.getString("Verde");
            }

            if(!rsSemaforoTENP.getString("Amarillo").equalsIgnoreCase("0")){
                AmarilloTENP = rsSemaforoTENP.getString("Amarillo");
            }
            
            if(!rsSemaforoTENP.getString("Rojo").equalsIgnoreCase("0")){
                RojoTENP = rsSemaforoTENP.getString("Rojo");
            }
        }
        
        ResultSet rsSemaforoCITAS = UtileriasBDF.rsSQLNP(" st_CS_MCrpt_SemaforoCITAS "+StrclPais);
        
        while(rsSemaforoCITAS.next()){
            if(!rsSemaforoCITAS.getString("Verde").equalsIgnoreCase("0")){
                VerdeCITAS = rsSemaforoCITAS.getString("Verde");
            }
            
            if(!rsSemaforoCITAS.getString("Amarillo").equalsIgnoreCase("0")){
                AmarilloCITAS = rsSemaforoCITAS.getString("Amarillo");
            }
            
            if(!rsSemaforoCITAS.getString("Rojo").equalsIgnoreCase("0")){
                RojoCITAS = rsSemaforoCITAS.getString("Rojo");
            }
        }
        
        ResultSet rsSemaforoTCONTAC = UtileriasBDF.rsSQLNP(" st_CS_MCrpt_SemaforoTCONTAC "+StrclPais);
        
        while(rsSemaforoTCONTAC.next()){
            if(!rsSemaforoTCONTAC.getString("Verde").equalsIgnoreCase("0")){
                VerdeTCONTAC = rsSemaforoTCONTAC.getString("Verde");
            }
            
            if(!rsSemaforoTCONTAC.getString("Amarillo").equalsIgnoreCase("0")){
                AmarilloTCONTAC = rsSemaforoTCONTAC.getString("Amarillo");
            }
            
            if(!rsSemaforoTCONTAC.getString("Rojo").equalsIgnoreCase("0")){
                RojoTCONTAC = rsSemaforoTCONTAC.getString("Rojo");
            }
        }
        
        ResultSet rsAsistxEstatus = UtileriasBDF.rsSQLNP(" st_CS_MCrpt_AsistxEstatus "+StrclPais);
        
        while(rsAsistxEstatus.next()){
            if(rsAsistxEstatus.getString("Estatus").equalsIgnoreCase("1")){
                StrAsistCanceladas = rsAsistxEstatus.getString("TotAsistencias");
            }
            
            if(rsAsistxEstatus.getString("Estatus").equalsIgnoreCase("2")){
                StrAsistNoCompletadas = rsAsistxEstatus.getString("TotAsistencias");
            }
            
            if(rsAsistxEstatus.getString("Estatus").equalsIgnoreCase("3")){
                StrAsistNoContactadas = rsAsistxEstatus.getString("TotAsistencias");
            }
            
            if(rsAsistxEstatus.getString("Estatus").equalsIgnoreCase("4")){
                StrAsistConcluidas = rsAsistxEstatus.getString("TotAsistencias");
            }
        }
        
        ResultSet rsAsistxEstatusMesAnt = UtileriasBDF.rsSQLNP(" st_CS_MCrpt_AsistxEstatusMesAnt "+StrclPais);
        
        while(rsAsistxEstatusMesAnt.next()){
            if(rsAsistxEstatusMesAnt.getString("Estatus").equalsIgnoreCase("0")){
                StrAsistRegistradosMesAnt = rsAsistxEstatusMesAnt.getString("TotAsistencias");
            }
            
            if(rsAsistxEstatusMesAnt.getString("Estatus").equalsIgnoreCase("1")){
                StrAsistCanceladasMesAnt = rsAsistxEstatusMesAnt.getString("TotAsistencias");
            }
            
            if(rsAsistxEstatusMesAnt.getString("Estatus").equalsIgnoreCase("2")){
                StrAsistNoCompletadasMesAnt = rsAsistxEstatusMesAnt.getString("TotAsistencias");
            }
            
            if(rsAsistxEstatusMesAnt.getString("Estatus").equalsIgnoreCase("3")){
                StrAsistNoContactadasMesAnt = rsAsistxEstatusMesAnt.getString("TotAsistencias");
            }
            
            if(rsAsistxEstatusMesAnt.getString("Estatus").equalsIgnoreCase("4")){
                StrAsistConcluidasMesAnt = rsAsistxEstatusMesAnt.getString("TotAsistencias");
            }
            
        }
        
        
        ResultSet rsAsistxEstatusMesAct = UtileriasBDF.rsSQLNP(" st_CS_MCrpt_AsistxEstatusMesAct "+StrclPais);
        
        while(rsAsistxEstatusMesAct.next()){
            if(rsAsistxEstatusMesAct.getString("Estatus").equalsIgnoreCase("0")){
                StrAsistRegistradosMesAct = rsAsistxEstatusMesAct.getString("TotAsistencias");
            }
            
            if(rsAsistxEstatusMesAct.getString("Estatus").equalsIgnoreCase("1")){
                StrAsistCanceladasMesAct = rsAsistxEstatusMesAct.getString("TotAsistencias");
            }
            
            if(rsAsistxEstatusMesAct.getString("Estatus").equalsIgnoreCase("2")){
                StrAsistNoCompletadasMesAct = rsAsistxEstatusMesAct.getString("TotAsistencias");
            }
            
            if(rsAsistxEstatusMesAct.getString("Estatus").equalsIgnoreCase("3")){
                StrAsistNoContactadasMesAct = rsAsistxEstatusMesAct.getString("TotAsistencias");
            }
            
            if(rsAsistxEstatusMesAct.getString("Estatus").equalsIgnoreCase("4")){
                StrAsistConcluidasMesAct = rsAsistxEstatusMesAct.getString("TotAsistencias");
            }
            
        }
        %>
        <div style='position:absolute; z-index:1025; left:200px; top:0px;'>
            <img SRC="../../../Imagenes/mastercardpng.png" alt="logo_mastercard">
        </div>
        
        <div style='position:absolute; z-index:1026; left:700px; top:0px;'>
            <img SRC="../../../Imagenes/<%=StrLogoPais%>" alt="logo_ike_asistencia">
        </div>
        
        
        <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" BGCOLOR="#FFFFFF" WIDTH="100%">
            <TR><TD>
                    <TABLE WIDTH="100%" HEIGHT="100%" BORDER="0" CELLSPACING="0" CELLPADDING="3" BGCOLOR="#FFFFFF">
                        <TR>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="5" COLOR="#FFC000"><B>MESA DE CONTROL - MASTERCARD CONCIERGE <%=StrdsPais.toUpperCase()%></B></FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="left" VALIGN="TOP" COLSPAN="9" ROWSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><B><INPUT ID="TIME_DIA" type="text" name="reloj" size="5" DISABLED style="border:none" ALIGN="center" CLASS="InputFont"></B></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><B><INPUT ID="TIME_MES" type="text" name="reloj" size="5" DISABLED style="border:none" ALIGN="center" CLASS="InputFont"></B></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><B><INPUT ID="TIME_ANIO" type="text" name="reloj" size="5" DISABLED style="border:none" ALIGN="center" CLASS="InputFont"></B></FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP">
                                <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">
                                    <B><INPUT ID="TIME_HH" type="text" name="reloj" size="5" DISABLED style="border:none" ALIGN="center" CLASS="InputFont"></B>
                            </FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP">
                                <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">
                                    <B><INPUT ID="TIME_MIN" type="text" name="reloj" size="5" DISABLED style="border:none" ALIGN="center" CLASS="InputFont"></B>
                            </FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP">
                                <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">
                                    <B><INPUT ID="TIME_SEG" type="text" name="reloj" size="5" DISABLED style="border:none" ALIGN="center" CLASS="InputFont"></B>
                            </FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="3" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>ASISTENCIAS ABIERTAS</B></FONT></TD>
                            <TD BGCOLOR="#D9D9D9" ALIGN="LEFT" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><B>PLATINUM</B></FONT></TD>
                            <TD BGCOLOR="#D9D9D9" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><B><%=PlatAsistxProd%></B></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFC000"><B>BLACK & WORLD ELITE</B></FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFC000"><B><%=BlackAsistxProd%></B></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="3" ROWSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>EN PROCESO</B></FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" WIDTH="7%" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>0 - 1 HR</B></FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" WIDTH="7%" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>1 - 2 HRS</B></FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" WIDTH="7%" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>2 - 4 HRS</B></FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" WIDTH="7%" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>4 - 8 HRS</B></FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" WIDTH="8%" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>8 - 16 HRS</B></FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" WIDTH="8%" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>16 - 24 HRS</B></FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" WIDTH="8%" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>24 - 48 HRS</B></FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" WIDTH="8%" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>48 - 72 HRS</B></FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" WIDTH="7%" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>> 72 HRS</B></FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B><%=AsistEnProc_Cero%></B></FONT></TD>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B><%=AsistEnProc_1a2%></B></FONT></TD>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B><%=AsistEnProc_2a4%></B></FONT></TD>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B><%=AsistEnProc_4a8%></B></FONT></TD>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B><%=AsistEnProc_8a16%></B></FONT></TD>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B><%=AsistEnProc_16a24%></B></FONT></TD>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B><%=AsistEnProc_24a48%></B></FONT></TD>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B><%=AsistEnProc_48a72%></B></FONT></TD>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B><%=AsistEnProc_72Sup%></B></FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="4" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>EN ESPERA DE NUESTRO USUARIO</B></FONT></TD>
                            <TD BGCOLOR="#76933C" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><%=VerdeTENU%></FONT></TD>
                            <TD BGCOLOR="#FFC000" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=AmarilloTENU%></FONT></TD>
                            <TD BGCOLOR="#CC3300" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><%=RojoTENU%></FONT></TD>
                            <TD BGCOLOR="#BFBFBF" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" ROWSPAN="7" CLASS="Bordes">
                                <FONT FACE="Tahoma" SIZE="3" COLOR="#244062"><B>YEAR TO DATE</B><BR><BR><BR>
                            <FONT FACE="Tahoma" SIZE="7" COLOR="#244062"><B><%=Year2Date%></B></FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" COLSPAN="10" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="4" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>EN ESPERA DE NUESTRO PROVEEDOR</B></FONT></TD>
                            <TD BGCOLOR="#76933C" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><%=VerdeTENP%></FONT></TD>
                            <TD BGCOLOR="#FFC000" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=AmarilloTENP%></FONT></TD>
                            <TD BGCOLOR="#CC3300" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><%=RojoTENP%></FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" COLSPAN="10" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="4" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>CITA PARA SEGUIMIENTO</B></FONT></TD>
                            <TD BGCOLOR="#76933C" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><%=VerdeCITAS%></FONT></TD>
                            <TD BGCOLOR="#FFC000" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=AmarilloCITAS%></FONT></TD>
                            <TD BGCOLOR="#CC3300" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><%=RojoCITAS%></FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" COLSPAN="10" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="4" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>TIEMPO DE CONTACTO</B></FONT></TD>
                            <TD BGCOLOR="#76933C" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><%=VerdeTCONTAC%></FONT></TD>
                            <TD BGCOLOR="#FFC000" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=AmarilloTCONTAC%></FONT></TD>
                            <TD BGCOLOR="#CC3300" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" CLASS="Bordes">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><%=RojoTCONTAC%></FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#808080" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>MOVIMIENTOS DEL DÍA</B></FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>CONCLUIDOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistConcluidas%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="4" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>CANCELADO</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistCanceladas%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>NO COMPLETADOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistNoCompletadas%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="4" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>NO CONTACTADOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistNoContactadas%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" COLSPAN="12" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#000000" ALIGN="CENTER" VALIGN="TOP" ROWSPAN="13" WIDTH="1%">
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>MES ANTERIOR</B></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>MES ACTUAL</B></FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>REGISTRADOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistRegistradosMesAnt%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>REGISTRADOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistRegistradosMesAct%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>CONCLUIDOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistConcluidasMesAnt%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>CONCLUIDOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistConcluidasMesAct%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>CANCELADOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistCanceladasMesAnt%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>CANCELADOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistCanceladasMesAct%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>NO COMPLETADOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistNoCompletadasMesAnt%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>NO COMPLETADOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistNoCompletadasMesAct%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>NO CONTACTADOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistNoContactadasMesAnt%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="LEFT" VALIGN="MIDDLE" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#FFFFFF"><B>NO CONTACTADOS</B></FONT></TD>
                            <TD BGCOLOR="#FFFFFF" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000"><%=StrAsistNoContactadasMesAct%></FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                        <TR>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                            <TD BGCOLOR="#1F497D" ALIGN="CENTER" VALIGN="TOP" COLSPAN="5" >
                            <FONT FACE="Tahoma" SIZE="3" COLOR="#000000">&nbsp;</FONT></TD>
                        </TR>
                    </TABLE>
        </TD></TR></TABLE>
        <%
        rsAsistxProd.close();
        rsAsistxProd = null;
        
        rsAsistEnProc.close();
        rsAsistEnProc = null;
        
        rsYear2Date.close();
        rsYear2Date = null;
        
        rsSemaforoTENU.close();
        rsSemaforoTENU = null;
        
        rsSemaforoTENP.close();
        rsSemaforoTENP = null;
        
        rsSemaforoCITAS.close();
        rsSemaforoCITAS = null;
        
        rsSemaforoTCONTAC.close();
        rsSemaforoTCONTAC = null;
        
        rsAsistxEstatus.close();
        rsAsistxEstatus = null;
        
        rsAsistxEstatusMesAnt.close();
        rsAsistxEstatusMesAnt = null;
        
        rsAsistxEstatusMesAct.close();
        rsAsistxEstatusMesAct = null;
        
        StrclPais = null;
        StrdsPais = null;
        BlackAsistxProd = null;
        PlatAsistxProd = null;
        AsistEnProc_Cero = null;
        AsistEnProc_1a2 = null;
        AsistEnProc_2a4 = null;
        AsistEnProc_4a8 = null;
        AsistEnProc_8a16 = null;
        AsistEnProc_16a24 = null;
        AsistEnProc_24a48 = null;
        AsistEnProc_48a72 = null;
        AsistEnProc_72Sup = null;
        Year2Date = null;
        AmarilloTENU = null;
        RojoTENU = null;
        AmarilloTENP = null;
        RojoTENP = null;
        VerdeCITAS = null;
        AmarilloCITAS = null;
        RojoCITAS = null;
        AmarilloTCONTAC = null;
        RojoTCONTAC = null;
        StrAsistConcluidas = null;
        StrAsistCanceladas = null;
        StrAsistNoCompletadas = null;
        StrAsistNoContactadas = null;
        StrAsistRegistradosMesAnt = null;
        StrAsistConcluidasMesAnt = null;
        StrAsistCanceladasMesAnt = null;
        StrAsistNoCompletadasMesAnt = null;
        StrAsistNoContactadasMesAnt = null;
        StrAsistRegistradosMesAct = null;
        StrAsistConcluidasMesAct = null;
        StrAsistCanceladasMesAct = null;
        StrAsistNoCompletadasMesAct = null;
        StrAsistNoContactadasMesAct = null;
        %>
        
        
    </body>
</html>
<script>
    function mueveReloj(){ 
        momentoActual = new Date() 
        anio = momentoActual.getYear() 
        mes = momentoActual.getMonth() + 1
        dia = momentoActual.getDate() 

        hora = momentoActual.getHours() 
        minuto = momentoActual.getMinutes() 
        segundo = momentoActual.getSeconds() 

        document.all.TIME_ANIO.value = anio 
        document.all.TIME_MES.value = mes 
        document.all.TIME_DIA.value = dia 
        
        document.all.TIME_SEG.value = segundo 
        document.all.TIME_MIN.value = minuto 
        document.all.TIME_HH.value = hora 

        setTimeout("mueveReloj()",1000) 
    } 
</script>