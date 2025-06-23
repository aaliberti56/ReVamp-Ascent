package controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import model.DAO.*;
import model.JavaBeans.*;
import java.sql.*;

@WebServlet(name = "ModificaCredenzialiServlet", value = "/ModificaCredenzialiServlet")
public class ModificaCredenzialiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cliente utente=(Cliente) request.getSession().getAttribute("utenteLoggato");
        if(utente==null){
            response.sendRedirect("login.jsp");
            return;
        }

        String email=request.getParameter("email").trim();
        String oldPassword = request.getParameter("oldPassword").trim();
        String newPassword = request.getParameter("newPassword").trim();
        String confirmPassword = request.getParameter("confirmPassword").trim();

        if(!newPassword.equals(confirmPassword)){
            request.setAttribute("msg","le nuove password non corrispondono");
            request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
            return;
        }

        if(!utente.getPass().equals(oldPassword)){
            request.setAttribute("msg","la vecchia password non è corretta");
            request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
            return;
        }

        utente.setEmail(email);
        utente.setPass(newPassword);

        ClienteDAO clienteDAO=new ClienteDAO();
        try{
            clienteDAO.doUpdate(utente);
            request.getSession().setAttribute("utente",utente);
            request.setAttribute("msg","Credenziali modificate con successo");
        } catch (SQLException e){
            e.printStackTrace();
            request.setAttribute("msg", "Errore durante l'aggiornamento dati.");
        }
        request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
    }
}
