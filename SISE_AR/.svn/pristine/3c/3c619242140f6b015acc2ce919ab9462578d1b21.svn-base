<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>CALIFICA</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>

            <%
                String StrSolicitudxCalificar = "";
                String StrclSolicitud = "";
            %>

            <%
                if (session.getAttribute("SolicitudxCalificar") != null) {
                    StrSolicitudxCalificar = session.getAttribute("SolicitudxCalificar").toString();
                }

               // session.setAttribute("clSolicitud", StrSolicitudxCalificar);
%>

            .formatB{
                font-family: Verdana, Arial, sans-serif;
                color: #082D64;
                font-size: 12px;
                text-transform: uppercase;
            }

        </style>    
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>  

    <body>  
        <div ALIGN="CENTER">
            <br>
            <DIV CLASS="imagen"><img src="../Imagenes/IKE-HTal50.jpg" width="258" height="56" alt="IKE_logo"/>
            </DIV>
            <TABLE width=450>
                <TR ALIGN="center" style="border-left:5px; border-right:5px; height:50px">
                <br> <br>
                <TD style=' border-top:2.0pt solid #547DBB; height:15.0pt;  border-left:2.0pt solid #547DBB; border-right:2.0pt solid #547DBB; border-bottom:2.0pt solid #547DBB; height:45pt'>
                    <A CLASS="formatB">
                        <FONT  SIZE="2" ><STRONG>
                                NO SE PUEDE INGRESAR UNA NUEVA SOLICITUD, HASTA QUE SE HALLA CALIFICADO LA SOLICITUD: <%=StrSolicitudxCalificar%>  DEL HELP DESK 
                        </FONT></STRONG>
                        <table><tr><td><table><a target='Contenido' href='CalificacionSP.jsp?clSolicitud=<%=StrSolicitudxCalificar%>'><tr><td width=200 class='cssLinkOv' onMouseOver=this.className = 'cssLinkOu' onMouseOut=this.className = 'cssLinkOv'>Calificar la Solicitud <%=StrSolicitudxCalificar%></td></tr></a></table>
                                    </A>     
                                </TD>
                            </TR>
                        </TABLE>   
                        </div>   
                        </body>
                        </html>

                        <script>
                            function fnCalficaSolicitud() {
                                var pstrCadena = "CalificarSolicitudSP.jsp?SolicitudxCalificar=2";
                                window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=1,height=1');
                            }
                        </script>
