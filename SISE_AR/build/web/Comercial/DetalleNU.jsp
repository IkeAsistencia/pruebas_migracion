<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src='../Utilerias/UtilAuto.js' ></script>
        <script src='../Utilerias/UtilDireccion.js' ></script>
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrclAfiliado = "0";
        String StrclContrato = "0";
        String StrclCuenta = "0";
        String strclUsr = "0";
        String StrIncisoMax="0";
        String StrFechFin = "";
        
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if (request.getParameter("clAfiliado")!= null)
        {
            StrclAfiliado= request.getParameter("clAfiliado").toString();
        }
        if(StrclAfiliado.compareToIgnoreCase("0")==0)
        {
            if (session.getAttribute("clAfiliado")!= null)
            {
                StrclAfiliado= session.getAttribute("clAfiliado").toString();
            }
        }
        
        
        if (session.getAttribute("clContrato")!= null)
        {
            StrclContrato= session.getAttribute("clContrato").toString();
        }
        
        if (session.getAttribute("clCuenta")!= null)
        {
            StrclCuenta= session.getAttribute("clCuenta").toString();
        }
        
        StringBuffer StrSqlI = new StringBuffer();
        StrSqlI.append(" Select convert(varchar(10),CC.FechaFin,120) as FechaFin from ContratoxCuenta CC ");
        StrSqlI.append(" where CC.clContrato=").append(StrclContrato).append(" and CC.clcuenta=").append(StrclCuenta);
        /*StrSqlI.append(" Select Max(Inciso)+1 as Inciso ");
        StrSqlI.append(" From cAfiliado");
        StrSqlI.append(" Where clContrato = ").append(StrclContrato);
        StrSqlI.append(" and clCuenta = ").append(StrclCuenta);
        StrSqlI.append(" group by clCuenta ");
         */
        ResultSet rsFechFin = UtileriasBDF.rsSQLNP( StrSqlI.toString());
        StrSqlI.delete(0,StrSqlI.length());
        if (rsFechFin.next())
        {
            StrFechFin = rsFechFin.getString("FechaFin");
        }
        /*if (rsInciso.next()) {
        StrIncisoMax = rsInciso.getString("Inciso");
        }*/
        
        StringBuffer StrSql = new StringBuffer();
        
        StrSql.append(" Select ");
        StrSql.append(" coalesce(A.Nombre,'') as Nombre, ");
        StrSql.append(" coalesce(convert(varchar(10),A.FechaIni,120),'') as FechaIni, ");
        StrSql.append(" coalesce(convert(varchar(10),A.FechaFin,120),'') as  FechaFin,");
        StrSql.append(" coalesce(A.Clave,'') as Clave,");
        StrSql.append(" coalesce(A.Inciso,'0') as Inciso,");
        StrSql.append(" coalesce(convert(varchar(16),A.FechaAlta,120),'') as  FechaAlta,");
        StrSql.append(" coalesce(convert(varchar(16),A.FechaBaja,120),'') as  FechaBaja,");
        StrSql.append(" A.Activo,  ");
        StrSql.append(" coalesce(AI.Color,'') as Color, ");
        StrSql.append(" coalesce(AI.Placas,'') as  Placas, ");
        StrSql.append(" coalesce(AI.Serie,'') as Serie, ");
        StrSql.append(" coalesce(AI.NoMotor,'') as NoMotor, ");
        StrSql.append(" coalesce(AI.Modelo,'') as Modelo,");
        StrSql.append(" coalesce(AI.DescAuto,'') as DescAuto,");
        StrSql.append(" coalesce(M.dsMarcaAuto,'') as dsMarcaAuto,");
        StrSql.append(" coalesce(T.dsTipoAuto,'') as dsTipoAuto, ");
        StrSql.append(" coalesce(AI.CodigoMarca,'') as CodigoMarca, ");
        StrSql.append(" coalesce(AI.ClaveAMIS,'') as ClaveAMIS, ");
        StrSql.append(" coalesce(AI.Licencia,'') as Licencia, ");
        StrSql.append(" coalesce(EFD.dsEntFed,'') as dsEntFed, ");
        StrSql.append(" coalesce(AI.CodEnt,'') as CodEnt,");
        StrSql.append(" coalesce(DD.dsMunDel,'') as dsMunDel, ");
        StrSql.append(" coalesce(AI.CodMD,'') as CodMD, ");
        StrSql.append(" coalesce(AI.Colonia,'') as Colonia, ");
        StrSql.append(" coalesce(AI.Calle,'') as Calle, ");
        StrSql.append(" coalesce(AI.CP,'') as CP ");
        StrSql.append(" from cAfiliado A ");
        StrSql.append(" Left join AfiliadoInfoAdicional AI on (AI.clAfiliado=A.clAfiliado) ");
        StrSql.append(" left join cMarcaAuto M ON (M.CodigoMarca = AI.CodigoMarca) ");
        StrSql.append(" left join cTipoAuto T ON (T.CodigoMarca = AI.CodigoMarca AND T.ClaveAMIS = AI.ClaveAMIS) ");
        StrSql.append(" left JOIN cEntFed EFD ON(EFD.CodEnt = AI.CodEnt) ");
        StrSql.append(" left JOIN cMunDel DD ON(EFD.CodEnt = DD.CodEnt and DD.CodMD=AI.CodMD) ");
        StrSql.append(" Where A.clAfiliado=").append(StrclAfiliado);
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        String StrclPaginaWeb = "175";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <SCRIPT>fnCloseLinks()</script>
        <script>fnOpenLinks(window.parent.frames.InfoRelacionada.height) </script>
        <%
        MyUtil.InicializaParametrosC( 175,Integer.parseInt(strclUsr)); 
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAltaAfiliado","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleNU.jsp?'>"%>
        <%
        if (rs.next())
        {
        %>
        <INPUT id='clAfiliado' name='clAfiliado' type='hidden' value='<%=StrclAfiliado%>'>
        <INPUT id='clContrato' name='clContrato' type='hidden' value='<%=StrclContrato%>'>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'>
        <INPUT id='IncisoMax' name='IncisoMax' type='hidden' value='<%=StrIncisoMax%>'>
        
        <%=MyUtil.ObjInput("Nuestro Usuario","Nombre",rs.getString("Nombre"),true,true,25,80,"",true,true,30)%>
        <%=MyUtil.ObjInput("Fecha Inicial<BR>AAAA/MM/DD ","FechaIni",rs.getString("FechaIni"),true,true,25,120,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha Final<BR>AAAA/MM/DD ","FechaFin",rs.getString("FechaFin"),true,true,200,120,StrFechFin,true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Clave","Clave",rs.getString("Clave"),true,true,25,180,"",true,true,30)%>
        <%=MyUtil.ObjInput("Inciso","Inciso",rs.getString("Inciso"),true,true,200,180,"",true,true,20)%>
        <%=MyUtil.ObjChkBox("Automatico","AutomaticoVTR","",true,false,350,180,"0","SI","NO","fnMaxAfil()")%>
        
        <%=MyUtil.ObjInput("Fecha Alta<BR>AAAA/MM/DD HH:MM","FechaAlta",rs.getString("FechaAlta"),false,false,25,230,"",false,false,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaAfiliadoMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha Baja<BR>AAAA/MM/DD HH:MM","FechaBaja",rs.getString("FechaBaja"),false,false,200,230,"",false,false,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaAfiliadoMsk.value,this.name)}")%>
        <%=MyUtil.ObjChkBox("Activo","Activo",rs.getString("Activo"), true,true,25,310,"1","SI","NO","")%>
        <%=MyUtil.DoBlock("Detalle de Nuestro Usuario",25,0)%>
        
        <%=MyUtil.ObjInput("Color","Color",rs.getString("Color"),true,true,30,400,"",false,false,30)%>
        <%=MyUtil.ObjInput("Placas","Placas",rs.getString("Placas"),true,true,200,400,"",false,false,20)%>
        <%=MyUtil.ObjInput("Serie","Serie",rs.getString("Serie"),true,true,380,400,"",false,false,20)%>
        <%=MyUtil.ObjInput("No de Motor","NoMotor",rs.getString("NoMotor"),true,true,30,450,"",false,false,30)%>
        <%=MyUtil.ObjInput("Modelo","Modelo",rs.getString("Modelo"),true,true,200,450,"",false,false,30)%>
        <%=MyUtil.ObjInput("Descripcion de Auto","DescAuto",rs.getString("DescAuto"),true,true,380,450,"",false,false,30)%>
        <%=MyUtil.ObjComboC("Marca", "CodigoMarca", rs.getString("dsMarcaAuto"),true,true,30,500,"","Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto","fnLlenaAMIS()","",60,false,false)%>
        <%=MyUtil.ObjComboC("Tipo de Auto", "ClaveAMIS",rs.getString("dsTipoAuto"),true,true,230,500,"","Select ClaveAMIS, dsTipoAuto From cTipoAuto Where CodigoMarca=' "+ rs.getString("CodigoMarca") +"' Order by dsTipoAuto","fnActualizaAMIS()","",100,false,false)%>
        <%=MyUtil.ObjInput("Clave AMIS","ClaveAMISVTR",rs.getString("ClaveAMIS"), false,false,30,550,"",false,false,15)%>
        <%=MyUtil.ObjInput("Licencia","Licencia",rs.getString("Licencia"), true,true,230,550,"",false,false,30)%>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed",rs.getString("dsEntFed"),false,false,30,600,"",false,false,50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%=rs.getString("CodEnt")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel",rs.getString("dsMunDel"),false,false,380,600,"",false,false,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value='<%=rs.getString("CodMD")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",rs.getString("Colonia"),false,false,30,640,"",false,false,40)%>
        <%=MyUtil.ObjInput("Calle y Número","Calle",rs.getString("Calle"),true,true,380,640,"",false,false,50)%>
        <div class='VTable' style='position:absolute; z-index:25; left:280px; top:650px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaCP2();' class='cBtn'></div>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP",rs.getString("CP"),true,true,30,690,"",false,false,10)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value='<%=rs.getString("CodMD")%>'>
        <%=MyUtil.DoBlock("Información adicional de Nuestro Usuario",100,50)%>
        
        <%
        }
        else
        {
        %>
        <INPUT id='clAfiliado' name='clAfiliado' type='hidden' value='<%=StrclAfiliado%>'>
        <INPUT id='clContrato' name='clContrato' type='hidden' value='<%=StrclContrato%>'>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'>
        <INPUT id='IncisoMax' name='IncisoMax' type='hidden' value='<%=StrIncisoMax%>'>
        
        <%=MyUtil.ObjInput("Nuestro Usuario","Nombre","",true,true,25,80,"",true,true,30)%>
        <%=MyUtil.ObjInput("Fecha Inicial<BR>AAAA/MM/DD","FechaIni","",true,true,25,120,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha Final<BR>AAAA/MM/DD","FechaFin","",true,true,200,120,StrFechFin,true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Clave","Clave","",true,true,25,170,"",true,true,30)%>
        <%=MyUtil.ObjInput("Inciso","Inciso","",true,true,200,170,"",true,true,22)%>
        <%=MyUtil.ObjChkBox("Automatico","AutomaticoVTR","",true,true,350,180,"0","SI","NO","fnMaxAfil()")%>
        <%=MyUtil.ObjInput("Fecha Alta<BR>AAAA/MM/DD HH:MM","FechaAlta","",false,false,25,230,"",false,false,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaAfiliadoMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha Baja<BR>AAAA/MM/DD HH:MM","FechaBaja","",false,false,200,230,"",false,false,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaAfiliadoMsk.value,this.name)}")%>
        <%=MyUtil.ObjChkBox("Activo","Activo","", true,true,25,310,"1","SI","NO","")%>
        <%=MyUtil.DoBlock("Detalle de Nuestro Usuario",25,0)%>
        
        <%=MyUtil.ObjInput("Color","Color","",true,true,30,400,"",false,false,30)%>
        <%=MyUtil.ObjInput("Placas","Placas","",true,true,200,400,"",false,false,30)%>
        <%=MyUtil.ObjInput("Serie","Serie","",true,true,380,400,"",false,false,30)%>
        <%=MyUtil.ObjInput("No de Motor","NoMotor","",true,true,30,450,"",false,false,30)%>
        <%=MyUtil.ObjInput("Modelo","Modelo","",true,true,200,450,"",false,false,30)%>
        <%=MyUtil.ObjInput("Descripcion de Auto","DescAuto","",true,true,380,450,"",false,false,30)%>
        <%=MyUtil.ObjComboC("Marca", "CodigoMarca", "",true,true,30,500,"","Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto","fnLlenaAMIS()","",60,false,false)%>
        <%=MyUtil.ObjComboC("Tipo de Auto", "ClaveAMIS","",true,true,230,500,"","Select ClaveAMIS, dsTipoAuto From cTipoAuto Where CodigoMarca='0' Order by dsTipoAuto","fnActualizaAMIS()","",100,false,false)%>
        <%=MyUtil.ObjInput("Clave AMIS","ClaveAMISVTR","", false,false,30,550,"",false,false,15)%>
        <%=MyUtil.ObjInput("Licencia","Licencia","", true,true,230,550,"",false,false,30)%>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed","",false,false,30,600,"",false,false,50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel","",false,false,380,600,"",false,false,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",false,false,30,640,"",false,false,40)%>
        <%=MyUtil.ObjInput("Calle y Número","Calle","",true,true,380,640,"",false,false,50)%>
        <div class='VTable' style='position:absolute; z-index:25; left:280px; top:650px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaCP2();' class='cBtn'></div>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP","",true,true,30,690,"",false,false,10)%>
        <%=MyUtil.DoBlock("Información adicional de Nuestro Usuario",100,50)%>
        
        
        
        <%
        }
        rsFechFin.close();
        rsFechFin = null;
        rs.close();
        rs=null;
        
        StrclPaginaWeb = null;
        StrclAfiliado = null;
        StrclContrato = null;
        StrclCuenta = null;
        strclUsr = null;
        StrFechFin=null;
        StrSql = null;
        StrSqlI = null;
        %>
        <%=MyUtil.GeneraScripts()%>
        <input id='clUsrAppAut' type='hidden' name='clUsrAppAut'></input>
        <input id='MotivoAut' type='hidden' name='MotivoAut'></input>
        <input name='ClaveMsk' id='ClaveMsk' type='hidden' value=''>
        <input name='FechaAfiliadoMsk' id='FechaAfiliadoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <input name='AgenteMsk' id='AgenteMsk' type='hidden' value='VN09VN09VN09VN09'>
        <script>
function fnLlenaAMIS(){  
		var strConsulta = "sp_GetClaveAMIS '" + document.all.CodigoMarca.value + "'";
		var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                document.all.ClaveAMIS.value = '';
		pstrCadena = pstrCadena + "&strName=ClaveAMISC";		
		fnOptionxDefault('ClaveAMISC',pstrCadena); 
	}
	
function fnBuscaColoniaCP2(){
                if (document.all.btnGuarda.disabled==false){ 
                   var pstrCadena = "../Utilerias/FiltrosDireccion.jsp?strSQL=sp_WebBuscaDir 1,'','" + document.all.Colonia.value + "','" + document.all.CodEnt.value + "'";
                   pstrCadena = pstrCadena + "&Colonia=&CodMd=&dsMunDel=&CodEnt=&dsEntFed=&Tipo=1";
                   window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1');
                  } 
                }

function fnMaxAfil()
{
 if(document.all.AutomaticoVTR.value==1){
  document.all.Inciso.value=0;
  document.all.Inciso.disabled=true;
    
  }
else{
  document.all.Inciso.disabled=false;
  document.all.Inciso.value="";
  
  }
}

/*function fnIncisoAuto(){
             if (document.all.AutomaticoVTR.value==1){ 
             document.all.Inciso.value = document.all.IncisoMax.value; 
             //document.all.Inciso.disabled = true;
             //alert ("Hola");
             }else{
                if (document.all.AutomaticoVTR.value==0){ 
                document.all.Inciso.value = "";
                }
             
             }
}*/
        </script>
    </body>
</html>
