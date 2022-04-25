<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.referencias.DAONutricional,com.ike.referencias.to.Nutricional" %>

<html>
    <head>
         <title>Referencia Nutricional</title>
    </head>
    <body class="cssBody" onload="">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>        
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>        
            
            <%  
            String strclUsr = "0";
            String strclCuenta="0";
            String strClave="0";  
            String strclRReferencias="0";
            String strclServicio="0";
            
            
            //Bajar de Session una variable
            if (session.getAttribute("Clave")!=null){
                strClave=session.getAttribute("Clave").toString();
            }
            
            if (session.getAttribute("clUsrApp")!= null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }
    
            if (request.getParameter("clRReferencias")!=null){
                strclRReferencias=request.getParameter("clRReferencias").toString();
            }
            else {
                if (session.getAttribute("clRReferencias")!=null){
                    strclRReferencias=session.getAttribute("clRReferencias").toString();
                }
            }
            
            if (session.getAttribute("clServicio")!=null){
                strclServicio = session.getAttribute("clServicio").toString();
            }                               
            
            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) { %>
            <!--Fuera de Horario-->
            <%
                strclUsr=null;
                return;
            }
            
            if(session.getAttribute("clCuenta")!=null){
                strclCuenta = session.getAttribute("clCuenta").toString();
            }
 
            DAONutricional daoNutricional = new DAONutricional();
            Nutricional Nutri= new Nutricional();
                      
            Nutri = daoNutricional.getReferencia(strclRReferencias);
                    
            String StrclPaginaWeb = "825";
            session.setAttribute("clPaginaWebP",StrclPaginaWeb);
                                   
        %>        
        <script>fnOpenLinks()</script>                
          
        <% if (strclServicio.equalsIgnoreCase("11")) { %>
        <%MyUtil.InicializaParametrosC(825,Integer.parseInt(strclUsr));%>       
        <%=MyUtil.doMenuAct("../../servlet/com.ike.referencias.guarda.GuardaNutricional","")%>
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Nutricional.jsp?'>"%>
           
           <INPUT id="clRReferencias" name="clRReferencias" type="hidden" value='<%=strclRReferencias%>'> 
           <INPUT id='clNutricional' name='clNutricional' type = "hidden" value='<%=Nutri !=null ? Nutri.getClNutricional() : "0"%>'> 
           <INPUT id="Clave" name="Clave" type="hidden" value="<%=strClave%>">
           <INPUT id="clCuenta" name="clCuenta" type="hidden" value="<%=strclCuenta%>">
           
           <%=MyUtil.ObjComboC("Asesoria","clAsesoria",Nutri!=null ? Nutri.getDsAsesoria():"",true,true,30,80,Nutri!=null ? Nutri.getClAsesoria():"","select * from cAsesoriaNutricional","","",50,true,false)%>
           
           <%=MyUtil.ObjInput("Edad","Edad",Nutri!=null ? Nutri.getEdad():"",true,true,30,120,"",true,false,8)%>
           <%=MyUtil.ObjChkBox("Sexo","Sexo",Nutri!=null ? Nutri.getSexo():"",true,true,135,120,"0","M","F","")%>
           
           <%=MyUtil.ObjInput("Talla (m.)","Talla",Nutri!=null ? Nutri.getTalla():"",true,true,30,165,"",true,true,8,"fnIMC(this.value)")%>
           <%=MyUtil.ObjInput("Peso (kg.)","Peso",Nutri!=null ? Nutri.getPeso():"",true,true,135,165,"",true,true,8,"fnIMC(this.value)")%>
           <%=MyUtil.ObjInput("IMC","IMC",Nutri!=null ? Nutri.getIMC():"",false,false,233,165,"",false,false,6)%>
           
           <%=MyUtil.ObjChkBox("Peso Normal","PesoIdeal",Nutri!=null ? Nutri.getPesoIdeal():"",false,false,25,220,"","")%>
           <%=MyUtil.ObjChkBox("Peso Bajo","PesoBajo",Nutri!=null ? Nutri.getPesoBajo():"",false,false,25,260,"","")%>
           <%=MyUtil.ObjChkBox("Sobrepeso","SobrePeso",Nutri!=null ? Nutri.getSobrepeso():"",false,false,135,220,"","")%>
           <%=MyUtil.ObjChkBox("Desnutrición","Desnutricion",Nutri!=null ? Nutri.getDesnutricion():"",false,false,135,260,"","")%>
           <%=MyUtil.ObjChkBox("Obesidad 1","Obesidad1",Nutri!=null ? Nutri.getObesidad1():"",false,false,260,220,"","")%>
           <%=MyUtil.ObjChkBox("Obesidad 2","Obesidad2",Nutri!=null ? Nutri.getObesidad2():"",false,false,260,260,"","")%>
           <%=MyUtil.DoBlock("Datos del Paciente",-50,0)%>
             
           <%=MyUtil.GeneraScripts()%>
   
           <!-- SI EL OBJETO NO ESTA VACIO -->
           <% if (Nutri!=null) { %>
            <script>document.all.btnAlta.disabled=true;
                    //document.all.btnCambio.disabled=false;
            </script>
           <%} else { %>
            <script>document.all.btnAlta.disabled=false;
                    document.all.btnCambio.disabled=true;
            </script>

            <%}%>
         
        <% } else { %>
            <br><br>
            <center><h4>Servicio de Asistencia Nutricional no configurado en esta Cuenta.</h4> </center>
        <% }
            
             strclUsr = null;
             strclCuenta=null;
             strClave=null;
             strclRReferencias=null;
             strclServicio=null;
             StrclPaginaWeb= null;
            
            Nutri = null;
            daoNutricional = null;
                        
            %>
  
        
         <script>   
             
             function fnClearCheckBoxes(){
                    document.all.DesnutricionC.checked=0;
                    document.all.Desnutricion.value=0;
                    document.all.PesoBajoC.checked=0;
                    document.all.PesoBajo.value=0;
                    document.all.PesoIdealC.checked=0;
                    document.all.PesoIdeal.value=0;
                    document.all.SobrePesoC.checked=0;
                    document.all.SobrePeso.value=0;
                    document.all.Obesidad1C.checked=0;
                    document.all.Obesidad1.value=0;
                    document.all.Obesidad2C.checked=0;
                    document.all.Obesidad2.value=0;
             }
             
             function fnIMC()
             {     
                Talla=document.all.Talla.value;
                Peso=document.all.Peso.value;
                if(document.all.Talla.value.length <= 0)
                {
                    document.all.IMC.value=0;
                    return;
                } else if(document.all.Peso.value.length > 0)
                       {
                         IMC=Peso/(Talla*Talla);
                         document.all.IMC.value=IMC;
                         fnClearCheckBoxes();
                         if (IMC<18.5)                                    // ----- DESNUTRICION
                         {
                             document.all.DesnutricionC.checked=1;   
                             document.all.Desnutricion.value=1;
                         }                          
                         if (IMC==18.5)                                   // ----- PESO BAJO
                         {
                             document.all.PesoBajoC.checked=1;   
                             document.all.PesoBajo.value=1;
                            
                         } 
                         if (IMC>18.5 & IMC<=24.9)                        // ----- PESO IDEAL
                         {
                             document.all.PesoIdealC.checked=1;   
                             document.all.PesoIdeal.value=1;
                         } 
                         if (IMC>=25 & IMC<=29.9)                         // ----- SOBREPESO
                         {
                             document.all.SobrePesoC.checked=1;   
                             document.all.SobrePeso.value=1;
                            
                         } 
                         if (IMC>=30 & IMC<=39.9)                         // ----- OBESIDAD1
                         {
                             document.all.Obesidad1C.checked=1;   
                             document.all.Obesidad1.value=1;
                         }   
                         if (IMC>=40)                                     // ----- OBESIDAD2
                         {
                            document.all.Obesidad2C.checked=1;   
                            document.all.Obesidad2.value=1;                            
                         }    
                    }
                    else document.all.IMC.value=0;
            }
        </script>   
     </body>
</html>
