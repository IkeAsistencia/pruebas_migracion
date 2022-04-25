<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
<script src='../Utilerias/UtilMask.js'></script>
<%  
        String strclSupervision ="0"; 
    	String StrclExpediente = "0";
        String StrclCuenta = "0";
    	String strclUsr = "0";
        String StrclEstudioMercado="0";
        String StrclConcesionario="0";
        int i = 80;
        int j = 1;
        int x = 50;

      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  

        if (session.getAttribute("clExpediente")!= null)
            {
                StrclExpediente= session.getAttribute("clExpediente").toString(); 
            }  
        
        if (session.getAttribute("clCuenta")!= null)
            {
                StrclCuenta= session.getAttribute("clCuenta").toString(); 
            }  
     StringBuffer StrSql = new StringBuffer();
    
//Verificar si tiene Estudio de Mercado el Expediente - Si
     StrSql.append("Select clEstudioMdo, coalesce(RespMdo1,'') as RespMdo1,coalesce(RespMdo2,'') as RespMdo2,coalesce(RespMdo3,'') as RespMdo3,coalesce(RespMdo4,'') as RespMdo4,coalesce(RespMdo5,'') as RespMdo5,");
     StrSql.append("coalesce(RespMdo6,'') as RespMdo6,coalesce(RespMdo7,'') as RespMdo7,coalesce(RespMdo8,'') as RespMdo8,coalesce(RespMdo9,'') as RespMdo9,coalesce(RespMdo10,'') as RespMdo10,");
     StrSql.append("clOpcion1,clOpcion2,clOpcion3,clOpcion4,clOpcion5,clOpcion6,clOpcion7,clOpcion8,clOpcion9,clOpcion10");
     StrSql.append(" from RespuestaMdoxExp Where clExpediente = ").append(StrclExpediente);
     ResultSet rs3 = UtileriasBDF.rsSQLNP(StrSql.toString());
     StrSql.delete(0,StrSql.length());
 
    if(rs3.next()){
      String StrclPaginaWeb = "316";
      session.setAttribute("clPaginaWebP",StrclPaginaWeb);%>
      <SCRIPT>fnOpenLinks()</script>
      <%MyUtil.InicializaParametrosC(316,Integer.parseInt(strclUsr));%>
      <%= MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
      <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)+ "DetalleEstudioMercado.jsp?"%>'>
      <script>document.all.btnAlta.disabled=true;</script>
<%
        //Inicio del Concesionario en Estudio de Mercado Hecho
         StrSql.append("Select AKM.clConcesionarioGM,MA.dsMarcaAuto,TA.dsTipoAuto, E.Clave, AKM.Modelo, AKM.Placas");
         StrSql.append(" from AsistenciaKM0 AKM");
         StrSql.append(" Inner join Expediente E on (E.clExpediente=").append(StrclExpediente).append(")");
         StrSql.append(" inner join cMarcaAuto MA on (MA.CodigoMarca=AKM.CodigoMarca)");
         StrSql.append(" inner join cTipoAuto TA on (TA.ClaveAMIS=AKM.ClaveAMIS)");
         StrSql.append(" Where AKM.clExpediente=").append(StrclExpediente);
         ResultSet rsConces = UtileriasBDF.rsSQLNP(StrSql.toString());
         StrSql.delete(0,StrSql.length());
         if (rsConces.next()){
               StrclConcesionario = rsConces.getString("clConcesionarioGM");
                if (StrclConcesionario==null){ StrclConcesionario = "0";}
               String StrdsTipoAuto = rsConces.getString("dsTipoAuto");
                if (StrdsTipoAuto==null){ StrdsTipoAuto = "0";}
               String StrdsMarcaAuto = rsConces.getString("dsMarcaAuto");
                if (StrdsMarcaAuto==null){ StrdsMarcaAuto = "0";}
               String StrClave = rsConces.getString("Clave");
                if (StrClave==null){ StrClave = "0";}
               String StrModelo = rsConces.getString("Modelo");
                if (StrModelo==null){StrModelo = "0";}
               String StrPlacas = rsConces.getString("Placas");
                if (StrPlacas==null){StrPlacas = "0";}
                StrSql.append("Select coalesce(GM.dsConcesionarioGM,'') as dsConcesionarioGM,");
                StrSql.append(" coalesce(TC.dsTipoConcesionario,'') as dsTipoConcesionario,");
                StrSql.append(" coalesce(GM.Calle,'') as Calle,coalesce(GM.CP,'') as CP,");
                StrSql.append(" coalesce(EF.dsEntFed,'') as dsEntFed,coalesce(MD.dsMunDel,'') as dsMunDel,");
                StrSql.append(" coalesce(GM.Lada,'') as Lada,coalesce(GM.Telefono1,'') as Telefono1,");
                StrSql.append(" coalesce(GM.Telefono2,'') as Telefono2,coalesce(GM.Telefono3,'') as Telefono3,");
                StrSql.append(" coalesce(GM.Telefono4,'') as Telefono4,coalesce(GM.HorarioLV,'') as HorarioLV,");
                StrSql.append(" coalesce(GM.HorarioSD,'') as HorarioSD,coalesce(GM.GerenteServicio,'') as GerenteServicio,");
                StrSql.append(" GM.Recibe24,GM.Activo, coalesce(GM.Observaciones,'') as Observaciones");
                StrSql.append(" from cConcesionarioGM GM");
                StrSql.append(" Left Join cTipoConcesionario TC ON (GM.clTipoConcesionario=TC.clTipoConcesionario)");
                StrSql.append(" Left Join cMunDel MD on (GM.CodEnt=MD.CodEnt and GM.CodMD=MD.CodMD)");
                StrSql.append(" Left join cEntFed EF on (GM.CodEnt=EF.CodEnt)");
                StrSql.append(" Where GM.clConcesionarioGM =").append(StrclConcesionario);
                ResultSet rs4A = UtileriasBDF.rsSQLNP(StrSql.toString());
                StrSql.delete(0,StrSql.length());  
                
                if(rs4A.next()){
                    String StrConcesionario = rs4A.getString("dsConcesionarioGM");
                    if (StrConcesionario==null){StrConcesionario = "0";}
                    String StrTipoConcesionario= rs4A.getString("dsTipoConcesionario");
                    if (StrTipoConcesionario==null){StrTipoConcesionario = "0";}
                    String StrCalle= rs4A.getString("Calle");
                    if (StrCalle==null){StrCalle = "0";}
                    String StrCP= rs4A.getString("CP");
                    if (StrCP==null){StrCP = "0";}
                    String StrdsEntFed= rs4A.getString("dsEntFed");
                    if (StrdsEntFed==null){StrdsEntFed = "0";}
                    String StrdsMunDel= rs4A.getString("dsMunDel");
                    if (StrdsMunDel==null){StrdsMunDel = "0";}
                    String StrLada= rs4A.getString("Lada");
                    if (StrLada==null){StrLada = "0";}
                    String StrTelefono1= rs4A.getString("Telefono1");
                    if (StrTelefono1==null){StrTelefono1 = "0";}
                    String StrTelefono2= rs4A.getString("Telefono2");
                    if (StrTelefono2==null){StrTelefono2 = "0";}
                    String StrTelefono3= rs4A.getString("Telefono3");
                    if (StrTelefono3==null){StrTelefono3 = "0";}
                    String StrTelefono4= rs4A.getString("Telefono4");
                    if (StrTelefono4==null){StrTelefono4 = "0";}
                    String StrHorarioLV= rs4A.getString("HorarioLV");
                    if (StrHorarioLV==null){StrHorarioLV = "0";}
                    String StrHorarioSD= rs4A.getString("HorarioSD");
                    if (StrHorarioSD==null){StrHorarioSD = "0";}
                    String StrGerenteServicio= rs4A.getString("GerenteServicio");
                    if (StrGerenteServicio==null){StrGerenteServicio = "0";}
                    String StrRecibe24= rs4A.getString("Recibe24");
                    if (StrRecibe24==null){StrRecibe24 = "0";}
                    String StrActivo= rs4A.getString("Activo");
                    if (StrActivo==null){ StrActivo = "0";}
                    String StrObservaciones= rs4A.getString("Observaciones");
                    if (StrObservaciones==null){StrObservaciones = "0";}%>

                    <%=MyUtil.ObjInput("Concesionario","dsConcesionarioVTR",StrConcesionario ,false,false,50,70,StrConcesionario ,false,false,55)%>
                    <%=MyUtil.ObjInput("Tipo","clTipoConcesionarioVTR",StrTipoConcesionario,false,false,350,70,StrTipoConcesionario,false,false,15)%>
                    <%=MyUtil.ObjInput("Direccion","CalleVTR",StrCalle,false,false,450,70,StrCalle,false,false,90)%>
                    <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CPVTR",StrCP,false,false,50,110,StrCP,false,false,10)%>
                    <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"CodEntVTR",StrdsEntFed,false,false,200,110,StrdsEntFed,false,false,40)%>
                    <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"CodMDVTR",StrdsMunDel,false,false,450,110,StrdsMunDel,false,false,40)%>
                    <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada"),"LadaVTR",StrLada,false,false,50,150,StrLada,false,false,10)%>
                    <%=MyUtil.ObjInput("Telefono","Telefono1VTR",StrTelefono1,false,false,150,150,StrTelefono1,false,false,20)%>
                    <%=MyUtil.ObjInput("Telefono 2","Telefono2VTR",StrTelefono2,false,false,300,150,StrTelefono2,false,false,20)%>
                    <%=MyUtil.ObjInput("Telefono 3","Telefono3VTR",StrTelefono3,false,false,450,150,StrTelefono3,false,false,20)%>
                    <%=MyUtil.ObjInput("Telefono 4","Telefono4VTR",StrTelefono4,false,false,600,150,StrTelefono4,false,false,20)%>
                    <%=MyUtil.ObjInput("Horario de Lunes a Viernes","HorarioLVVTR",StrHorarioLV,false,false,50,190,StrHorarioLV,false,false,60)%>
                    <%=MyUtil.ObjInput("Horario Sabado y Domingo","HorarioSDVTR",StrHorarioSD,false,false,450,190,StrHorarioSD,false,false,60)%>
                    <%=MyUtil.ObjInput("Gerente de Servicio","GerenteServicioVTR",StrGerenteServicio,false,false,50,230,StrGerenteServicio,false,false,40)%>
                    <%=MyUtil.ObjChkBox("Recibe 24hrs","Recibe24VTR",StrRecibe24, false,false,300,230,StrRecibe24,"Si","No","")%>                         
                    <%=MyUtil.ObjChkBox("Activo","ActivoVTR",StrActivo, false,false,400,230,StrActivo,"Si","No","")%>                         
                    <%=MyUtil.ObjTextArea("Observaciones","ObservacionesVTR",StrObservaciones,"80","2",false,false,500,230,StrObservaciones,false,false)%>
         <%     }else{ //Fin y else de Rs4A Datos del Concesionario       %>
                    <table class='TTable'><tr><td>El expediente no tiene concesionario</td></tr></table>
         <%     }%>
                <%=MyUtil.DoBlock("Concesionario",150,0)%>

                <%=MyUtil.ObjInput("Marca Auto","dsMarcaAutoVTR",StrdsMarcaAuto,false,false,50,320,StrdsMarcaAuto,false,false,60)%>
                <%=MyUtil.ObjInput("Tipo Auto","dsTipoAutoVTR",StrdsTipoAuto,false,false,400,320,StrdsTipoAuto,false,false,60)%>
                <%=MyUtil.ObjInput("Clave","ClaveVTR",StrClave,false,false,50,360,StrClave,false,false,30)%>
                <%=MyUtil.ObjInput("Modelo","ModeloVTR",StrModelo,false,false,250,360,StrModelo,false,false,8)%>
                <%=MyUtil.ObjInput("Placas","PlacasVTR",StrPlacas,false,false,350,360,StrPlacas,false,false,15)%>
                <%=MyUtil.DoBlock("Datos del Auto de la Asistencia",280,0)%>
            <%    i=450;
                rs4A.close();
                rs4A=null;
            }
        //Fin del Concesionario
        StrclEstudioMercado = rs3.getString("clEstudioMdo").toString();

        StrSql.append("Select RespAbierta, dsPreguntaMdo, clPreguntaMdo  from cPreguntaMdoxCuenta Where clEstudioMdo= ").append(StrclEstudioMercado);
        ResultSet rs5 = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0,StrSql.length());  
 
        while(rs5.next()){//Inicio While
            String StrRespAbierta =rs5.getString("RespAbierta");
            if (StrRespAbierta==null){StrRespAbierta = "0";}
            if(StrRespAbierta.equalsIgnoreCase("1")) {//Si pregunta es abierta%>
                 <%=MyUtil.ObjInput(rs5.getString("dsPreguntaMdo"),"RespMdo"+j,rs3.getString("RespMdo"+j),true,true,50,i,"",false,false,80)%>
            <% }else{
                   StrSql.append("Select dsOpcion from cOpcionMdoxPreg Where clOpcionxPreg=").append(rs3.getString("clOpcion"+j));
                   ResultSet rsds = UtileriasBDF.rsSQLNP(StrSql.toString());
                   StrSql.delete(0,StrSql.length());  
                   if(rsds.next()){}%>
                   <%=MyUtil.ObjComboC(rs5.getString("dsPreguntaMdo"),"clOpcion"+j,rsds.getString("dsOpcion"),true,true,50,i,"","Select clOpcionxPreg,dsOpcion From cOpcionMdoxPreg","","",50,true,true)%>
                  <%}
                   i= i + 40;
                   j= j + 1;
             } //Fin While  %>
         <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%= StrclExpediente%>'>
         <INPUT id='clEstudioMdo' name='clEstudioMdo' type='hidden' value='<%= StrclEstudioMercado%>'>
         <%=MyUtil.DoBlock("Detalle de Estudio de Mercado",320,30)%>
         <%=MyUtil.GeneraScripts()%>
   <%     rs5.close();
          rs5=null; 
          rsConces.close();
          rsConces=null; 
   }else{//Verificar si tiene Estudio de Mercado el Expediente - No
          StrSql.append("Select Activo, clEstudioMdo from cEstudioMercado where clCuenta =").append( StrclCuenta);
          ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
          StrSql.delete(0,StrSql.length());  
          if(rs.next()){//Verifica si tiene Estudio de Mercado la Cuenta
              String StrActivoE =rs.getString("Activo");
              if (StrActivoE==null){ StrActivoE = "0";}
              String StrclEstudioMdo =rs.getString("clEstudioMdo");
              if (StrclEstudioMdo==null){StrclEstudioMdo = "0";}
              if(StrActivoE.equalsIgnoreCase("0")){//If para verificar si esta Activo el estudio de mercado%>
                    <table class='TTable'><tr><td>La cuenta no tiene estudio de mercado activo</td></tr></table>
              <%  }
               else{
                    String StrclPaginaWeb = "316";
                    session.setAttribute("clPaginaWebP",StrclPaginaWeb);%>
                    <SCRIPT>fnOpenLinks()</script>
                 <% MyUtil.InicializaParametrosC(316,Integer.parseInt(strclUsr));%>
                 <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
                    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "DetalleEstudioMercado.jsp?"%>'>
                    <script>document.all.btnCambio.disabled=true;</script>
          <% //Inicio del Concesionario por Realizar
         StrSql.append("Select AKM.clConcesionarioGM,MA.dsMarcaAuto,TA.dsTipoAuto, E.Clave, AKM.Modelo, AKM.Placas");
         StrSql.append(" from AsistenciaKM0 AKM");
         StrSql.append(" Inner join Expediente E on (E.clExpediente=").append(StrclExpediente).append(")");
         StrSql.append(" inner join cMarcaAuto MA on (MA.CodigoMarca=AKM.CodigoMarca)");
         StrSql.append(" inner join cTipoAuto TA on (TA.ClaveAMIS=AKM.ClaveAMIS)");
         StrSql.append(" Where AKM.clExpediente=").append(StrclExpediente);
                    ResultSet rsConces = UtileriasBDF.rsSQLNP(StrSql.toString());
                    StrSql.delete(0,StrSql.length());  
                    if (rsConces.next()){
                        StrclConcesionario = rsConces.getString("clConcesionarioGM");
                        if (StrclConcesionario==null){StrclConcesionario = "0";}
                        String StrdsTipoAuto = rsConces.getString("dsTipoAuto");
                        if (StrdsTipoAuto==null){StrdsTipoAuto = "0";}
                        String StrdsMarcaAuto = rsConces.getString("dsMarcaAuto");
                        if (StrdsMarcaAuto==null){ StrdsMarcaAuto = "0";}
                        String StrClave = rsConces.getString("Clave");
                        if (StrClave==null){StrClave = "0";}
                        String StrModelo = rsConces.getString("Modelo");
                        if (StrModelo==null){StrModelo = "0";}
                        String StrPlacas = rsConces.getString("Placas");
                        if (StrPlacas==null){StrPlacas = "0";}
                        StrSql.append("Select coalesce(GM.dsConcesionarioGM,'') as dsConcesionarioGM,");
                        StrSql.append(" coalesce(TC.dsTipoConcesionario,'') as dsTipoConcesionario,");
                        StrSql.append(" coalesce(GM.Calle,'') as Calle, ");
                        StrSql.append(" coalesce(GM.CP,'') as CP,");
                        StrSql.append(" coalesce(EF.dsEntFed,'') as dsEntFed,");
                        StrSql.append(" coalesce(MD.dsMunDel,'') as dsMunDel,");
                        StrSql.append(" coalesce(GM.Lada,'') as Lada,");
                        StrSql.append(" coalesce(GM.Telefono1,'') as Telefono1,");
                        StrSql.append(" coalesce(GM.Telefono2,'') as Telefono2,");
                        StrSql.append(" coalesce(GM.Telefono3,'') as Telefono3,");
                        StrSql.append(" coalesce(GM.Telefono4,'') as Telefono4,");
                        StrSql.append(" coalesce(GM.HorarioLV,'') as HorarioLV,");
                        StrSql.append(" coalesce(GM.HorarioSD,'') as HorarioSD,");
                        StrSql.append(" coalesce(GM.GerenteServicio,'') as GerenteServicio,");
                        StrSql.append(" GM.Recibe24, GM.Activo,");
                        StrSql.append(" coalesce(GM.Observaciones,'') as Observaciones");
                        StrSql.append(" from cConcesionarioGM GM");
                        StrSql.append(" Left Join cTipoConcesionario TC ON (GM.clTipoConcesionario=TC.clTipoConcesionario)");
                        StrSql.append(" Left Join cMunDel MD on (GM.CodEnt=MD.CodEnt and GM.CodMD=MD.CodMD)");
                        StrSql.append(" Left join cEntFed EF on (GM.CodEnt=EF.CodEnt)");
                        StrSql.append(" Where GM.clConcesionarioGM =").append(StrclConcesionario);
                        ResultSet rs4A = UtileriasBDF.rsSQLNP(StrSql.toString());
                        StrSql.delete(0,StrSql.length());  
       
                      if(rs4A.next()){
                         String StrConcesionario = rs4A.getString("dsConcesionarioGM");
                        if (StrConcesionario==null){StrConcesionario = "0";}
                        String StrTipoConcesionario= rs4A.getString("dsTipoConcesionario");
                        if (StrTipoConcesionario==null){StrTipoConcesionario = "0";}
                        String StrCalle= rs4A.getString("Calle");
                        if (StrCalle==null){StrCalle = "0";}
                        String StrCP= rs4A.getString("CP");
                        if (StrCP==null){StrCP = "0";}
                        String StrdsEntFed= rs4A.getString("dsEntFed");
                        if (StrdsEntFed==null){StrdsEntFed = "0";}
                        String StrdsMunDel= rs4A.getString("dsMunDel");
                        if (StrdsMunDel==null){StrdsMunDel = "0";}
                        String StrLada= rs4A.getString("Lada");
                        if (StrLada==null){StrLada = "0";}
                        String StrTelefono1= rs4A.getString("Telefono1");
                        if (StrTelefono1==null){StrTelefono1 = "0";}
                        String StrTelefono2= rs4A.getString("Telefono2");
                        if (StrTelefono2==null){StrTelefono2 = "0";}
                        String StrTelefono3= rs4A.getString("Telefono3");
                        if (StrTelefono3==null){StrTelefono3 = "0";}
                        String StrTelefono4= rs4A.getString("Telefono4");
                        if (StrTelefono4==null){StrTelefono4 = "0";}
                        String StrHorarioLV= rs4A.getString("HorarioLV");
                        if (StrHorarioLV==null){StrHorarioLV = "0";}
                        String StrHorarioSD= rs4A.getString("HorarioSD");
                        if (StrHorarioSD==null){StrHorarioSD = "0";}
                        String StrGerenteServicio= rs4A.getString("GerenteServicio");
                        if (StrGerenteServicio==null){StrGerenteServicio = "0";}
                        String StrRecibe24= rs4A.getString("Recibe24");
                        if (StrRecibe24==null){StrRecibe24 = "0";}
                        String StrActivo= rs4A.getString("Activo");
                        if (StrActivo==null){StrActivo = "0";}
                        String StrObservaciones= rs4A.getString("Observaciones");
                        if (StrObservaciones==null){StrObservaciones = "0";}%>

                        <%=MyUtil.ObjInput("Concesionario","dsConcesionarioVTR",StrConcesionario ,false,false,50,70,StrConcesionario ,false,false,55)%>
                        <%=MyUtil.ObjInput("Tipo","clTipoConcesionarioVTR",StrTipoConcesionario,false,false,350,70,StrTipoConcesionario,false,false,15)%>
                        <%=MyUtil.ObjInput("Direccion","CalleVTR",StrCalle,false,false,450,70,StrCalle,false,false,90)%>
                        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CPVTR",StrCP,false,false,50,110,StrCP,false,false,10)%>
                        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"CodEntVTR",StrdsEntFed,false,false,200,110,StrdsEntFed,false,false,40)%>
                        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"CodMDVTR",StrdsMunDel,false,false,450,110,StrdsMunDel,false,false,40)%>
                        <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada"),"LadaVTR",StrLada,false,false,50,150,StrLada,false,false,10)%>
                        <%=MyUtil.ObjInput("Telefono","Telefono1VTR",StrTelefono1,false,false,150,150,StrTelefono1,false,false,20)%>
                        <%=MyUtil.ObjInput("Telefono 2","Telefono2VTR",StrTelefono2,false,false,300,150,StrTelefono2,false,false,20)%>
                        <%=MyUtil.ObjInput("Telefono 3","Telefono3VTR",StrTelefono3,false,false,450,150,StrTelefono3,false,false,20)%>
                        <%=MyUtil.ObjInput("Telefono 4","Telefono4VTR",StrTelefono4,false,false,600,150,StrTelefono4,false,false,20)%>
                        <%=MyUtil.ObjInput("Horario de Lunes a Viernes","HorarioLVVTR",StrHorarioLV,false,false,50,190,StrHorarioLV,false,false,60)%>
                        <%=MyUtil.ObjInput("Horario Sabado y Domingo","HorarioSDVTR",StrHorarioSD,false,false,450,190,StrHorarioSD,false,false,60)%>
                        <%=MyUtil.ObjInput("Gerente de Servicio","GerenteServicioVTR",StrGerenteServicio,false,false,50,230,StrGerenteServicio,false,false,40)%>
                        <%=MyUtil.ObjChkBox("Recibe 24hrs","Recibe24VTR",StrRecibe24, false,false,300,230,StrRecibe24,"Si","No","")%>                         
                        <%=MyUtil.ObjChkBox("Activo","ActivoVTR",StrActivo, false,false,400,230,StrActivo,"Si","No","")%>                         
                        <%=MyUtil.ObjTextArea("Observaciones","ObservacionesVTR",StrObservaciones,"80","2",false,false,500,230,StrObservaciones,false,false)%>
                    <%}else{//Fin y else de Rs4A Datos del Concesionario%>
                        <table class='TTable'><tr><td>El expediente no tiene concesionario</td></tr></table>
                   <%   }%>
                   <%=MyUtil.DoBlock("Concesionario",150,0)%>

                       <%=MyUtil.ObjInput("Marca Auto","dsMarcaAutoVTR",StrdsMarcaAuto,false,false,50,320,StrdsMarcaAuto,false,false,60)%>
                       <%=MyUtil.ObjInput("Tipo Auto","dsTipoAutoVTR",StrdsTipoAuto,false,false,400,320,StrdsTipoAuto,false,false,60)%>
                       <%=MyUtil.ObjInput("Clave","ClaveVTR",StrClave,false,false,50,360,StrClave,false,false,30)%>
                       <%=MyUtil.ObjInput("Modelo","ModeloVTR",StrModelo,false,false,250,360,StrModelo,false,false,8)%>
                       <%=MyUtil.ObjInput("Placas","PlacasVTR",StrPlacas,false,false,350,360,StrPlacas,false,false,15)%>
                       <%=MyUtil.DoBlock("Datos del Auto de la Asistencia",280,0)%>
                     <%   i=450;
                      rs4A.close();
                      rs4A=null;   
                   }//Fin del Concesionario
        
                  StrSql.append("Select RespAbierta, dsPreguntaMdo, clPreguntaMdo from cPreguntaMdoxCuenta Where clEstudioMdo= ").append(StrclEstudioMdo);
                  ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
                  StrSql.delete(0,StrSql.length());  
                  while(rs2.next()){//Inicio While
                       String strRespAbierta = rs2.getString("RespAbierta");
                       if (strRespAbierta  == null){strRespAbierta  = "";}
                       String strdsPreguntaMdo = rs2.getString("dsPreguntaMdo");
                       if (strdsPreguntaMdo  == null){strdsPreguntaMdo  = "";}
                       if(strRespAbierta.equalsIgnoreCase("1")) {//Si pregunta es abierta%>
                       <%=MyUtil.ObjInput(strdsPreguntaMdo,"RespMdo"+j,"",true,true,50,i,"",false,false,80)%>
                       <%}else{%>
                           <%=MyUtil.ObjComboC(strdsPreguntaMdo,"clOpcion"+j,"",true,true,50,i,"","Select clOpcionxPreg,dsOpcion From cOpcionMdoxPreg Where clPreguntaMdo= "+ rs2.getString("clPreguntaMdo"),"","",50,true,true)%>
                       <%}
                       i= i + 40;
                       j= j + 1;
                   }//Fin While rs2%>
                  <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
                  <INPUT id='clEstudioMdo' name='clEstudioMdo' type='hidden' value='<%=StrclEstudioMdo %>'>
                  <%=MyUtil.DoBlock("Detalle de Estudio de Mercado",350,30)%> 
                  <%  
                   rs2.close();
                   rs2=null; 
                   rsConces.close();
                   rsConces=null;
                   }//Fin If para verificar si esta Activo el Estudio de Marcado 
               //             }//Fin If para verificar si necesita pasar por Supervision
                rs.close();
                rs=null;  
           }else {%>
              <table class='TTable'><tr><td>La cuenta no tiene estudio de mercado</td></tr></table>
          <%    }%>
           <%=MyUtil.GeneraScripts()%>
<%} //Fin de Verificar si tiene Estudio de Mercado el Expediente
rs3.close();
rs3=null;     
StrSql=null;     
%>
<SCRIPT>
</SCRIPT>
</body>
</html>