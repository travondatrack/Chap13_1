package com.mycompany.chap13_1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/test")
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<html>");
        response.getWriter().println("<body>");
        response.getWriter().println("<h1>Servlet Test - SUCCESS!</h1>");
        response.getWriter().println("<p>Package: com.mycompany.chap13_1</p>");
        response.getWriter().println("<p>Servlet mapping working correctly!</p>");
        response.getWriter().println("<p><a href='/Chap13_1/index.jsp'>Go to Email Form</a></p>");
        response.getWriter().println("</body>");
        response.getWriter().println("</html>");
    }
}