<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>

<%
    String strclUsr = "0";
    //String StrPermisoBanner = "0";

    if (session.getAttribute("clUsrApp") != null) {
        strclUsr = session.getAttribute("clUsrApp").toString();

        StringBuffer StrSql = new StringBuffer();
        StrSql.append("st_Encabezado ").append(strclUsr);

        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        int iBanners = 0;
%>
<html>
    <body>
        <%
            while (rs.next()) {
                //StrPermisoBanner = rs.getString("clBanner");%>
        <div class="offer-holder"><%=rs.getString("dsBanner")%></div><%
                iBanners++;
            }
            if (iBanners == 0) {
        %><div class="offer-holder"><span class="Seconds">60</span></div><%
                iBanners = 1;
            }
            %>
        <input type="hidden" value="<%=iBanners%>" id="NumBanners" name="NumBanners">
        <% rs.close();
            rs = null;
        %>
    </body>
</html>

<%}%>


