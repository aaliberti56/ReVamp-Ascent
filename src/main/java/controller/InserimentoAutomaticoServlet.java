package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.DAO.ArticoloDAO;
import model.DAO.ImmagineArticoloDAO;
import model.JavaBeans.Articolo;
import model.JavaBeans.ImmagineArticolo;
import model.ConPool;

import java.io.*;
import java.net.URL;
import java.nio.file.*;
import java.sql.Connection;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet("/InserimentoAutomaticoServlet")
public class InserimentoAutomaticoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String itemsJson = request.getParameter("itemsJson");
        if (itemsJson == null || itemsJson.isEmpty()) {
            response.sendRedirect("aggiungiArticoloAI.jsp");
            return;
        }

        ArticoloDAO articoloDAO = new ArticoloDAO();
        ImmagineArticoloDAO immagineDAO = new ImmagineArticoloDAO();

        try (Connection con = ConPool.getConnection()) {

            // Regex minimale per parsare il JSON (NO Gson)
            Pattern pattern = Pattern.compile(
                    "\\{[^}]*?\"name\":\"(.*?)\"[^}]*?" +
                            "\"category\":\"(.*?)\"[^}]*?" +
                            "\"price\":(.*?)[,}]" +
                            "[^}]*?\"quantity\":(\\d+)[^}]*?" +
                            "\"image_url\":\"(.*?)\"[^}]*?\\}"
            );

            Matcher matcher = pattern.matcher(itemsJson);

            while (matcher.find()) {

                String nome = matcher.group(1);
                String categoria = matcher.group(2);
                double prezzo = Double.parseDouble(matcher.group(3));
                int quantita = Integer.parseInt(matcher.group(4));
                String flaskImageUrl = matcher.group(5);

                int codice = new Random().nextInt(1700) + 300;

                Articolo articolo = new Articolo(
                        codice,
                        nome,
                        "Inserito automaticamente tramite AI",
                        "N/A",
                        0.0,
                        prezzo,
                        0.0,
                        "N/A",
                        getIdCategoria(categoria)
                );

                articoloDAO.doSave(con, articolo);

                // ===============================
                // SALVATAGGIO IMMAGINE LOCALE
                // ===============================

                String realPath = getServletContext().getRealPath("/img/articoli/");
                Files.createDirectories(Paths.get(realPath));

                String fileName = UUID.randomUUID() + ".jpg";
                Path destination = Paths.get(realPath, fileName);

                try (InputStream in = new URL("http://127.0.0.1:5000" + flaskImageUrl).openStream()) {
                    Files.copy(in, destination, StandardCopyOption.REPLACE_EXISTING);
                }

                String dbPath = "img/articoli/" + fileName;

                ImmagineArticolo img = new ImmagineArticolo(
                        0,
                        codice,
                        dbPath,
                        true,
                        "Immagine principale"
                );

                immagineDAO.doSave(con, img);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Errore inserimento automatico", e);
        }

        response.sendRedirect("aggiungiArticoloAI.jsp?success=ai");
    }

    // ===============================
    // MAPPING CATEGORIA → ID
    // ===============================
    private int getIdCategoria(String categoria) {
        return switch (categoria.toLowerCase()) {
            case "bed" -> 1;
            case "chair" -> 2;
            case "sofa" -> 3;
            case "table" -> 4;
            default -> 1;
        };
    }
}