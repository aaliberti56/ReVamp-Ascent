package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import model.DAO.ClienteDAO;
import model.JavaBeans.*;
import java.sql.SQLException;

@WebServlet(name = "ModificaCredenzialiServlet", value = "/ModificaCredenzialiServlet")
public class ModificaCredenzialiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cliente utente = (Cliente) request.getSession().getAttribute("utenteLoggato");
        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = request.getParameter("username");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (username == null || oldPassword == null || newPassword == null || confirmPassword == null) {
            request.setAttribute("msg", "Tutti i campi sono obbligatori");
            request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
            return;
        }

        username = username.trim();
        oldPassword = oldPassword.trim();
        newPassword = newPassword.trim();
        confirmPassword = confirmPassword.trim();

        ClienteDAO clienteDAO = new ClienteDAO();

        try {
            Cliente autenticato = clienteDAO.checkLogin(utente.getNomeUtente(), oldPassword);
            if (autenticato == null) {
                request.setAttribute("msg", "La vecchia password non è corretta.");
                request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
                return;
            }

            String vecchioUsername = utente.getNomeUtente();

            // Verifica se username è cambiato e già esistente
            if (!vecchioUsername.equals(username)) {
                Cliente altro = clienteDAO.doRetrieveByUsername(username);
                if (altro != null) {
                    request.setAttribute("msg", "Username già in uso.");
                    request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
                    return;
                }
                utente.setNomeUtente(username);
            }

            boolean cambiaPassword = false;
            if (!newPassword.isEmpty()) {
                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("msg", "Le nuove password non corrispondono.");
                    request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
                    return;
                }
                utente.setPass(newPassword);  // nuova password in chiaro, verrà hashata nel DAO
                cambiaPassword = true;
            }

            clienteDAO.doUpdate(utente, vecchioUsername, cambiaPassword);
            request.getSession().setAttribute("utenteLoggato", utente);
            request.setAttribute("msg", "Credenziali modificate con successo.");
            request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("msg", "Errore durante l'aggiornamento dei dati.");
            request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
        }
    }
}



