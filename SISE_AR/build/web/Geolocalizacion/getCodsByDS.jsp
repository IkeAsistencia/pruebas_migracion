<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.ResultSet,Utilerias.UtileriasBDF,java.text.Normalizer, Combos.cbEntidad" %><%
    String sProvincia = (request.getParameter("dsEntFed")!=null?request.getParameter("dsEntFed").toUpperCase():null);
    System.out.println("**Geolocalizacion/getCodsByDS.jsp:"  +sProvincia);
    sProvincia = Normalizer.normalize(sProvincia, Normalizer.Form.NFD).replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
    if ( sProvincia.indexOf("PCIA DE") > -1) {
        sProvincia = sProvincia.substring(8);
        System.out.println("getCodsByDS.Warn: SE QUITO \"PCIA DE\" en " + sProvincia) ;
    }
    else {
        if ( sProvincia.indexOf("PROVINCIA DE")  > -1) {
        sProvincia = sProvincia.substring(12).trim();
        System.out.println("getCodsByDS.Warn: SE QUITO \"PROVINCIA DE\" en " + sProvincia) ;
        }
    }
    //Se quita acentos de provincias ya que las mismas estan guardadas en la DB sin acento.

    String sLocalidad = (request.getParameter("dsMunDel")!=null?request.getParameter("dsMunDel").toUpperCase():null);
    String sSource    = (request.getParameter("source")!=null?request.getParameter("source").toUpperCase():"");
    boolean bAltaEnBase=(request.getParameter("altaEnBase")!=null?request.getParameter("altaEnBase").equalsIgnoreCase("TRUE"):false);
    
    
    StringBuilder sRet = new StringBuilder("[");
    System.out.println("getCodsByDS:" + sProvincia + "::" + sLocalidad + "::" + sSource + ":: AltaEnBase:" + (bAltaEnBase?"true":"false") );
    try {
        if (sProvincia != null) {
            sProvincia = (sProvincia.trim().equalsIgnoreCase("CABA")?"CAPITAL FEDERAL":sProvincia);
            String StrSql = "st_GetCodEntyMDByDs '" + sProvincia + "', '" + sLocalidad + "', '" + sSource + "', " + (bAltaEnBase?"1":"0");
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            if (rs.next() ) {
                sRet.append("{");
                sRet.append("\"codEndFed\":").append("\"" + rs.getString("codEnt") + "\",");
                sRet.append("\"codMunDel\":").append("\"" + rs.getString("codMD") + "\",");
                sRet.append("\"dsEntFed\":").append("\"" + sProvincia + "\",");
                sRet.append("\"dsMunDel\":").append("\"" + sLocalidad + "\"");
                //sRet.append("\"NuevaLocalidad\":").append("\"" + rs.geteString("nueva") + "\"");
                sRet.append("}");
                System.out.println("INSERTA LOCALIDAD:" + rs.getInt("ALTA") );                
                if ( rs.getInt("ALTA") == 1 && sLocalidad != null)  {
                    //dar de alta la localidad en el cache.
                    System.out.println("Dando de alta localidad");
                    boolean resultado = cbEntidad.altaLocalidadEnCache(rs.getString("codEnt"), rs.getString("codMD"), sLocalidad);
                    System.out.println( rs.getString("codEnt") + ":" + rs.getString("codMD") + ":" + sLocalidad + ":" + (resultado ? "ALTA OK" : "ALTA ERROR" ) );
                }
            }
        }
    }
    catch (Exception e) {
        System.out.println("Geolocalizacion/getCodsByDS.jsp.error:" + e.toString());
    }
    sRet.append("]");
    System.out.println( "getCodsByDS" + sRet.toString());
    out.print(sRet.toString());%>