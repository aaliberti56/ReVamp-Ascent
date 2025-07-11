package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.JavaBeans.*;
import model.DAO.*;

import java.io.IOException;

@WebServlet(name = "Registrazione", value = "/RegistrazioneUtenteServlet")
public class RegistrazioneUtenteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response); // delega al POST
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String username = request.getParameter("username");
        String sesso = request.getParameter("sesso");

        // Default values
        int eta = 0;
        String telefono = "N/D";

        ClienteDAO dao = new ClienteDAO();

        try {
            // Controlla se username già esistente
            if (dao.doRetrieveByUsername(username) != null) {
                response.sendRedirect("registrazione.jsp?errore=Username già in uso");
                return;
            }

            // Crea Cliente (la password sarà hashata nel metodo dao.doSave)
            Cliente nuovoCliente = new Cliente(username, password, nome, cognome, email, sesso, eta, telefono);
            dao.doSave(nuovoCliente);

            // Registrazione avvenuta con successo
            response.sendRedirect("login.jsp?success=reg");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registrazione.jsp?errore=Registrazione fallita");
        }
    }
}

