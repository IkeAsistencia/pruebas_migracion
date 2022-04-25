package Utilerias;

import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jfree.chart.plot.PiePlot3D;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.util.Rotation;
import java.sql.ResultSet;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;

import java.awt.Color;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;

import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.data.category.DefaultCategoryDataset;

public class SGrafica extends HttpServlet {

    private String StrDataSetX = "";
    private ResultSet rsEx = null;
    private double intDataSetY = 0;
    private double intDataSetl = 0;
    private double intDataSet2 = 0;
    private double intDataSet3 = 0;
    private double intDataSet4 = 0;
    private double intDataSet5 = 0;
    private double intDataSet6 = 0;
    private double intDataSet7 = 0;
    private double intDataSet8 = 0;
    private double intDataSet9 = 0;
    private double intDataSet10 = 0;
    private double intDataSet11 = 0;
    private double intDataSet12 = 0;
    private double intDataSet13 = 0;
    private String sentenciaSQLG = "";
    private String dsCampo = "";
    private String dsx = "";
    private String dsCampoCan = "";
    private String Pagina;
    private String GrTitulo = "";
    private String XTitle = "";
    private String YTitle = "";

    public SGrafica() {
    }

    public synchronized void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OutputStream out = response.getOutputStream();
        try {
            String type = request.getParameter("type");
            String dsCampoL = request.getParameter("dsCampo").toString().trim();
            String dsCampoC = request.getParameter("dsCampoCan").toString().trim();
            String TipoG = request.getParameter("Tipo").toString().trim();
            Pagina = request.getParameter("Pagina").toString().trim(); /*Agredado*/
            sentenciaSQLG = type;
            dsCampo = dsCampoL;
            dsCampoCan = dsCampoC;
            JFreeChart chart = null;

            if (request.getParameter("Titulo") != null) {
                GrTitulo = request.getParameter("Titulo").toString().trim();
            }

            if (TipoG.equalsIgnoreCase("1")) {
                if (Pagina.equalsIgnoreCase("40") || Pagina.equalsIgnoreCase("56") || Pagina.equalsIgnoreCase("43") || Pagina.equalsIgnoreCase("59")) {
                    chart = crearChartM();
                } else {
                    chart = crearChart();
                    /*Sintaxis para convertir graficos a pdf*/
                    /*ConvertPDF pdf = new ConvertPDF();
                     org.jfree.text.TextUtilities.setUseDrawRotatedStringWorkaround(false);
                     pdf.convertToPdf(crearChart(), 400, 600, "GraficoPie.pdf");*/
                }
            }

            if (TipoG.equalsIgnoreCase("2")) {
                if (Pagina.equalsIgnoreCase("23")) {
                    chart = createBarChartM();
                } else {
                    if (Pagina.equalsIgnoreCase("42") || Pagina.equalsIgnoreCase("44") || Pagina.equalsIgnoreCase("46") || Pagina.equalsIgnoreCase("58") || Pagina.equalsIgnoreCase("60") || Pagina.equalsIgnoreCase("62")) {
                        chart = createBarChartR();
                    } else {
                        if (Pagina.equalsIgnoreCase("17") || Pagina.equalsIgnoreCase("19") || Pagina.equalsIgnoreCase("20") || Pagina.equalsIgnoreCase("21")) {
                            chart = createBarChartMultipl();
                        } else {
                            chart = createBarChart();
                            //chart = createBarChartMG();
                        }
                    }
                }
            }
            if (TipoG.equalsIgnoreCase("3")) {
                chart = createLineChart();
            }

            if (TipoG.equalsIgnoreCase("4")) {
                chart = createBarChartMG();
            }

            if (TipoG.equalsIgnoreCase("5")) {
                chart = createMLineChart();
            }


            if (chart != null) {
                if (Pagina.equalsIgnoreCase("23")) {
                    response.setContentType("image/jpeg");
                    ChartUtilities.writeChartAsJPEG(out, chart, 680, 540);
                } else {
                    if (Pagina.equalsIgnoreCase("17") || Pagina.equalsIgnoreCase("19") || Pagina.equalsIgnoreCase("20") || Pagina.equalsIgnoreCase("21")) {
                        response.setContentType("image/jpeg");
                        ChartUtilities.writeChartAsJPEG(out, chart, 700, 600);
                    } else if (Pagina.equalsIgnoreCase("689")) {
                        response.setContentType("image/jpeg");
                        ChartUtilities.writeChartAsJPEG(out, chart, 500, 500);
                    } else if (Pagina.equalsIgnoreCase("696")) {
                        response.setContentType("image/jpeg");
                        ChartUtilities.writeChartAsJPEG(out, chart, 300, 200);
                    } else if (Pagina.equalsIgnoreCase("714")) {
                        response.setContentType("image/jpeg");
                        ChartUtilities.writeChartAsJPEG(out, chart, 500, 500);
                    } else {
                        response.setContentType("image/jpeg");
                        ChartUtilities.writeChartAsJPEG(out, chart, 800, 600);
                    }
                }
            }

        } catch (Exception e) {
            System.err.println(e.toString());
        } finally {
            out.close();
        }
    }

    private JFreeChart crearChart() {
        DefaultPieDataset dataset = new DefaultPieDataset();
        try {
            rsEx = UtileriasBDF.rsSQLNP(sentenciaSQLG);

            while (rsEx.next()) {
                if (!rsEx.getString(dsCampo).equalsIgnoreCase("TOTALES")) {
                    StrDataSetX = rsEx.getString(dsCampo);
                    intDataSetY = rsEx.getDouble(dsCampoCan);
                    dataset.setValue(StrDataSetX, intDataSetY);
                }
            }
            StrDataSetX = null;
            String sentenciaSQLG = null;
            String dsCampo = null;
            String dsCampoCan = null;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;

                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }

        JFreeChart chart = ChartFactory.createPieChart3D("", dataset, true, true, true);
        final PiePlot3D plot = (PiePlot3D) chart.getPlot();
        plot.setStartAngle(290);
        plot.setDirection(Rotation.CLOCKWISE);
        plot.setForegroundAlpha(0.5f);
        plot.setNoDataMessage("Sin Imagen");
        return chart;
    }

    private JFreeChart createBarChart() {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        try {
            rsEx = UtileriasBDF.rsSQLNP(sentenciaSQLG);
            while (rsEx.next()) {
                StrDataSetX = rsEx.getString(dsCampo);
                intDataSetl = rsEx.getDouble(dsCampoCan);
                dataset.addValue(intDataSetl, StrDataSetX, dsCampo);
            }
            StrDataSetX = null;
            String sentenciaSQLG = null;
            String dsCampo = null;
            String dsCampoCan = null;
        } catch (Exception e) {
            e.printStackTrace();
            this.destroy();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;

                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        JFreeChart chart = ChartFactory.createBarChart3D("", "", "Porcentaje", dataset, PlotOrientation.VERTICAL, true, true, false);
        return chart;
    }

    private JFreeChart createBarChartM() {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        try {
            rsEx = UtileriasBDF.rsSQLNP(sentenciaSQLG);
            while (rsEx.next()) {
                StrDataSetX/*Campo*/ = rsEx.getString(dsCampo);
                intDataSetl/*Valor*/ = rsEx.getDouble("Reparacion");
                intDataSet2/*Valor*/ = rsEx.getDouble("Staff");
                intDataSet3/*Valor*/ = rsEx.getDouble("Estacionamiento");
                intDataSet4/*Valor*/ = rsEx.getDouble("Limpieza");
                intDataSet5/*Valor*/ = rsEx.getDouble("Entrega_Tiempo");
                intDataSet6/*Valor*/ = rsEx.getDouble("Comunicacion");
                intDataSet7/*Valor*/ = rsEx.getDouble("Desempeno");
                intDataSet8/*Valor*/ = rsEx.getDouble("Recomendaria");

                dataset.addValue(intDataSetl, StrDataSetX, "Reparacion");
                dataset.addValue(intDataSet2, StrDataSetX, "Staff");
                dataset.addValue(intDataSet3, StrDataSetX, "Estacionamiento");
                dataset.addValue(intDataSet4, StrDataSetX, "Limpieza");
                dataset.addValue(intDataSet5, StrDataSetX, "Entrega_Tiempo");
                dataset.addValue(intDataSet6, StrDataSetX, "Comunicacion");
                dataset.addValue(intDataSet7, StrDataSetX, "Desempeno");
                dataset.addValue(intDataSet8, StrDataSetX, "Recomendaria");
            }
            StrDataSetX = null;
            String sentenciaSQLG = null;
            String dsCampo = null;
            String dsCampoCan = null;
        } catch (Exception e) {
            e.printStackTrace();
            this.destroy();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;

                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        JFreeChart chart = ChartFactory.createBarChart3D("", "", "Porcentaje", dataset, PlotOrientation.HORIZONTAL, true, true, false);
        return chart;
    }

    private JFreeChart createBarChartMG() {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        int Inicio = 0;
        try {
            rsEx = UtileriasBDF.rsSQLNP(sentenciaSQLG);
            java.sql.ResultSetMetaData metaDato = null;
            metaDato = rsEx.getMetaData();

            for (int i = 1; i <= metaDato.getColumnCount(); i++) {
                if (metaDato.getColumnName(i).equalsIgnoreCase(dsCampo)) {
                    Inicio = i + 1;
                    break;
                }
            }

            while (rsEx.next()) {

                if (Pagina.equalsIgnoreCase("536") || Pagina.equalsIgnoreCase("538") || Pagina.equalsIgnoreCase("540")) {/*Reporte de Estatus Acumulado*/
                    if (!rsEx.isLast()) {
                        for (int i = Inicio; i < metaDato.getColumnCount(); i++) {
                            dataset.addValue(Double.parseDouble(rsEx.getString(i)), metaDato.getColumnName(i), rsEx.getString(dsCampo));
                        }
                    }
                } else if (Pagina.equalsIgnoreCase("689")) {
                    for (int i = Inicio; i <= metaDato.getColumnCount(); i++) {
                        dataset.addValue(Double.parseDouble(rsEx.getString(i)), metaDato.getColumnName(i), rsEx.getString(dsCampo));
                    }
                } else if (Pagina.equalsIgnoreCase("696")) {
                    for (int i = 3; i <= metaDato.getColumnCount(); i++) {
                        dataset.addValue(Double.parseDouble(rsEx.getString(i)) / 100, metaDato.getColumnName(i), rsEx.getString(dsCampo));
                    }
                } else if (Pagina.equalsIgnoreCase("714")) {
                    for (int i = Inicio; i <= metaDato.getColumnCount(); i++) {
                        dataset.addValue(Double.parseDouble(rsEx.getString(i)), metaDato.getColumnName(i), rsEx.getString(dsCampo));
                    }
                } else {    //if(Pagina.equalsIgnoreCase("537")) --> Reporte de Servicios Acumulados
                    for (int i = Inicio; i < metaDato.getColumnCount(); i++) {
                        dataset.addValue(Double.parseDouble(rsEx.getString(i)), metaDato.getColumnName(i), rsEx.getString(dsCampo));
                    }
                }
                /*
                 Categoria  --> Descripcion
                 Serie      --> Meses (Nombres de Columnas)
                 
                 Valor         Serie      Categoria
                 dataset.addValue(intDataSetl, StrDataSetX, "Reparacion");
                 */
            }
            StrDataSetX = null;
            String sentenciaSQLG = null;
            String dsCampo = null;
            String dsCampoCan = null;
        } catch (Exception e) {
            e.printStackTrace();
            this.destroy();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;

                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }

        JFreeChart chart = ChartFactory.createBarChart3D(GrTitulo, "", "", dataset, PlotOrientation.VERTICAL, true, true, false);
        CategoryPlot plot = chart.getCategoryPlot();
        CategoryAxis domainAxis = plot.getDomainAxis();
        domainAxis.setCategoryLabelPositions(CategoryLabelPositions.UP_45);

        return chart;
    }

    private JFreeChart createBarChartMultipl() {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        try {
            rsEx = UtileriasBDF.rsSQLNP(sentenciaSQLG);
            while (rsEx.next()) {
                if (!rsEx.getString(dsCampo).equalsIgnoreCase("MEDIA PROMEDIO")) {
                    StrDataSetX = rsEx.getString(dsCampo);
                    intDataSetl = rsEx.getDouble(dsCampoCan);
                    dataset.addValue(intDataSetl, StrDataSetX, "");
                }
            }
            StrDataSetX = null;
            String sentenciaSQLG = null;
            String dsCampo = null;
            String dsCampoCan = null;
        } catch (Exception e) {
            e.printStackTrace();
            this.destroy();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;

                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        JFreeChart chart = ChartFactory.createBarChart3D("", "", "Porcentaje", dataset, PlotOrientation.HORIZONTAL, true, true, false);
        return chart;
    }

    private JFreeChart createMLineChart() {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        JFreeChart chart = null;
        try {

            rsEx = UtileriasBDF.rsSQLNP(sentenciaSQLG);
            java.sql.ResultSetMetaData metaDato = null;
            metaDato = rsEx.getMetaData();

            while (rsEx.next()) {
                for (int i = 2; i <= metaDato.getColumnCount(); i++) {
                    dataset.addValue(Double.parseDouble(rsEx.getString(i)), rsEx.getString(dsCampo), metaDato.getColumnName(i));
                }
            }


            // create the chart...
            chart = ChartFactory.createLineChart(
                    GrTitulo, // chart title
                    XTitle, // domain axis label
                    YTitle, // range axis label
                    dataset, // data
                    PlotOrientation.VERTICAL, // orientation
                    true, // include legend
                    true, // tooltips
                    false // urls
                    );

            //chart.setBackgroundPaint(Color.white);

            CategoryPlot plot = chart.getCategoryPlot();
            plot.setBackgroundPaint(Color.lightGray);
            plot.setRangeGridlinePaint(Color.white);

            LineAndShapeRenderer renderer = (LineAndShapeRenderer) plot.getRenderer();
            renderer.setShapesVisible(true);

            CategoryAxis domainAxis = plot.getDomainAxis();
            domainAxis.setCategoryLabelPositions(CategoryLabelPositions.UP_45);

            String sentenciaSQLG = null;
            String dsCampo = null;
            String dsCampoCan = null;

        } catch (Exception e) {
            e.printStackTrace();
            this.destroy();
        } finally {
            /* try{                
             if (rsEx!=null) {
             rsEx.close();
             rsEx=null;
             }                
             } catch(Exception ee) {
             ee.printStackTrace();
             }   */
            return chart;
        }
    }

    private JFreeChart createLineChart() {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        try {
            rsEx = UtileriasBDF.rsSQLNP(sentenciaSQLG);
            while (rsEx.next()) {
                if (!rsEx.getString(dsCampo).equalsIgnoreCase("MEDIA PROMEDIO")) {
                    StrDataSetX = rsEx.getString(dsCampo);
                    intDataSetl = rsEx.getDouble(dsCampoCan);
                    dataset.addValue(intDataSetl, "", StrDataSetX);
                }
            }
            StrDataSetX = null;
            String sentenciaSQLG = null;
            String dsCampo = null;
            String dsCampoCan = null;
        } catch (Exception e) {
            e.printStackTrace();
            this.destroy();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;

                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        JFreeChart chart = ChartFactory.createLineChart("", "", "Porcentaje", dataset, PlotOrientation.VERTICAL, true, true, false);
        return chart;
    }

    private JFreeChart createBarChartR() {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        try {
            rsEx = UtileriasBDF.rsSQLNP(sentenciaSQLG);
            java.sql.ResultSetMetaData metaDato = null;
            metaDato = rsEx.getMetaData();
            while (rsEx.next()) {
                for (int i = 2; i <= metaDato.getColumnCount(); i++) {
                    dataset.addValue(rsEx.getDouble(metaDato.getColumnLabel(i)), metaDato.getColumnLabel(i), metaDato.getColumnLabel(i));
                }
            }
            String sentenciaSQLG = null;
        } catch (Exception e) {
            e.printStackTrace();
            this.destroy();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }

        JFreeChart chart = ChartFactory.createBarChart3D("", "", dsx, dataset, PlotOrientation.VERTICAL, true, true, false);
        String dsx = null;
        rsEx = null;
        return chart;
    }

    private JFreeChart crearChartM() {
        //DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        DefaultPieDataset dataset = new DefaultPieDataset();
        try {
            rsEx = UtileriasBDF.rsSQLNP(sentenciaSQLG);
            java.sql.ResultSetMetaData metaDato = null;
            metaDato = rsEx.getMetaData();
            while (rsEx.next()) {
                for (int i = 2; i <= metaDato.getColumnCount(); i++) {
                    dataset.setValue(metaDato.getColumnLabel(i), rsEx.getDouble(i));
                }
            }
            String sentenciaSQLG = null;
        } catch (Exception e) {
            e.printStackTrace();
            this.destroy();
        } finally {
            try {
                if (rsEx != null) {
                    rsEx.close();
                    rsEx = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        JFreeChart chart = ChartFactory.createPieChart3D("", dataset, true, true, true);
        final PiePlot3D plot = (PiePlot3D) chart.getPlot();
        plot.setStartAngle(290);
        plot.setDirection(Rotation.CLOCKWISE);
        plot.setForegroundAlpha(0.5f);
        plot.setNoDataMessage("Sin Imagen");
        return chart;
    }
}
