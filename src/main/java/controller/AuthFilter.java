package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
      
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();

        boolean isLoginPage = uri.endsWith("login.jsp") || uri.endsWith("login");
        boolean isRegisterPage = uri.endsWith("register.jsp") || uri.endsWith("register");
        boolean isHome = uri.endsWith("home.jsp") || uri.equals(req.getContextPath() + "/");
        boolean isStaticResource = uri.contains("/css/") || uri.contains("/images/") || uri.contains("/js/");
        boolean isRecuperoPassword = uri.contains("recupera-password") || uri.endsWith("modifica-password");

        boolean loggedIn = (session != null && session.getAttribute("utente") != null);

        if (loggedIn || isLoginPage || isRegisterPage || isHome || isStaticResource || isRecuperoPassword) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/views/login.jsp");
        }
    }

    @Override
    public void destroy() {
    }
}