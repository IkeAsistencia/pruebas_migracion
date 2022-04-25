<%@ page contentType="text/html;charset=windows-1252"%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Prueba</title>
  </head>
  <body>
  <form target="new" action="../../servlet/Interfases.Sabre.ProcesaSabre" method="get">
  <textarea cols=80 rows=30 id='request' name ='request'>
      <EDISONXMLDATA VERSION="2.0" AGGREGATORCODE="IM" EMAILHELP="">
      <EDISONSTATEINFO>12345<EDISONSTATEINFO>
      <VENDORSTATEINFO/>
      <BOOKINGSOURCE>PSS</BOOKINGSOURCE>
      <INSREQUEST>
      IAIRMAA 
      HDQRMAA 291547 
      HDQAA JZZKEY/E072/86764941 
      2ZEPEDA/PAULA ANDREA CHD/CAROLINACHD 
      INS IM XX1 MEX 01JUL NM-ZEPEDA/PAU/PD-29JUN06/LD-16JUL06/PT-BAGG/PR-TOT 124.00 PRIMA 107.83 IMP 16.17/CF-1A040764/KY 
      INS IM NN1 MEX 01JUL PD-29JUN06/LD-15JUL06/PT-BAGG/NM-PAULA ANDREA CHD ZEPEDA/NM-CAROLINACHD ZEPEDA/DE-MIA/CR-MXN/FP-CA/BS-8676494 1/SG-00003 
      OSI IM CTC-9MEX5543 2986 H 
      OSI IM CTC-9MEX5 688 8577 A 
      OSI IM COV-N1.1PX-C/DB-14JUN1993/BE-PATRICIA MOLINEROS JARAMILL 
      OSI IM COV-N1.2PX-C/DB-26OCT1995/BE-PATRICIA MOLINEROS JARAMILL 
      OSI IM COV-AG-02 
      OSI IM COV-LG-SPANISH 
      </INSREQUEST>
      <INSRESPONSE/>
      </EDISONXMLDATA>
  </textarea><br>
  <input type="submit" value="Enviar"></input>
  </form>    
  </body>
</html>