<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.ReuComer.DAORCReunion,com.ike.ReuComer.to.RCReunion,com.ike.ReuComer.DAORCCliente,com.ike.ReuComer.to.RCCliente,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Seguimiento de reunion</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../StyleClasses/Calendario.css" rel="stylesheet" type="text/css"> 
    </head>
    <body class="cssBody" OnLoad="">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src="../Utilerias/UtilCalendario.js"></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%
            String strclUsrApp = "0";
            String strclCliente = "0";
            String strclReunion = "0";
            String strCriterio = "0";
            String strclUsrAppSession = "0";
            int iCont =0;

            if (session.getAttribute("clUsrApp")!=null) {
                strclUsrApp = session.getAttribute("clUsrApp").toString();
                strclUsrAppSession = session.getAttribute("clUsrApp").toString();
            }
            
            if (request.getParameter("clCliente")!= null) {
                strclCliente= request.getParameter("clCliente").toString();
            } else{
                if (session.getAttribute("clCliente")!= null) {
                    strclCliente= session.getAttribute("clCliente").toString();
                }
            }
            session.setAttribute("clCliente",strclCliente);

            if (request.getParameter("clReunion")!= null) 
            {
                strclReunion= request.getParameter("clReunion").toString();
            }
            

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) {
            %>
            <b>Fuera de Horario</b>
            <%
            strclUsrApp = null;
            return;       
            } 

        DAORCCliente daoRCCliente = null;
    
        RCCliente  Cliente = null;
            if (strclCliente.compareToIgnoreCase("0")!=0) {
                daoRCCliente = new DAORCCliente();
                Cliente = daoRCCliente.getCliente(strclCliente);
            }
            
        DAORCReunion daoRCReunion = null;
    
        RCReunion  Reunion = null;
            if (strclReunion.compareToIgnoreCase("0")!=0) {
                daoRCReunion = new DAORCReunion();
                Reunion = daoRCReunion.getclReunion(strclReunion);
            }

            String StrclPaginaWeb = "677";
            session.setAttribute("clPaginaWebP",StrclPaginaWeb);
            MyUtil.InicializaParametrosC(677,Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

            %><script>fnOpenLinks()</script>

            <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","fnAccionesAlta();","fnAntesGuardar();")%>

            <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>RCDetalleReunion.jsp?'></input>
            <%=MyUtil.ObjInput("Clave","clReunion",Reunion != null ? Reunion.getclReunion() : "",false,false,30,70,"",false,false,10)%>
            <%=MyUtil.ObjInput("Nombre Cliente","NombreClienteVTR",Cliente != null ? Cliente.getNombreCliente() : "",false,false,110,70,Cliente != null ? Cliente.getNombreCliente() : "",false,false,40)%>
            <%=MyUtil.ObjComboC("Tipo Reunion","clTipoReunion",Reunion !=null ? Reunion.getdsTipoReunion() : "",true,true,350,70,"","Select clTipoReunion,dsTipoReunion from RCcTipoReunion order by dsTipoReunion","","",40,true,true)%>
            <INPUT id='clCliente' name='clCliente' type='hidden' value='<%=strclCliente%>'>
            <INPUT id='clUsrAppConvoca' name='clUsrAppConvoca' type='hidden' value='<%=strclUsrApp%>'>
            <INPUT id='FechaVTR' name='FechaVTR' type='hidden' value=''>
            <INPUT id='clUsrAppSession' name='clUsrAppSession' type='hidden' value='<%=strclUsrAppSession%>'>
        <%=MyUtil.ObjInputF("Fecha de la Reunion", "FechaProgramada",Reunion != null ? Reunion.getFechaProgramada() : "",true,true,520,70,"",true,false,20,1,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};fnfecha(this);")%>             
        <%=MyUtil.ObjTextArea("Asistentes Externos","Asistentes",Reunion != null ? Reunion.getAsistentes() : "","55","5",true,true,30,120,"",false,false)%>
        <%=MyUtil.ObjTextArea("Puntos Tratados","Puntos",Reunion != null ? Reunion.getPuntos() : "","55","5",true,true,350,120,"",false,false)%>
        <%=MyUtil.DoBlock("Detalle de la Reunion ",10,80)%>
    
        <div class='VTable' style='position:absolute; z-index:40; left:400px; top:210px;'>
            <input class='cBtn' id="Asignar" type='button' value='Asignar' onClick="window.open('RCAsignarAsistente.jsp?Asignar=1&clReunion=<%=strclReunion%>','','resizable=no,menubar=0,status=0,toolbar=0,height=450,width=1005,screenX=-50,screenY=0,scrollbars=yes')"></input>
        </div>
        
        <%
            if (strclReunion.equalsIgnoreCase("0")) {
            %>
            <script>document.all.Asignar.style.visibility='hidden';</script>
            <!--
        <div class='VTable' style='position:absolute; z-index:40; left:400px; top:210px;'>
            <input class='cBtn' id="Asignar" type='button' value='Asignar' onClick="window.open('RCAsignarAsistente.jsp?Asignar=1&clReunion=<%=strclReunion%>','','resizable=no,menubar=0,status=0,toolbar=0,height=450,width=1005,screenX=-50,screenY=0,scrollbars=yes')"></input>
        </div>
        -->
        <%
            }
        %>
        <%=MyUtil.GeneraScripts()%>
        
        <%
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("st_RCObtenAsistentes ").append(strclReunion);
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        %>
        <div class='VTable' id="Lista" style='position:absolute; z-index:300; left:30px; top:300px;'>
            <table>
                <tr class='cssTitDet'><td>Asistentes a la REUNION</td><td>Eliminar</td></tr>
                <%    
                while(rs.next())
                    {
                %>
                <tr><td class="VTable"><%=rs.getString("Nombre")%></td>
                    <td class="VTable"><center><a href="../Comercial/RCDesasignarAsistente.jsp?clAsistente=<%=rs.getString("clAsistente")%>&clReunion=<%=strclReunion%>"><img src="../Imagenes/elimina.gif" border="0"></a></center></td>
                </tr>
                <%
                    }
            %>
                </table>
        </div>
        <%
            if (strclReunion.equalsIgnoreCase("0")) {
            %>
        <script>document.all.btnCambio.disabled = true;</script>
        <%
        }
            strclUsrApp = null;
            strclCliente = null;
            strclReunion = null;

            Reunion = null;
            Cliente = null;
            %>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <script>
            
       
            function fnAntesGuardar()
            {
              mueveReloj();
             if (document.all.Puntos.value == '' || document.all.Puntos.value ==' ' || document.all.Puntos.value =='  ')
             {
              msgVal = msgVal + " Puntos a Tratar.";
              document.all.btnGuarda.disabled=false;
              document.all.btnCancela.disabled=false;
             }
                 
             if (document.all.Asistentes.value == '' || document.all.Asistentes.value ==' ' || document.all.Asistentes.value =='  ')
             {
              msgVal = msgVal + " Asistentes.";
              document.all.btnGuarda.disabled=false;
              document.all.btnCancela.disabled=false;
             }
             
             if (document.all.clTipoReunion.value == 3 && document.all.FechaProgramada.value =='')
             {
              msgVal = msgVal + " Fecha Programada.";
              document.all.btnGuarda.disabled=false;
              document.all.btnCancela.disabled=false;
             }
             
             if (document.all.FechaProgramada.value < document.all.FechaVTR.value)
             {
              if (document.all.clTipoReunion.value == 3)
              {
               msgVal = msgVal + " La Fecha para Programar una Reunion es anterior a la fecha actual.";
               document.all.FechaProgramada.focus(); 
               document.all.btnGuarda.disabled=false;
               document.all.btnCancela.disabled=false;
              }
             }
             
             if (document.all.FechaProgramada.value > document.all.FechaVTR.value)
             {
              if (document.all.clTipoReunion.value == 1 || document.all.clTipoReunion.value == 2)
              {
               msgVal = msgVal + " La Fecha debe ser posterior a la fecha seleccionada.";
               document.all.FechaProgramada.focus(); 
               document.all.btnGuarda.disabled=false;
               document.all.btnCancela.disabled=false;
              }
             }
             

            }

            function fndesHabilitarAsDs()
            {/*
            if (document.all.Action.value!=1)
            {
            //document.all.Tel1.disabled = true;
            document.all.Asignar.disabled = true;
            }*/
            }


            function fnHabilitarAsDs()
            {/*
            if (document.all.Action.value==1 || document.all.Action.value==2)
            {
            //window.open("RCAsignarAsistente.jsp? target='Asistentes'",'','resizable=no,menubar=0,toolbar=0,height=200,width=650,screenX=-50,screenY=0');
            top.frames['Reunion'].location.href='RCAsignarAsistente.jsp';
            }
            else
            {
            alert ("Presione Alta o Cambio para ejecutar esta operación");
            }*/
            }
  
            function fnHabilitaConvo()
            {
            if (document.all.clTipoReunion.value == 3)
            {
            document.all.FechaProgramada.disabled = false;
            }
            else
            {
            document.all.FechaProgramada.disabled = true;
            }
            }
            
            function fnAccionesAlta()
            {
             if (document.all.Action.value == 1)
             {
              
              document.all.Asignar.style.visibility='hidden';
              document.all.Lista.style.visibility='hidden'; 
             
              var pstrCadena = "../Utilerias/RegresaFechaActual.jsp";
              window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
             }
            }
            
            function mueveReloj(){
            if (document.all.Action.value==2){
                    momentoActual = new Date()
                    var year= momentoActual.getYear();
                          if (year < 1000)
                          year+=1900;

                    var day= momentoActual.getDay(); 

                    var month= momentoActual.getMonth()+1;
                          if (month<10) month="0"+ month

                    var daym= momentoActual.getDate();
                        if (daym <10) daym ="0"+ daym 
                        
                    hora = momentoActual.getHours()
                    minuto = momentoActual.getMinutes()
                            if (minuto <10) minuto ="0"+ minuto 

                    segundo = momentoActual.getSeconds()

                    horaImprimible = year + "-" + month + "-" + daym + " " + hora + ":" + minuto
                    
                    document.forma.FechaVTR.value = horaImprimible 
                    }

                    //setTimeout("mueveReloj()",1000)
            }

            function fnfecha(fechaelegida)
            { 
              
              mueveReloj();
                
                 if (fechaelegida != "" && document.all.clTipoReunion.value==3)
                 {
                      if (fechaelegida.value  < document.all.FechaVTR.value)
                          {
                           //alert("La Fecha para Programar una Reunion es anterior a la fecha actual.");
                           alert("La Fecha y hora para Programar una Reunion debe ser posterior a la fecha seleccionada.");
                           showCalendarControl(fechaelegida); 
                          }
                 }
                 if (fechaelegida != "" && (document.all.clTipoReunion.value==1 || document.all.clTipoReunion.value==2)){
                      if (fechaelegida.value >  document.all.FechaVTR.value)
                          {
                           alert("La Fecha y hora debe ser anterior a la fecha seleccionada.");
                           showCalendarControl(fechaelegida); 
                          }
                 }
            }
            
            function fnFechaActual(){
                if (document.all.Action.value=="1"){
                document.all.FechaProgramada.value = document.all.FechaVTR.value
                }
            }
            
          function fnActualizaFechaActual (pFecha)
          {
           document.all.FechaProgramada.value=pFecha;
           document.all.FechaVTR.value=pFecha;
          }
        </script>
    </body>
</html>

