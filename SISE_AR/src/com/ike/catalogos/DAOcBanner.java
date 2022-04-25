/*
 * DAOcBanner.java
 * 
 * Created 2010-10-04
 * 
 */
package com.ike.catalogos;

import com.ike.catalogos.to.cBanner;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @autor vsampablo
 */
public class DAOcBanner extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOcBanner */
    public DAOcBanner() {
    }

    public cBanner getclBanner(String clBanner) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;
        sb.append("st_cBanner ").append(clBanner);
        col = this.rsSQLNP(sb.toString(), new cBannerFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (cBanner) it.next() : null;
    }

    /* Creates Filler of cBanner */
    public class cBannerFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            cBanner B = new cBanner();

            B.setclBanner(rs.getString("clBanner"));
            B.setdsBanner(rs.getString("dsBanner"));
            B.setFechaAlta(rs.getString("FechaAlta"));
            B.setTiempo(rs.getString("Tiempo"));
            B.setclGpoUsr(rs.getString("clGpoUsr"));
            B.setdsGpoUsr(rs.getString("dsGpoUsr"));
            B.setActivo(rs.getString("Activo"));
            B.setclUsrApp(rs.getString("clUsrApp"));

            return B;
        }
    }
}
