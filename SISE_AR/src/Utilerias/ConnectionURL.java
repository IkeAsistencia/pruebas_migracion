package Utilerias;

import java.io.*;
import java.net.*;

public class ConnectionURL {

    public ConnectionURL() {
    }

    public String SendtoURL(String StrURL, String strParametros) {
        String line = "";
        String RespuestaURL = "";
        try {
            URL url = new URL((new StringBuilder()).append(StrURL).append(strParametros).toString());
            if (ExistsURL(StrURL)) {
                URLConnection con = url.openConnection();
                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                for (String inputLine = ""; (inputLine = in.readLine()) != null;) {
                    RespuestaURL = (new StringBuilder()).append(RespuestaURL).append(inputLine).toString();
                }

                in.close();
            } else {
                RespuestaURL = "Estado HTTP 404: No Existe La P\341gina Web";
            }
        } catch (Exception ex) {
            System.out.println((new StringBuilder()).append("ERROR SendtoURL: ").append(StrURL).append(strParametros).toString());
            ex.printStackTrace();
        }
        return RespuestaURL;
    }

    public boolean ExistsURL(String StrURL) {
        try {
            HttpURLConnection.setFollowRedirects(false);
            HttpURLConnection con = (HttpURLConnection) (new URL(StrURL)).openConnection();
            con.setRequestMethod("HEAD");
            return con.getResponseCode() == 200;
        } catch (Exception e) {
            System.out.println("ERROR ExistsURL: ");
            e.printStackTrace();
            return false;
        }
    }

    public String getValueofTag(String RespuestaURL, String Tag) {
        RespuestaURL = RespuestaURL.replace(" ", "");
        int index = 0;
        index = RespuestaURL.indexOf(Tag, 0);
        try {
            RespuestaURL = RespuestaURL.substring(index + Tag.length());
        } catch (Exception ex) {
            System.out.println((new StringBuilder()).append("ERROR getValueofTag1:    Resp:").append(RespuestaURL).append("   Tag:").append(Tag).toString());
            ex.printStackTrace();
        }
        Tag = Tag.replace("<", "</");
        index = RespuestaURL.indexOf(Tag, 0);
        try {
            RespuestaURL = RespuestaURL.substring(0, index);
        } catch (Exception ex2) {
            System.out.println((new StringBuilder()).append("ERROR getValueofTag2:    Resp:").append(RespuestaURL).append("   index:").append(index).toString());
            ex2.printStackTrace();
        }
        return RespuestaURL;
    }

    public String getValueofTagCE(String RespuestaURL, String Tag) {
        RespuestaURL = RespuestaURL.replace(" ", "%20");
        int index = 0;
        index = RespuestaURL.indexOf(Tag, 0);
        try {
            RespuestaURL = RespuestaURL.substring(index + Tag.length());
        } catch (Exception ex) {
            System.out.println((new StringBuilder()).append("ERROR getValueofTag1:    Resp:").append(RespuestaURL).append("   Tag:").append(Tag).toString());
            ex.printStackTrace();
        }
        Tag = Tag.replace("<", "</");
        index = RespuestaURL.indexOf(Tag, 0);
        try {
            RespuestaURL = RespuestaURL.substring(0, index);
        } catch (Exception ex2) {
            System.out.println((new StringBuilder()).append("ERROR getValueofTag2:    Resp:").append(RespuestaURL).append("   index:").append(index).toString());
            ex2.printStackTrace();
        }
        return RespuestaURL;
    }

    public String getValueofTagE(String RespuestaURL, String Tag) {
        int index = 0;
        index = RespuestaURL.indexOf(Tag, 0);
        try {
            RespuestaURL = RespuestaURL.substring(index + Tag.length());
        } catch (Exception ex) {
            System.out.println((new StringBuilder()).append("ERROR getValueofTag1:    Resp:").append(RespuestaURL).append("   Tag:").append(Tag).toString());
            ex.printStackTrace();
        }
        Tag = Tag.replace("<", "</");
        index = RespuestaURL.indexOf(Tag, 0);
        try {
            RespuestaURL = RespuestaURL.substring(0, index);
        } catch (Exception ex2) {
            System.out.println((new StringBuilder()).append("ERROR getValueofTag2:    Resp:").append(RespuestaURL).append("   index:").append(index).toString());
            ex2.printStackTrace();
        }
        return RespuestaURL;
    }

    public String getValueofTagD(String RespuestaURL, String Tag) {
        String TagIni = (new StringBuilder()).append("<").append(Tag).append(">").toString();
        String TagFin = (new StringBuilder()).append("</").append(Tag).append(">").toString();
        int LongTagIni = TagIni.length();
        //int LongTagFin = TagFin.length();
        int index = 0;
        index = RespuestaURL.indexOf(TagIni, 0);
        if (index >= 0) {
            try {
                RespuestaURL = RespuestaURL.substring(index + LongTagIni, RespuestaURL.length());
            } catch (Exception ex) {
                System.out.println((new StringBuilder()).append("SISE BR CONNECTION URL: ERROR getValueofTagD1: ").append(RespuestaURL).append(" Tag:").append(Tag).toString());
                ex.printStackTrace();
            }
            try {
                index = RespuestaURL.indexOf(TagFin, 0);
                RespuestaURL = RespuestaURL.substring(0, index);
            } catch (Exception ex2) {
                System.out.println((new StringBuilder()).append("SISE BR CONNECTION URL: ERROR getValueofTagD2: ").append(RespuestaURL).append(" Tag:").append(Tag).toString());
                ex2.printStackTrace();
            }
        }
        return RespuestaURL;
    }
}