<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Utilerias.CamposExtra,java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script> 
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrclExpediente = "";
        String strclUsr = "";
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente= session.getAttribute("clExpediente").toString();
        }
        
        // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
        StringBuffer StrSql = new StringBuffer();
        StrSql.append(" Select exped.TieneAsistencia, ");
        StrSql.append(" EXPED.CodEnt, E.dsEntFed, EXPED.CodMD, D.dsMunDel, EXPED.clCuenta ");
        StrSql.append(" From Expediente EXPED");
        StrSql.append(" LEFT JOIN cEntFed E ON(E.CodEnt = EXPED.CodEnt) ");
        StrSql.append(" LEFT JOIN cMunDel D ON(E.CodEnt = D.CodEnt and D.CodMD=EXPED.CodMD) ");
        StrSql.append(" Where clExpediente=").append(StrclExpediente);
        
        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        if (rs2.next())
        {
            
            StrSql.append(" select A.clExpediente, ");
            StrSql.append(" coalesce(A.UbicacionFalla,'') UbicacionFalla, ");
            StrSql.append(" coalesce(A.DescripcionFalla,'') DescripcionFalla, ");
            StrSql.append(" coalesce(A.Solucion,'') Solucion, ");
            StrSql.append(" coalesce(A.Observaciones,'') Observaciones, ");
            StrSql.append(" A.EsProgramado, coalesce(convert(varchar(16),A.FechaProgMom,120),'') FechaProgMom, ");
            StrSql.append(" A.CodEnt, coalesce(E.dsEntFed,'') dsEntFed, A.CodMD, ");
            StrSql.append(" coalesce(D.dsMunDel,'') dsMunDel, coalesce(A.Colonia,'') Colonia , ");
            StrSql.append(" coalesce(A.Calle,'') Calle, ");
            StrSql.append(" cast(coalesce(A.Referencias,'') as varchar(8000)) Referencias, ");
            StrSql.append(" coalesce(A.CP,'') CP, ");
            StrSql.append(" coalesce(A.clSucursalPH,'') clSucursalPH, ");
            StrSql.append(" coalesce(SP.dsSucursalPH,'') dsSucursalPH, ");
            StrSql.append(" coalesce(A.clTipoSolucion,'') clTipoSolucion, ");
            StrSql.append(" case when A.clTipoSolucion = 0 then 'OTRO' else coalesce(CC.dsConcepto,'') end  dsTipoSolucion, ");
            StrSql.append(" coalesce(A.Verificador,'') Verificador ");
            StrSql.append(" FROM A_PC A ");
            StrSql.append(" left join cConceptoCosto CC on (CC.clConcepto=A.clTipoSolucion)");
            StrSql.append(" LEFT JOIN cEntFed E ON(E.CodEnt = A.CodEnt) ");
            StrSql.append(" LEFT JOIN cMunDel D ON(E.CodEnt = D.CodEnt and D.CodMD=A.CodMD) ");
            StrSql.append(" LEFT JOIN cSucursalPH SP ON (A.clSucursalPH = SP.clSucursalPH) ");
            StrSql.append(" Where A.clExpediente= ").append(StrclExpediente);
            
        }
        else
        {
        
        %><%="El expediente no existe"%><%
        rs2.close();
        rs2=null;
        
        return;
        }
        
        
        String StrclPaginaWeb = "766";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        %>
        <SCRIPT>fnOpenLinks()</script> 
        <%          ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        StrSql=null;
        
        MyUtil.InicializaParametrosC(766,Integer.parseInt(strclUsr)); 
        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","","fnAntesGuardar();")%><%
        if(rs2.getString("TieneAsistencia").compareToIgnoreCase("1")==0)
        {
        %><script>document.all.btnAlta.disabled=true;</script><%
        }
        else
        {
        %><script>document.all.btnCambio.disabled=true;</script><%
        }
        
        %><%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleAPC.jsp?'>"%>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%if (rs.next()) {
        %><%=MyUtil.ObjTextArea("Ubicación de la Falla","UbicacionFalla",rs.getString("UbicacionFalla"),"50","3",true,true,30,80,"",true,true)%>
        <%=MyUtil.ObjTextArea("Descripción de la Falla","DescripcionFalla",rs.getString("DescripcionFalla"),"50","3",true,true,420,80,"",true,true)%>
        <%=MyUtil.ObjTextArea("Descripcion Solución","Solucion",rs.getString("Solucion"),"50","3",true,true,30,180,"",false,false)%>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"),"50","3",true,true,420,140,"",true,true)%>
        <%=MyUtil.ObjComboC("Tipo solucion","clTipoSolucion",rs.getString("dsTipoSolucion"),true,true,30,140,"","select 0 'clConcepto', 'OTRO' 'dsConcepto' union select clConcepto,dsConcepto from cConceptoCosto where clAreaOperativa = 6 and Codigo='APC' order by dsConcepto","fnHabilitaSolucion()","",50,true,true)%>
        <%=MyUtil.ObjChkBox("Cita Programada","EsProgramado",rs.getString("EsProgramado"),true,true,410,200,"0","fnFechaProg()")%>
        <%=MyUtil.ObjInput("Fecha Programada<br>(aaaa/mm/dd hh:mm)","FechaProgMom",rs.getString("FechaProgMom"),true,true,560,200,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaProgMomMsk.value,this.name)};")%>
        <%=MyUtil.ObjInput("Verificador","Verificador",rs.getString("Verificador"),false,false,30,240,"",false,false,20,"")%>
        <%=MyUtil.DoBlock("Datos Generales de la Asistencia PC's",0,0)%>
        <div class='VTable' style='position:absolute; z-index:25; left:100px; top:350px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%=rs.getString("CodEnt")%>'>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed",rs.getString("dsEntFed"),false,false,190,340,"",false,false,50)%>               
        <INPUT id='CodMD' name='CodMD' type='hidden' value='<%=rs.getString("CodMD")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel",rs.getString("dsMunDel"),false,false,30,390,"",false,false,50)%>                
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",rs.getString("Colonia"),false,false,300,390,"",false,false,50)%>               
        <%=MyUtil.ObjInput("Calle","Calle",rs.getString("Calle"),true,true,30,425,"",false,false,50)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales","Referencias",rs.getString("Referencias"),"70","5",true,true,30,465,"",true,true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP",rs.getString("CP"),false,false,30,340,"",false,false,10)%>
        <%=MyUtil.DoBlock("Domicilio",100,50)%><%
        }
        else
        {
        %><%=MyUtil.ObjTextArea("Ubicación de la Falla","UbicacionFalla","","50","3",true,true,30,80,"",true,true)%>
        <%=MyUtil.ObjTextArea("Descripción de la Falla","DescripcionFalla","","50","3",true,true,420,80,"",true,true)%>
        <%=MyUtil.ObjTextArea("Descripcion Solución","Solucion","","50","3",true,true,30,180,"",false,false)%>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","50","3",true,true,420,140,"",true,true)%>
        <%=MyUtil.ObjComboC("Tipo solucion","clTipoSolucion","",true,true,30,140,"","select 0 'clConcepto', 'OTRO' 'dsConcepto' union select clConcepto,dsConcepto from cConceptoCosto where clAreaOperativa = 6 and Codigo='APC' order by dsConcepto","fnHabilitaSolucion()","",50,true,true)%>
        <%=MyUtil.ObjChkBox("Cita Programada","EsProgramado","",true,true,410,200,"0","fnFechaProg()")%>
        <%=MyUtil.ObjInput("Fecha Programada<br>(aaaa/mm/dd hh:mm)","FechaProgMom","",true,true,560,200,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaProgMomMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Verificador","Verificador","",false,false,30,240,"",false,false,20,"")%>
        <%=MyUtil.DoBlock("Datos Generales de la Asistencia Hogar",0,0)%>                     
        <div class='VTable' style='position:absolute; z-index:25; left:100px; top:350px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed","",false,false,190,340,"",false,false,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel","",false,false,30,390,"",false,false,50)%>                
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",false,false,300,390,"",false,false,50)%>                
        <%=MyUtil.ObjInput("Calle","Calle","",true,true,30,425,"",false,false,50)%>     
        <%=MyUtil.ObjTextArea("Referencias Visuales","Referencias","","70","5",true,true,30,465,"",true,true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP","",false,false,30,340,"",false,false,10)%>
        <%=MyUtil.DoBlock("Domicilio",100,50)%>
        <% } %>	
        <%	        
        String strclCuenta="0";
        if(session.getAttribute("clCuenta")!=null)
        {
            strclCuenta = session.getAttribute("clCuenta").toString();
        }
        String StrclSubservicio="0";
        
        if (session.getAttribute("clSubServicio")!= null)
        {
            StrclSubservicio = session.getAttribute("clSubServicio").toString();
            
        }
       
        System.out.print(StrclSubservicio);
        rs2.close();
        rs.close();
        rs2=null;
        rs=null;
        StrSql=null;
        
        strclCuenta = null;
        StrclExpediente = null;
        strclUsr = null;
        StrclPaginaWeb=null;
        %>
        
        
        
        <%=MyUtil.GeneraScripts()%>
        <input name='FechaProgMomMsk' id='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <script>
document.all.FechaProgMom.disabled=true;

if (document.all.clTipoSolucion.value!=0)
{
 document.all.Solucion.style.visibility='hidden';
}

function fnHabilitaSolucion()
{

 if (document.all.clTipoSolucion.value==0)
 {
  document.all.Solucion.style.visibility='';
 }
 else
 {
  document.all.Solucion.value=''; 
  document.all.Solucion.style.visibility='hidden';
 }
}

function fnFechaProg(){
    if (document.all.EsProgramado.value==1){
        document.all.FechaProgMom.disabled=false;
        //document.all.FechaProgMom.value=""; 
        }else{ 
        if (document.all.EsProgramado.value==0){
            document.all.FechaProgMom.disabled=true;
            document.all.FechaProgMom.value="";
            
                }
            }
     }

     function fnAntesGuardar()
     {
      if(document.all.EsProgramado.value==1)
      {
       if(document.all.FechaProgMom.value=="")
       {
        msgVal=msgVal + " Fecha Programada ";
       document.all.btnGuarda.disabled=false;
       document.all.btnCancela.disabled=false;       

       }
      } 
      
      if (document.all.clTipoSolucion.value==0 && document.all.Solucion.value=="")
      {
       msgVal=msgVal + " Falta informar la descripción solucion ";
       document.all.btnGuarda.disabled=false;
       document.all.btnCancela.disabled=false;       
      }
     
     }
        </script>
        
    </body>
</html>


