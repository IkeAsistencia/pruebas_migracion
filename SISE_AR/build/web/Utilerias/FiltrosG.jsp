<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Combos.cbEstatusExped,Combos.cbServicio,Combos.cbEntidad,UtlHash.Pagina,UtlHash.Filtro,java.util.List,UtlHash.LoadPagina,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.tmk.DAOGrafica,com.ike.model.to.PermisoGrafica" errorPage="" %>
<html>
    <head><title></title></head>
    <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">

    <body topmargin="5" leftmargin="5" background="../Imagenes/bgMenu.jpg" bgproperties="fixed">

        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <script src='Util.js'></script>
        <script src='UtilServicio.js'></script>
        <script src='UtilDireccion.js'></script>
        <script src='UtilMask.js'></script>
        <script src='UtilRefLlamadas.js'></script>
        <script src='UtilEspecialidad.js'></script>

        <%
            String clPaginaWeb = "0";
            String strclUsr = "0";



            if (session.getAttribute("clUsrApp")!= null){
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
        %>Fuera de Horario<%  return; 
            }

            MyUtil.InicializaParametrosC(3,Integer.parseInt(strclUsr));

            if (session.getAttribute("clPaginaWeb")==null){
                return;
            } else {
                clPaginaWeb = session.getAttribute("clPaginaWeb").toString();
            }
            StringBuffer strScript = new StringBuffer();
            StringBuffer strSentenciaArm = new StringBuffer();
            Pagina PaginaI=LoadPagina.getPagina(clPaginaWeb);
            DAOGrafica daos = new DAOGrafica();
            PermisoGrafica permisografica =  daos.getPermisoGrafica(clPaginaWeb);
            int iX=90;

        %>
        <form name='Form1' action='../<%=PaginaI.getStrNombrePaginaWeb()%>' target='<%=PaginaI.getStrTarget()%>' method='get'>
            <input name='Filtros' value='N' type='hidden'></input>
            <input name='P' value='<%=clPaginaWeb%>' type='hidden'></input>
            <%
            if(permisografica != null){
            if(permisografica.getPermiso().equalsIgnoreCase("1"))
            {
            %>
            <input name='I' value='1' type='hidden'></input>
    
            <%
                } else {
                %>
                <input name='I' value='0' type='hidden'></input>
            
            <%
                }
                }else{
            %>
            <input name='I' value='0' type='hidden'></input>
   
            <%        
                }

                if(PaginaI.getStrNombrePaginaWeb().compareToIgnoreCase("")!=0){
                    if(PaginaI.getStrNombrePaginaWebCSV().compareToIgnoreCase("")!=0){
            %>
            <table class='cssBGDet'><tr>
            <td><table><tr>
                <td class=''>Formato de Salida</td>
            </tr><tr>
            <td>
                <select onchange="if(this.value=='1'){Form1.action='<%=PaginaI.getStrNombrePaginaWeb()%>';}if(this.value=='2'){Form1.action='../<%=PaginaI.getStrNombrePaginaWebCSV()%>';}if(this.value=='3'){Form1.action='../<%=PaginaI.getStrNombrePaginaWebMail()%>'}" name='Formato' id ='Formato'>
                    <option value="1">Normal (limitado a 100)</option>
                    <option value="2">Excel (limitado a 100)</option>
                    <%
                        if (PaginaI.getStrNombrePaginaWebMail().compareToIgnoreCase("")!=0){
                    %>
                    <option value="3">Por Correo (No limitado)</option>
                    <%}%>
                </select>
            </td></tr></table></td><td>
                <%
                }
                }%>
                <P align='right'><input type='button' value='BUSCAR...' onClick='submit();window.close()' class='cBtn'></input></p>            
            </td></tr></table>
            <%
            List lstFiltros = null;
       
            lstFiltros = PaginaI.getLstFiltros();

            StringBuffer strParam = new StringBuffer();
            StringBuffer strCmp = new StringBuffer();
            String strValorDefault="";
            int iPosIni = 0;
            int iPosEnd = 0;
            int iC=0;
            int x=0;
            int xR = 1;

            if (lstFiltros !=null){
            for(x=0; x<lstFiltros.size(); x++, xR++)
            {
            Filtro  FiltroI = (Filtro)lstFiltros.get(x);
            strCmp.delete(0,strCmp.length());
            strParam.delete(0,strParam.length());
            strCmp.append(FiltroI.getStrParametros());
  
            iPosIni = 0;
            iPosEnd = 0;
            if (strCmp.toString().equalsIgnoreCase("")==false){
            iC=0;
            iPosIni = strCmp.indexOf("$",iPosIni);
            iPosEnd = strCmp.indexOf(",",iPosIni);
                  
            //Máximo número de filtros es 10, se hace por protección de que no se vaya a generar
            //algún problema de variable y resulte que el valor de iPosIni se pierda y se ejecute 
            //el while infinitamente causando que se pasme el equipo.
    
            while (iPosIni>=0 && iC<10){
            if (iPosEnd<0){
            iPosEnd = strCmp.length();
            }
                      
            if (iPosIni>=0){
            if (strParam.length()>0){
            strParam.append("','");
            }else{
            strParam.append("'");
            }
            if(session.getAttribute(strCmp.substring(iPosIni+1, iPosEnd))!=null){
            if (session.getAttribute(strCmp.substring(iPosIni+1, iPosEnd)).toString()==null){
            strParam.append("0");
            } else {
            strParam.append(session.getAttribute(strCmp.substring(iPosIni+1, iPosEnd)).toString());
            }
            }else{
            strParam.append("0");
            }
            if (iPosEnd==strCmp.length()){
            strCmp.delete(0,strCmp.length());
            } else {
            strCmp.delete(0,strCmp.length()).append(strCmp.substring(iPosEnd+1, strCmp.length()));
            }
            strParam.append("'");
            } else {
            iPosIni=iPosEnd;
            }
            iPosIni = strCmp.indexOf("$",iPosIni);
            iPosEnd = strCmp.indexOf(",",iPosIni);
            iC++;
            }
            }
            strCmp.delete(0,strCmp.length());
              
            if(FiltroI.getStrTipoFiltro().equalsIgnoreCase("InputText")){
            if (FiltroI.getStrBusquedaRef().compareTo("")==0){
            strScript.append("document.all.").append(FiltroI.getStrVarVal()).append(".readOnly=false;\n");
            if (FiltroI.getStrValorDefault().compareToIgnoreCase("")!=0){
            if (session.getAttribute(FiltroI.getStrValorDefault())!=null){
            strValorDefault =session.getAttribute(FiltroI.getStrValorDefault()).toString();
            }
            else{
            strValorDefault="";
            }
            }
            else{
            strValorDefault="";
            }
  
            if (FiltroI.getStrMask().compareToIgnoreCase("")==0){
            %><%=MyUtil.ObjInput(FiltroI.getStrdsFiltroWeb(),FiltroI.getStrVarVal(),strValorDefault,true,true,20,iX,"",true,true,35)%>
            <%
                }else{
            %><%=MyUtil.ObjInput(FiltroI.getStrdsFiltroWeb(),FiltroI.getStrVarVal(),strValorDefault,true,true,20,iX,"",true,true,35,"if(this.readOnly==false){fnValMask(this,document.all."+ FiltroI.getStrVarVal() + "Msk.value,this.name)}")%>
            <input name='<%=FiltroI.getStrVarVal()%>Msk' id='<%=FiltroI.getStrVarVal()%>Msk' type='hidden' value='<%=FiltroI.getStrMask()%>'>
            <%
                }
                } else{
                    //strScript.append("document.all.").append(strCampoValor).append("V.readOnly=false;\n");

                    if (strValorDefault!=null){
                        if (session.getAttribute(strValorDefault)!=null){
                            strValorDefault =session.getAttribute(FiltroI.getStrValorDefault()).toString();
                        } else{
                            strValorDefault="";
                        }
                    } else{
                        strValorDefault="";
                    }
                %>
                <input type='hidden' id='<%=FiltroI.getStrVarVal()%>' name='<%=FiltroI.getStrVarVal()%>'>
                <%
            if (FiltroI.getStrMask().compareToIgnoreCase("")==0){
            %><%=MyUtil.ObjInput(FiltroI.getStrdsFiltroWeb(),FiltroI.getStrVarVal()+"V",strValorDefault,true,true,20,iX,"",true,true,35)%>
            <%
                }else{
            %><%=MyUtil.ObjInput(FiltroI.getStrdsFiltroWeb(),FiltroI.getStrVarVal()+"V",strValorDefault,true,true,20,iX,"",true,true,35,"if(this.readOnly==false){fnValMask(this,document.all."+ FiltroI.getStrVarVal() + "Msk.value,this.name)}")%>
            <input name='<%=FiltroI.getStrVarVal()%>Msk' id='<%=FiltroI.getStrVarVal()%>Msk' type='hidden' value='<%=FiltroI.getStrMask()%>'>
                            <%
            }
            %><div class='VTable' style='position:absolute; z-index:25; left:200px; top:<%=iX+15%>px;'><img WIDTH=20 HEIGHT=20 src='../Imagenes/Lupa.gif' class='handM' onClick="fnBuscaGral('<%=FiltroI.getStrBusquedaRef()%>')"></img></div>
            <%
                    }
            }
            
                         if(FiltroI.getStrTipoFiltro().equalsIgnoreCase("Combo")){
                             strScript.append("document.all.").append(FiltroI.getStrVarVal()).append("C.disabled=false;\n");
                             if (FiltroI.getStrValorDefault().compareToIgnoreCase("")!=0){
                                 if (session.getAttribute(strValorDefault)!=null){
                                     strValorDefault =session.getAttribute(FiltroI.getStrValorDefault()).toString();
                                 } else{
                                     strValorDefault=FiltroI.getStrVarVal();
                                 }
                             } else{
                                 strValorDefault=FiltroI.getStrVarVal();
                             }

                             strSentenciaArm.delete(0,strSentenciaArm.length());
                             strSentenciaArm.append(FiltroI.getStrSentencia() + strParam);

                             %><%=MyUtil.ObjComboC(FiltroI.getStrdsFiltroWeb(),FiltroI.getStrVarVal(),strValorDefault,true,true,20,iX,"",strSentenciaArm.toString(),FiltroI.getStrfnOnChange(),"",30,true,true)%>
                             <%
                         }

                         if(FiltroI.getStrTipoFiltro().equalsIgnoreCase("ComboMem")){
strScript.append("document.all.").append(FiltroI.getStrVarVal()).append("C.disabled=false;\n");
            if (FiltroI.getStrValorDefault().compareToIgnoreCase("")!=0){
            if (session.getAttribute(FiltroI.getStrValorDefault())!=null){
            strValorDefault =session.getAttribute(FiltroI.getStrValorDefault()).toString();
            }
            else{
            strValorDefault=FiltroI.getStrVarVal();
            }
            }
            else{
            strValorDefault=FiltroI.getStrVarVal();
            }
            if (FiltroI.getStrClass().compareToIgnoreCase("cbEntidad")==0){
            %>
            <%=MyUtil.ObjComboMem(FiltroI.getStrdsFiltroWeb(),FiltroI.getStrVarVal(),"","",cbEntidad.GeneraHTML(30,""),true,true,20,iX,"",FiltroI.getStrfnOnChange(),"",30,false,false)%>                
            <%
            }
            if (FiltroI.getStrClass().compareToIgnoreCase("cbServicio")==0){
            %>
            <%=MyUtil.ObjComboMem(FiltroI.getStrdsFiltroWeb(),FiltroI.getStrVarVal(),"","",cbServicio.GeneraHTML(30,""),true,true,20,iX,"",FiltroI.getStrfnOnChange(),"",30,false,false)%>                
            <%
                }
    if (FiltroI.getStrClass().compareToIgnoreCase("cbSubServicioVTR")==0){
            %>
            <%=MyUtil.ObjComboMem(FiltroI.getStrdsFiltroWeb(),FiltroI.getStrVarVal(),"","",cbServicio.GeneraHTMLSub(30,"",""),true,true,20,iX,"",FiltroI.getStrfnOnChange(),"",30,false,false)%>                
            <%
                }
    if (FiltroI.getStrClass().compareToIgnoreCase("cbEstatusExped")==0){
            %>
                            <%=MyUtil.ObjComboMem(FiltroI.getStrdsFiltroWeb(),FiltroI.getStrVarVal(),"","",cbEstatusExped.GeneraHTML(30,""),true,true,20,iX,"",FiltroI.getStrfnOnChange(),"",30,false,false)%>                
                <%
            }

                  

                }

                if(FiltroI.getStrTipoFiltro().compareToIgnoreCase("")!=0){
                    iX+=40;
                }
                }
                strValorDefault=null;


                %><%=MyUtil.DoBlock("Filtros de B&uacute;squeda",60,0)%>
                </form>
                <%
}
        iX+=100;
        %><script><%=strScript.toString()%>;window.resizeTo(300,<%=iX%>);</script>
        <%
        strScript.delete(0,strScript.length());
        try{
      
        }catch(Exception e){
        }


        //try
    
        /*			switch ($row[2]) {
        case "combo" : 
        if ($HTTP_SESSION_VARS[$row[1]]!=""){
        $VarDefault = $HTTP_SESSION_VARS[$row[1]];
        }
        else {
        $varval=substr($row[6], 0,1);
        if ($varval == '$') { 
								$VarDefault = $HTTP_SESSION_VARS[substr($row[6],1,strlen($row[6]))];
        }
        else{
								$VarDefault = $row[6];																		
        }
        }
        $row[5] != "" ? $fnAdicional = trim($row[5]) : $fnAdicional = "";
						
        $strScript = $strScript . "document.all." . $row[1] . ".disabled=false;\n";			
        echo "<tr><td colspan='2' class='clsTitle'><strong>".$row[0]."</strong></td></tr>";
        echo "<tr><td colspan='2' class='cssRow2'>";
        $SEACN->fnCreateComboKey($VarDefault,$row[1],"","","",$row[3]." ".$strParam,"true",40,"cssInputText","false","false", "", $fnAdicional, "", "");
        echo "</td></tr>";
        break;
        case "Periodo" :										
        echo "<tr><td class='clsTitle'><strong>Fecha Inicial</strong></td>";
        echo "     <td class='clsTitle'><strong>Fecha Final</strong></td>";
        echo "</tr> ";
        echo "<tr> <td>";
        echo $SEACN->fnCreateDtPickJS($row[6],'FechaInicio','false','false','',50,110,1);
        echo "</td><td>";
        echo $SEACN->fnCreateDtPickJS($row[6],'FechaFin',"false","false",'',50,110,1);
        echo "</td>";
        echo "</tr>";
        $strPeriodoscript = 'document.all.FechaInicio.disabled=false;document.all.FechaFin.disabled=false;';
        break;
						
        //	Se agrega el objeto checkbox porque en los filtros de la gráfica hay un checkbox usado para
        //  determinar si el usuario quiere que aparezca la caja de leyenda en la gráfica.
        case "CheckBox" :
        if ($HTTP_SESSION_VARS[$row[1]]!=""){
        $VarDefault = $HTTP_SESSION_VARS[$row[1]];
        }
        else {
        $varval=substr($row[6], 0,1);
        if ($varval == '$') { 
								$VarDefault = $HTTP_SESSION_VARS[substr($row[6],1,strlen($row[6]))];
        }
        else{
								$VarDefault = $row[6];																		
        }
        }
											
        $row[5] != "" ? $fnAdicional = trim($row[5]) : $fnAdicional = "";
						
        $strScript = $strScript . "document.all." . $row[1] . ".disabled=false;\n";			
        echo "<tr><td colspan='2' class='clsTitle'><strong>".$row[0]."</strong></td></tr>";
        echo "<tr><td colspan='2' class='cssRow2'>";
        $SEACN->fnCreateChkBox($VarDefault,$row[1], "SI", "NO", "false", "cssInputText","false","false","0",$fnAdicional, "","");
        echo "</td></tr>";
        break;
								
        }
        }
	
        echo "<input name='Filtros' value='Y' type='hidden'></input>";
        echo "<tr align='center'> ";
		
        echo "    <td colspan='2'> <br> ";
        echo "       <input type='button' onClick='".$strPeriodoscript."submit();";
        if ($CloseOnAccept=='Y'){
        echo "top.close()";
        }
        echo "' value='Buscar'> ";
        echo "       <input type='button' onClick='top.close()' value='Cancelar'> ";
        echo "    </td>";
        echo "</tr>";
        echo "</table>";
        echo " </form>";
	
        echo "<script>";
        echo $strScript; 
        //	echo "window.resizeTo(315,388);";	
        $TotalWidth = $NumRows * 50 + 177;
        echo "window.resizeTo(300,". $TotalWidth .");";		
        echo "		 function fnGetParams(){";
        echo "       }";	
        echo "</script>";
		
        $SEACN->CloseCN();*/

        %>

    </body>
</html>