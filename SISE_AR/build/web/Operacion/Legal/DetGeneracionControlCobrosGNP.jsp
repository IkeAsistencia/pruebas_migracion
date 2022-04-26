<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%> 
<html>
<head><title>Generación y control de cobros GNP</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script> 
<%  
  String StrclUsrApp="0";
  String StrclCobroGenerado = "0";
  String StrclExpediente = "0";
  String StrclPaginaWeb = "0";
  String StrdsEstatusExp = "";
  String StrDanoAjustaNU = "0";
  String StrNombreOpe = "";
  String StrDelitos= "0";
  String StrEtapaRecup="0";
  String StrCheck1="0";
  String StrCheck2="0";
  String StrCheck3="0";
  String StrCheck4="0";
//Obtiene el clUsrApp de Session    
  if (session.getAttribute("clUsrApp")!= null)
  {
   StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
  }  

  if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
  {
%>
Fuera de Horario
<% 
   StrclUsrApp=null;
   return;        
  } 

//Obtiene el número de expediente y el numero de Cobro que vienen en la URL del Listado
    if (request.getParameter("clExpediente")!= null)
    {
     StrclExpediente= request.getParameter("clExpediente").toString(); 
    }  
    else
    {
     if (session.getAttribute("clExpediente")!= null)
     {
      StrclExpediente= session.getAttribute("clExpediente").toString(); 
     }  
    }
    session.setAttribute("clExpediente",StrclExpediente);

    if (request.getParameter("clCobroGenerado")!= null)
    {
     StrclCobroGenerado= request.getParameter("clCobroGenerado").toString(); 
    }   

    StringBuffer StrSql = new StringBuffer();
   
    StrSql.append(" Select ES.dsEstatus 'dsEstatus', coalesce(VI.DanoAjustaNU,'0') 'DanoAjustaNU', PR.NombreOpe, coalesce(D.dsDelito,'') 'dsDelito' from Expediente EX");
    StrSql.append(" inner join cEstatus ES on (ES.clEstatus=EX.clEstatus)");
    StrSql.append(" left join ProveedorxExpediente PE on (EX.clExpediente=PE.clExpediente)");
    StrSql.append(" left join cProveedor PR on (PE.clProveedor=PR.clProveedor and PE.Titular=1)");
    StrSql.append(" left join VehiculoInvNU VI on (EX.clExpediente=VI.clExpediente)");
    StrSql.append(" inner join AsistenciaLegal AL on (EX.clExpediente=AL.clExpediente)");
    StrSql.append(" left join DelitoEvento DE on (DE.clExpediente=EX.clExpediente)");
    StrSql.append (" left join cDelito D on (D.clDelito=DE.clDelito)");
    StrSql.append(" where EX. clExpediente=").append(StrclExpediente);
    
    ResultSet rsExp = UtileriasBDF.rsSQLNP(StrSql.toString());
    StrSql.delete(0,StrSql.length());
   
//Verifica que el Result Set traiga contenido
    if (rsExp.next())
    {
     StrdsEstatusExp = rsExp.getString("dsEstatus");
      if (StrdsEstatusExp == null)
      {
       StrdsEstatusExp = "";
      }

      StrDanoAjustaNU = rsExp.getString("DanoAjustaNU");
      if (StrDanoAjustaNU == null)
       {
        StrDanoAjustaNU = "";
       }

       StrNombreOpe = rsExp.getString("NombreOpe");
       if (StrNombreOpe == null)
       {
        StrNombreOpe = "";
       }

       StrDelitos = rsExp.getString("dsDelito");
       if (StrDelitos == null)
       {
        StrDelitos = "";
       }
 
%>
	   <%=MyUtil.ObjInput("Expediente","clExpedienteVTR",StrclExpediente,false,false,25,80,StrclExpediente,false,false,15)%>
     <%=MyUtil.ObjInput("Estatus","EstatusExpedienteVTR",StrdsEstatusExp,false,false,125,80,StrdsEstatusExp,false,false,20)%>
     <%=MyUtil.ObjInput("Monto Daño","MontoDanoVTR",StrDanoAjustaNU,false,false,250,80,StrDanoAjustaNU,false,false,25)%>
     <%=MyUtil.ObjInput("Abogado titular","AbogadoTitularVTR",StrNombreOpe,false,false,400,80,StrNombreOpe,false,false,50)%>
     <%=MyUtil.ObjInput("Delitos","dsDelitoVTR",StrDelitos,false,false,25,120,StrDelitos,false,false,50)%>
     <%=MyUtil.DoBlock("Detalle del Expediente",100,0)%>
     
<%
    }//Else rs.Exp
    
    StrSql.append("select ");
    StrSql.append(" CG.EtapaRecuperacion 'EtapaRecuperacion', CG.MontoDanoExterno 'MontoDanoExterno', ");
    StrSql.append(" CG.CostoAsunto 'CostoAsunto', ");
    StrSql.append(" CG.Estatus 'Estatus',");
    StrSql.append(" coalesce(case CG.PorcEt1 when 1 then '100' when 2 then '50' when 3 then '25' end,'') 'PorcEt1',coalesce(convert(varchar(10),CG.FechaCobroET1,120),'') 'FechaCobroET1',");
    StrSql.append(" coalesce(convert(varchar(10),CG.FechaRecupET1,120),'') 'FechaRecupET1', coalesce(CG.MontoEtapa1,'0') 'MontoEtapa1',");
    StrSql.append(" coalesce(case CG.PorcEt2 when 1 then '100' when 2 then '50' when 3 then '25' end,'') 'PorcEt2',coalesce(convert(varchar(10),CG.FechaCobroET2,120),'') 'FechaCobroET2',");
    StrSql.append(" coalesce(convert(varchar(10),CG.FechaRecupET2,120),'') 'FechaRecupET2', coalesce(CG.MontoEtapa2,'0') 'MontoEtapa2',");
    StrSql.append(" coalesce(case CG.PorcEt3 when 1 then '100' when 2 then '50' when 3 then '25' end,'') 'PorcEt3',coalesce(convert(varchar(10),CG.FechaCobroET3,120),'') 'FechaCobroET3',");
    StrSql.append(" coalesce(convert(varchar(10),CG.FechaRecupET3,120),'') 'FechaRecupET3',coalesce(CG.MontoEtapa3,'0') 'MontoEtapa3',");
    StrSql.append(" coalesce(case CG.PorcEt4 when 1 then '100' when 2 then '50' when 3 then '25' end,'') 'PorcEt4',coalesce(convert(varchar(10),CG.FechaCobroET4,120),'') 'FechaCobroET4',");
    StrSql.append(" coalesce(convert(varchar(10),CG.FechaRecupET4,120),'') 'FechaRecupET4',coalesce(CG.MontoEtapa4,'0') 'MontoEtapa4',");
    StrSql.append(" coalesce(convert(varchar(10),CG.FechaCobroAmp,120),'')  'FechaCobroAmp',coalesce(convert(varchar(10),CG.FechaCobroAmp,120),'')  'FechaRecupAmp',coalesce(CG.MontoAmparo,'0') 'MontoAmparo',");
    StrSql.append(" coalesce(convert(varchar(10),CG.FechaCobroBand,120),'') 'FechaCobroBand',coalesce(convert(varchar(10),CG.FechaRecupBand,120),'') 'FechaRecupBand',coalesce(CG.MontoBanderazo,'0') 'MontoBanderazo',");
    StrSql.append(" coalesce(CG.CobroTotal,'3') 'CobroTotal',");
    StrSql.append(" CG.Observaciones 'Observaciones',CG.Antecedentes 'Antecedentes',");
    StrSql.append(" CG.Documentos 'Documentos',CG.BitacoraLlamadas 'BitacoraLlamadas' ");
    StrSql.append(" from CobroGeneradoAL CG ");
    StrSql.append(" inner join Expediente Ex on (CG.clExpediente=Ex.clExpediente) ");
    StrSql.append(" inner join cEstatus Es on (Ex.clEstatus=Es.clEstatus) ");
    StrSql.append(" left join VehiculoInvNU VI on (CG.clExpediente=VI.clExpediente) ");
    StrSql.append(" left join ProveedorxExpediente PE on (CG.clExpediente=PE.clExpediente) ");
    StrSql.append(" left join cProveedor Pr on (PE.clProveedor=Pr.clProveedor and PE.Titular=1) ");
    StrSql.append(" inner join AsistenciaLegal AL on (CG.clExpediente=AL.clExpediente) ");
    StrSql.append(" where CG.clCobroGenerado=").append(StrclCobroGenerado);
    
    ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
  /*  if (rs.next())
    {
     StrEtapaRecup=rs.getString("EtapaRecuperacion");
    }*/
%>
<script>fnOpenLinks()</script>
<%
   StrclPaginaWeb = "560";       
   MyUtil.InicializaParametrosC(560,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
   session.setAttribute("clPaginaWebP",StrclPaginaWeb);
%>

   <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","fnDeshabilita(2);")%>        
   <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetGeneracionControlCobrosGNP.jsp?'>"%>

   <%
   if (rs.next()) {
    

  StrEtapaRecup = rs.getString("EtapaRecuperacion");
 
  if (StrEtapaRecup.equalsIgnoreCase("1")){
   StrCheck1 = "1";
   }
          if (StrEtapaRecup.equalsIgnoreCase("2")){
           StrCheck1="1";
           StrCheck2="1";
          }
            if (StrEtapaRecup.equalsIgnoreCase("3")){
             StrCheck1="1";
             StrCheck2="1";
             StrCheck3="1";
             }
                  if (StrEtapaRecup.equalsIgnoreCase("4")){
                   StrCheck1="1";
                   StrCheck2="1";
                   StrCheck3="1";
                   StrCheck4="1";
                   }
      
   %>
      <INPUT id='clCobroGenerado' name='clCobroGenerado' type='hidden' value='<%=StrclCobroGenerado%>'>
      <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
      <script>document.all.btnAlta.disabled=true;</script>

 		  <%=MyUtil.ObjInput("Monto Daños-GNP","MontoDanoExterno",rs.getString("MontoDanoExterno"),true,true,25,210,"",false,true,20)%>
    
      <div class='VTable' style='position:absolute; z-index:40; left:650px; top:310px;'>
      <input class='cBtn' type='button' value='Calcular' onClick='fnCalculaMontos();'></input></div>
      
		  <%=MyUtil.ObjInput("Costo","CostoAsunto",rs.getString("CostoAsunto"),true,true,150,210,"",false,true,20)%>
      <%=MyUtil.ObjInput("Etapa de recuperación","EtapaRecuperacion",StrEtapaRecup,false,false,275,210,"",false,true,20)%>
      <%=MyUtil.ObjChkBox("Estatus Cobro","Estatus",rs.getString("Estatus"),true,true,430,210,"0","Concluido","Pendiente","")%>
		  
		  <%=MyUtil.ObjChkBox("Etapa 1","Etapa1",StrCheck1,false,true,25,310,StrCheck1,"")%>
      <%=MyUtil.ObjComboC("Porcentaje de cobro","PorcEt1",rs.getString("PorcEt1"),true,true,100,302,"","sp_PorcentajesGNP","","",50,false,false)%>
		  <%=MyUtil.ObjInput("Fecha Cobro<br>AAAA-MM-DD","FechaCobroET1",rs.getString("FechaCobroET1"),true,true,260,290,"",false,false,20)%>
		  <%=MyUtil.ObjInput("Fecha Recuperacion<br>AAAA-MM-DD","FechaRecupET1",rs.getString("FechaRecupET1"),true,true,385,290,"",false,false,20)%>
		  <%=MyUtil.ObjInput("Calcular cobro","MontoEtapa1",rs.getString("MontoEtapa1"),false,false,520,300,"",false,false,20)%>
      
      <%=MyUtil.ObjChkBox("Etapa 2","Etapa2",StrCheck2, true,true,25,360,"","fnVerifica(2)")%>
      <%=MyUtil.ObjComboC("Porcentaje de cobro","PorcEt2",rs.getString("PorcEt2"),false,false,100,352,"","sp_PorcentajesGNP","","",50,false,false)%>
		  <%=MyUtil.ObjInput("","FechaCobroET2",rs.getString("FechaCobroET2"),false,true,260,350,"",false,false,20)%>
		  <%=MyUtil.ObjInput("","FechaRecupET2",rs.getString("FechaRecupET2"),false,true,385,350,"",false,false,20)%>
		  <%=MyUtil.ObjInput("","MontoEtapa2",rs.getString("MontoEtapa2"),false,false,520,350,"",false,false,20)%>

      <%=MyUtil.ObjChkBox("Etapa 3","Etapa3",StrCheck3,true,true,25,410,"","fnVerifica(3)")%>
      <%=MyUtil.ObjComboC("Porcentaje de cobro","PorcEt3",rs.getString("PorcEt3"),false,false,100,402,"","sp_PorcentajesGNP","","",50,false,false)%>
		  <%=MyUtil.ObjInput("","FechaCobroET3",rs.getString("FechaCobroET3"),false,true,260,400,"",false,false,20)%>
		  <%=MyUtil.ObjInput("","FechaRecupET3",rs.getString("FechaRecupET3"),false,true,385,400,"",false,false,20)%>
		  <%=MyUtil.ObjInput("","MontoEtapa3",rs.getString("MontoEtapa3"),false,false,520,400,"",false,false,20)%>

      <%=MyUtil.ObjChkBox("Etapa 4","Etapa4",StrCheck4, true,true,25,460,"","fnVerifica(4)")%>
      <%=MyUtil.ObjComboC("Porcentaje de cobro","PorcEt4",rs.getString("PorcEt4"),false,false,100,452,"","sp_PorcentajesGNP","","",50,false,false)%>
		  <%=MyUtil.ObjInput("","FechaCobroET4",rs.getString("FechaCobroET4"),false,true,260,450,"",false,false,20)%>
		  <%=MyUtil.ObjInput("","FechaRecupET4",rs.getString("FechaRecupET4"),false,true,385,450,"",false,false,20)%>
		  <%=MyUtil.ObjInput("","MontoEtapa4",rs.getString("MontoEtapa4"),false,false,520,450,"",false,false,20)%>
      
      <%=MyUtil.ObjInput("Amparo","FechaCobroAmp",rs.getString("FechaCobroAmp"),true,true,260,500,"",false,false,20)%>
		  <%=MyUtil.ObjInput("","FechaRecupAmp",rs.getString("FechaRecupAmp"),true,true,385,500,"",false,false,20)%>
		  <%=MyUtil.ObjInput("","MontoAmparo",rs.getString("MontoAmparo"),false,false,520,500,"",false,false,20)%>

      <%/*=MyUtil.ObjComboC(con,"Tipo de Cancelación","MontoBanderazo",rs.getString("MontoBanderazo"),true,true,105,552,"","","","",50,false,false)*/%>
      <%=MyUtil.ObjInput("FECHA CANCELACION","FechaCobroBand",rs.getString("FechaCobroBand"),true,true,260,550,"",false,false,20)%>
		  <%=MyUtil.ObjInput("","FechaRecupBand",rs.getString("FechaRecupBand"),true,true,385,550,"",false,false,20)%>
		  <%=MyUtil.ObjInput("","MontoBanderazo",rs.getString("MontoBanderazo"),false,false,520,550,"",false,false,20)%>

      <%=MyUtil.ObjInput("Cobro Total","CobroTotal",rs.getString("CobroTotal"),false,false,520,600,"",false,false,20)%>

      <%=MyUtil.DoBlock("Etapas",30,0)%>
      
   		<%=MyUtil.ObjInput("Observaciones","Observaciones","",true,true,25,690,"",false,false,95)%>
		  <%=MyUtil.ObjInput("Antecedentes siniestro","Antecedentes","",true,true,25,725,"",false,false,95)%>
		  <%=MyUtil.ObjInput("Documentos","Documentos","",true,true,25,760,"",false,false,95)%>
		  <%=MyUtil.ObjInput("Bitacora de llamadas","BitacoraLlamadas","",true,true,25,795,"",false,false,95)%>
      <%=MyUtil.DoBlock("Información adicional",415,0)%>
      <script>
      document.all.FechaCobroET2.disabled=true;
      document.all.FechaRecupET2.disabled=true;
      document.all.FechaCobroET3.disabled=true;
      document.all.FechaRecupET3.disabled=true;
      document.all.FechaCobroET4.disabled=true;
      document.all.FechaRecupET4.disabled=true;
      </script>
       <% 
}  
   else { 
  
        %>
      <script>document.all.btnCambio.disabled=true;</script>
      <INPUT id='clCobroGenerado' name='clCobroGenerado' type='hidden' value='0'>
      <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

	   <%=MyUtil.ObjInput("Expediente","clExpedienteVTR",StrclExpediente,false,false,25,80,StrclExpediente,false,false,15)%>
     <%=MyUtil.ObjInput("Estatus","EstatusExpedienteVTR",StrdsEstatusExp,false,false,125,80,StrdsEstatusExp,false,false,20)%>
     <%=MyUtil.ObjInput("Monto Daño","MontoDanoVTR",StrDanoAjustaNU,false,false,250,80,StrDanoAjustaNU,false,false,25)%>
     <%=MyUtil.ObjInput("Abogado titular","AbogadoTitularVTR",StrNombreOpe,false,false,400,80,StrNombreOpe,false,false,50)%>
     <%=MyUtil.ObjInput("Delitos","dsDelitoVTR",StrDelitos,false,false,25,120,StrDelitos,false,false,50)%>
     <%=MyUtil.DoBlock("Detalle del Expediente",100,0)%>

 		  <%=MyUtil.ObjInput("Monto Daños-GNP","MontoDanoExterno","",true,true,25,210,"",true,false,20)%>
    
      <div class='VTable' style='position:absolute; z-index:40; left:650px; top:310px;'>
      <input class='cBtn' type='button' value='Calcular' onClick='fnCalculaMontos();'></input></div>
      
		  <%=MyUtil.ObjInput("Costo","CostoAsunto","",true,true,150,210,"",true,false,20)%>
      <%=MyUtil.ObjInput("Etapa de recuperación","EtapaRecuperacion","",false,true,275,210,"1",true,false,20)%>
      <%=MyUtil.ObjChkBox("Estatus Cobro","Estatus","",true,true,430,210,"0","Concluido","Pendiente","")%>
		  
		  <%=MyUtil.ObjChkBox("Etapa 1","Etapa1","",false,false,25,310,"1","")%>
      <%=MyUtil.ObjComboC("Porcentaje de cobro","PorcEt1","",true,true,100,302,"","sp_PorcentajesGNP","","",50,false,false)%>
		  <%=MyUtil.ObjInput("Fecha Cobro<br>AAAA-MM-DD","FechaCobroET1","",true,true,260,290,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("Fecha Recuperacion<br>AAAA-MM-DD","FechaRecupET1","",true,true,385,290,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("Calcular cobro","MontoEtapa1","",false,true,520,300,"",false,false,20)%>
      
      <%=MyUtil.ObjChkBox("Etapa 2","Etapa2","", true,true,25,360,"","fnVerifica(2)")%>
      <%=MyUtil.ObjComboC("Porcentaje de cobro","PorcEt2","",false,false,100,352,"","sp_PorcentajesGNP","","",50,false,false)%>
		  <%=MyUtil.ObjInput("","FechaCobroET2","",true,true,260,350,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("","FechaRecupET2","",true,true,385,350,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("","MontoEtapa2","",false,false,520,350,"",false,false,20)%>

      <%=MyUtil.ObjChkBox("Etapa 3","Etapa3","",true,true,25,410,"","fnVerifica(3)")%>
      <%=MyUtil.ObjComboC("Porcentaje de cobro","PorcEt3","",false,true,100,402,"","sp_PorcentajesGNP","","",50,false,false)%>
		  <%=MyUtil.ObjInput("","FechaCobroET3","",true,true,260,400,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("","FechaRecupET3","",true,true,385,400,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("","MontoEtapa3","",false,true,520,400,"",false,false,20)%>

      <%=MyUtil.ObjChkBox("Etapa 4","Etapa4","", true,true,25,460,"","fnVerifica(4)")%>
      <%=MyUtil.ObjComboC("Porcentaje de cobro","PorcEt4","",false,true,100,452,"","sp_PorcentajesGNP","","",50,false,false)%>
		  <%=MyUtil.ObjInput("","FechaCobroET4","",true,true,260,450,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("","FechaRecupET4","",true,true,385,450,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("","MontoEtapa4","",false,true,520,450,"",false,false,20)%>
      
      <%=MyUtil.ObjInput("Amparo","FechaCobroAmp","",true,true,260,500,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("","FechaRecupAmp","",true,true,385,500,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("","MontoAmparo","",false,true,520,500,"",false,false,20)%>

      <%/*=MyUtil.ObjComboC(con,"Tipo de Cancelación","MontoBanderazo","",true,true,105,552,"","","","",50,false,false)*/%>
      <%=MyUtil.ObjInput("FECHA CANCELACION","FechaCobroBand","",true,true,260,550,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("","FechaRecupBand","",true,true,385,550,"",false,false,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
		  <%=MyUtil.ObjInput("","MontoBanderazo","",false,true,520,550,"",false,false,20)%>

      <%=MyUtil.ObjInput("Cobro Total","CobroTotal","",false,false,520,600,"",false,false,20)%>

      <%=MyUtil.DoBlock("Etapas",30,0)%>
      
   		<%=MyUtil.ObjInput("Observaciones","Observaciones","",true,true,25,690,"",false,false,95)%>
		  <%=MyUtil.ObjInput("Antecedentes siniestro","Antecedentes","",true,true,25,725,"",false,false,95)%>
		  <%=MyUtil.ObjInput("Documentos","Documentos","",true,true,25,760,"",false,false,95)%>
		  <%=MyUtil.ObjInput("Bitacora de llamadas","BitacoraLlamadas","",true,true,25,795,"",false,false,95)%>
      <%=MyUtil.DoBlock("Información adicional",415,0)%>
       
        <%
    }%>
        <%=MyUtil.GeneraScripts()%><%
        rs.close();
        rsExp.close();

        rs=null;
        rsExp=null;

 %>
<input name='FechaSingleMsk' id='FechaSingleMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script>

//fnDeshabilita(2);

function fnCalculaMontos()
{
 if (document.all.Action.value==1 || document.all.Action.value==2)
 {
  document.all.MontoEtapa1.value = "";
  document.all.MontoEtapa2.value = "";       
  document.all.MontoEtapa3.value = "";       
  document.all.MontoEtapa4.value = "";       
  document.all.MontoAmparo.value = "";       
  document.all.MontoBanderazo.value = "";

  if(document.all.MontoDanoExterno.value=="")
  document.all.MontoDanoExterno.value=0;
  
  var pstrCadena = "CalculaMontoGNP.jsp?";
  pstrCadena = pstrCadena + "MontoDanoExterno=" + document.all.MontoDanoExterno.value + "&PorcEt1=" + document.all.PorcEt1.value + "&PorcEt2=" + document.all.PorcEt2.value + "&PorcEt3=" + document.all.PorcEt3.value + "&PorcEt4=" + document.all.PorcEt4.value + "&FechaCobroET1=" + document.all.FechaCobroET1.value + "&FechaCobroET2=" + document.all.FechaCobroET2.value + "&FechaCobroET3=" + document.all.FechaCobroET3.value;
  pstrCadena = pstrCadena + "&FechaCobroET4=" + document.all.FechaCobroET4.value + "&FechaCobroAmp=" + document.all.FechaCobroAmp.value + "&FechaCobroBand=" + document.all.FechaCobroBand.value;
  window.open(pstrCadena,'newWin','resizable=no,menubar=0,status=0,toolbar=0,height=10,width=10,screenX=-50,screenY=0');
 }
}

function fnActualizaMontos(pMontoEtapa1,pMontoEtapa2,pMontoEtapa3,pMontoEtapa4,pMontoAmparo,pMontoBanderazo,pTotal)
{
 document.all.MontoEtapa1.value = pMontoEtapa1;
 document.all.MontoEtapa2.value = pMontoEtapa2;
 document.all.MontoEtapa3.value = pMontoEtapa3;
 document.all.MontoEtapa4.value = pMontoEtapa4;
 document.all.MontoAmparo.value = pMontoAmparo;
 document.all.MontoBanderazo.value = pMontoBanderazo;
 document.all.CobroTotal.value = pTotal;
}

function fnVerifica(eta)
{
 switch(eta)
 {
  case 2:
  if(document.all.Etapa2.value == 1)
  {
   fnValidaEtapa(eta);
   
  }
  else
  {
   fnDeshabilita(eta);
   fnLimpia(eta);
   document.forma.PorcEt2C.checked = false;
   
  }
  break;
  case 3:
  if(document.all.Etapa3.value == 1)
  {
   fnValidaEtapa(eta);
  }
  else
  {
   fnDeshabilita(eta);
   fnLimpia(eta);
}
  break;
  case 4:
  if(document.all.Etapa4.value == 1)
  {
   fnValidaEtapa(eta);
  }
  else
  {
   fnDeshabilita(eta);
   fnLimpia(eta);

  }
  break
  default:
 }
}

function fnDeshabilita(habilita) 
{
 i=habilita
 for (i=habilita;i <= 4 ; i++)
 {
  switch(i)
  { 
    case 1://Desabilita la segunda etapa

          document.all.PorcEt1C.disabled=true;
          document.all.FechaCobroET1.disabled=true;
          document.all.FechaRecupET1.disabled=true;
          document.all.MontoEtapa1.disabled=true;
   break;
   case 2://Desabilita la segunda etapa

          document.all.PorcEt2C.disabled=true;
          document.all.FechaCobroET2.disabled=true;
          document.all.FechaRecupET2.disabled=true;
          document.all.MontoEtapa2.disabled=true;
   break;
   case 3://Deshabilita la tercera etapa
          document.all.PorcEt3C.disabled=true;
          document.all.FechaCobroET3.disabled=true;
          document.all.FechaRecupET3.disabled=true;
          document.all.MontoEtapa3.disabled=true;
   break;
   case 4://Desahabilita la cuarta etapa
          document.all.PorcEt4C.disabled=true;
          document.all.FechaCobroET4.disabled=true;
          document.all.FechaRecupET4.disabled=true;
          document.all.MontoEtapa4.disabled=true;
   break;
   default:
          alert("Existe un problema con la estructura de fnDeshabilita");
  }
  //alert(i);
 }
}

function fnValidaEtapa (pEtapa)
{
 switch (pEtapa)
 {
  case 2://Verifica que la etapa anterior este habilitada
         if (document.all.Etapa1.value == 0)
         {
          alert("FALTA INFORMACION DE LA ETAPA 1");
         }
         else
         {//Habilita los campos
          document.all.PorcEt2C.disabled=false;
          document.all.FechaCobroET2.disabled=false;
          document.all.FechaRecupET2.disabled=false;
          document.all.MontoEtapa2.disabled=false;
          document.all.EtapaRecuperacion.value="2";
         }
  break;
  case 3:
         if ((document.all.Etapa1.value == 0) || (document.all.Etapa2.value == 0))
         {
          if(document.all.Etapa1.value == 0)
          {
           alert("FALTA INFORMACION DE LA ETAPA 1");
          }
          else
          {
           alert("FALTA INFORMACION DE LA ETAPA 2");
          }
          document.all.Etapa3C.checked=false;
         }
         else
         {
          document.all.PorcEt3C.disabled=false;
          document.all.FechaCobroET3.disabled=false;
          document.all.FechaRecupET3.disabled=false;
          document.all.MontoEtapa3.disabled=false;          
          document.all.EtapaRecuperacion.value="3";
         }
  break;
  case 4:
         if ((document.all.Etapa1.value == 0) || (document.all.Etapa2.value == 0) ||(document.all.Etapa3.value == 0))
         {
          if (document.all.Etapa1.value == 0)
          {
           alert("FALTA INFORMACION DE LA ETAPA 1");
          }
          else
          {
           if(document.all.Etapa2.value == 0)
           {
            alert("FALTA INFORMACION DE LA ETAPA 2");
           }
           else 
           {
            alert("FALTA INFORMACION DE LA ETAPA 3");
         
           
           }
          }document.all.Etapa4C.checked=false;
         }
         else
         {
          document.all.PorcEt4C.disabled=false;
          document.all.FechaCobroET4.disabled=false;
          document.all.FechaRecupET4.disabled=false;
          document.all.MontoEtapa4.disabled=false;
          document.all.EtapaRecuperacion.value="4";
         }
  break;
   default:
           alert("Error de ejecución Opción no valida" );
 }
}

function fnLimpia(pveces)
{
 
 for(i=pveces;i<=4;i++)
 {
  switch(i)
  {
     case 1:
          document.all.Etapa1C.checked=false;
          document.all.Etapa1C.value=0;
          document.all.PorcEt1C.value="";
          document.all.FechaCobroET1.value="";
          document.all.FechaRecupET1.value="";
          document.all.MontoEtapa1.value="";
          document.all.EtapaRecuperacion.value=pveces-1;
   break;
   case 2:
          document.all.Etapa2C.checked=false;
          document.all.Etapa2C.value=0;
          document.all.PorcEt2C.value="";
          document.all.FechaCobroET2.value="";
          document.all.FechaRecupET2.value="";
          document.all.MontoEtapa2.value="";
          document.all.EtapaRecuperacion.value=pveces-1;
   break;
   case 3:
          document.all.Etapa3C.checked=false;
          document.all.Etapa3C.value=0;
          document.all.PorcEt3C.value="";
          document.all.FechaCobroET3.value="";
          document.all.FechaRecupET3.value="";
          document.all.MontoEtapa3.value="";
          document.all.EtapaRecuperacion.value=pveces-1;
   break;
   case 4:
          document.all.Etapa4C.checked=false;
          document.all.Etapa4C.value=0;
          document.all.PorcEt4C.value="";
          document.all.FechaCobroET4.value="";
          document.all.FechaRecupET4.value="";
          document.all.MontoEtapa4.value="";
          document.all.EtapaRecuperacion.value=pveces-1;          
   break;
   default:
  }
 }
}
/*
function fncancelacion()
{
if document.all.MontoBanderazo.value!=0
{
fndeshabilita(1);
fnLimpia(1);
}

}*/

</script>


</body>
</html>


