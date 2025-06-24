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
            request.setAttribute("msg", "Tutti i campi sono obbligatori.");
            request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
            return;
        }

        username = username.trim();
        oldPassword = oldPassword.trim();
        newPassword = newPassword.trim();
        confirmPassword = confirmPassword.trim();

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("msg", "Le nuove password non corrispondono.");
            request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
            return;
        }

        if (!utente.getPass().equals(oldPassword)) {
            request.setAttribute("msg", "La vecchia password non è corretta.");
            request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
            return;
        }

        ClienteDAO clienteDAO = new ClienteDAO();

        try {
            String vecchioUsername = utente.getNomeUtente();

            // Se cambia username, controllo disponibilità
            if (!vecchioUsername.equals(username)) {
                Cliente altroUsername = clienteDAO.doRetrieveByUsername(username);
                if (altroUsername != null) {
                    request.setAttribute("msg", "Username già in uso.");
                    request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
                    return;
                }
            }

            // Aggiorna dati utente
            utente.setNomeUtente(username);
            utente.setPass(newPassword);
            // Se vuoi aggiornare anche altri campi, aggiungili qui (es. utente.setEmail(...))

            // Aggiorna nel DB passando il vecchio username
            clienteDAO.doUpdate(utente, vecchioUsername);

            // Aggiorna sessione con dati modificati
            request.getSession().setAttribute("utenteLoggato", utente);

            request.setAttribute("msg", "Credenziali modificate con successo.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("msg", "Errore durante l'aggiornamento dati.");
        }

        request.getRequestDispatcher("modificaCredenziali.jsp").forward(request, response);
    }
}

