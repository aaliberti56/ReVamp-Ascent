package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.JavaBeans.*;
import model.DAO.*;
import java.sql.*;
import java.io.IOException;

import java.io.IOException;

@WebServlet(name = "AdminLogin", value = "/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        System.out.println("[DEBUG] Username ricevuto: " + username);
        System.out.println("[DEBUG] Password ricevuta (in chiaro): " + password);

        AdminDAO dao = new AdminDAO();
        Admin admin = null;

        try {
            admin = dao.doLogin(username, password);
            if(admin != null) {
                System.out.println("[DEBUG] Login riuscito per: " + username);
            } else {
                System.out.println("[DEBUG] Login FALLITO per: " + username);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("[DEBUG] Errore SQL durante login");
        }

        if(admin != null){
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            response.sendRedirect("admin.jsp");
        }
        else{
            response.sendRedirect("loginAdmin.jsp?errore=true");
        }
    }

}