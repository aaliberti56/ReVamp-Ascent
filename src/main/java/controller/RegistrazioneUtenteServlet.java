package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.JavaBeans.*;
import model.DAO.*;

import java.io.IOException;

import java.io.IOException;

@WebServlet(name = "Registrazione", value = "/RegistrazioneUtenteServlet")
public class RegistrazioneUtenteServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String nome=request.getParameter("nome");
        String cognome=request.getParameter("cognome");
        String email=request.getParameter("email");
        String password=request.getParameter("password");
        String username=request.getParameter("username");

        double saldo = 0.0;
        String sesso = request.getParameter("sesso");
        int eta = 0;
        String telefono = "N/D";
        ClienteDAO dao = new ClienteDAO();
        try{
            if(dao.doRetrieveByUsername(username)!=null){
                response.sendRedirect("registrazione.jsp?ar=true");
                return;
            }
            Cliente nuovoCliente = new Cliente(username, password, nome, cognome, saldo, email, sesso, eta, telefono);
            dao.doSave(nuovoCliente);

            response.sendRedirect("login.jsp?success=reg");
            System.out.println("Sono entrato nella servlet di registrazione");

        }catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registrazione.jsp?ar=errore");
        }

    }
}