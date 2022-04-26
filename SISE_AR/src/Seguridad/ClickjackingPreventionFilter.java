/**
 *
 * @author dmontaut
 */
package Seguridad;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class ClickjackingPreventionFilter
  implements Filter
{
  private String mode = "DENY";
  
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
    throws IOException, ServletException
  {
    HttpServletResponse res = (HttpServletResponse)response;
    res.addHeader("X-FRAME-OPTIONS", this.mode);
    chain.doFilter(request, response);
  }
  
  public void destroy() {}
  
  public void init(FilterConfig filterConfig)
  {
    String configMode = filterConfig.getInitParameter("mode");
    if (configMode != null) {
      this.mode = configMode;
    }
  }
}