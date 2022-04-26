/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilerias;

import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jesmoreno
 */
public class ClickjackFilter implements javax.servlet.Filter 
{

    private String mode = "DENY";

   
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException,
                ServletException {
        HttpServletResponse response = (HttpServletResponse) resp;
        response.addHeader("X-Frame-Options", mode);    
        chain.doFilter(req, resp);
    } 
    public void destroy() {
    }

    public void init(FilterConfig filterConfig) {
        String configMode = filterConfig.getInitParameter("mode");
        if ( configMode != null ) {
            mode = configMode;
        }
    }
}