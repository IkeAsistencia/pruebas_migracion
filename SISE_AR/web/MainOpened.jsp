<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
	<frameset framespacing='0' noresize frameborder='no' id='topm' rows='70,*'>
	<frame frameborder='no' name='encabezado' noresize id='encabezado' src='FrameEncabezado.jsp' scrolling='no'></frame>
	<frameset framespacing='0' noresize frameborder='no' id='topPO' cols='250,*'>
	   <frameset framespacing='0' noresize frameborder='no' id='leftPO' rows='80,*,0'>                
		    <frame frameborder='no' scrolling='no' name='DatosUsuario' noresize id='DatosUsuario' src='DatosUsuario.jsp' ></frame>
		    <frame frameborder='no' name='Menu' noresize id='Menu' src='Menu.jsp' ></frame>                        
    	       <frame frameborder='no' name='InfoRelacionada' noresize id='InfoRelacionada' src='InfoRelacionada.jsp' ></frame>	        
           </frameset>
	   <frameset framespacing='0' noresize frameborder='no' id='rightPO' rows='70,*'>                
		    <frame frameborder='no' scrolling='auto' name='DatosExpediente' noresize id='DatosExpediente' src='DatosExpediente.jsp' ></frame>
    	       <frame frameborder='no' name='Contenido' noresize id='Contenido' src='Bienvenido.jsp' ></frame>	        
           </frameset>        
	</frameset>
	</frameset>	
</html>
