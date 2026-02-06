package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.*;
import java.sql.Connection;
import java.util.UUID;
import org.json.JSONObject;


import model.DAO.*;
import model.JavaBeans.*;
import model.ConPool;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 2 * 1024 * 1024,
        maxRequestSize = 3 * 1024 * 1024
)
@WebServlet(name = "AggiungiArticoloServlet", value = "/AggiungiArticoloServlet")
public class AggiungiArticoloServlet extends HttpServlet {

    private static final long MAX_FILE_SIZE = 2L * 1024 * 1024;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // ===== PARAMETRI =====
            int codice = Integer.parseInt(request.getParameter("codice"));
            String nome = sanitize(request.getParameter("nome"));
            String descrizione = sanitize(request.getParameter("descrizione"));
            String colore = sanitize(request.getParameter("colore"));
            String dimensione = sanitize(request.getParameter("dimensione"));

            double prezzo = Double.parseDouble(request.getParameter("prezzo"));
            double peso = parseDoubleOrZero(request.getParameter("peso"));
            double sconto = parseSconto(request.getParameter("sconto"));

            // ===== VALIDAZIONE =====
            if (codice <= 0 || prezzo <= 0 || peso < 0 || sconto < 0 || sconto >= 1)
                throw new Exception("Dati numerici non validi");

            ArticoloDAO articoloDAO = new ArticoloDAO();
            if (articoloDAO.doRetrieveById(codice) != null)
                throw new Exception("Articolo già esistente");

            // ===== UPLOAD IMMAGINE =====
            Part imgPart = request.getPart("immagine");
            if (imgPart == null || imgPart.getSize() == 0 || imgPart.getSize() > MAX_FILE_SIZE)
                throw new Exception("Immagine non valida");

            if (!"image/jpeg".equals(imgPart.getContentType()))
                throw new Exception("Solo JPG consentiti");

            if (!isJpegMagic(imgPart))
                throw new Exception("File non JPG valido");

            // ===== SALVATAGGIO FILE =====
            String dirAbs = getServletContext().getRealPath("/img/articoli/" + codice);
            File dir = new File(dirAbs);
            if (!dir.exists()) dir.mkdirs();

            String fileName = UUID.randomUUID() + ".jpg";
            Path fileAbs = Paths.get(dirAbs, fileName);

            try (InputStream in = imgPart.getInputStream()) {
                Files.copy(in, fileAbs, StandardCopyOption.REPLACE_EXISTING);
            }

            // ===== CHIAMATA AI =====
            String categoriaAI = chiamaFlask(fileAbs.toFile());
            int idCategoria = mappaCategoriaItaliana(categoriaAI);

            // ===== SALVATAGGIO DB =====
            Articolo articolo = new Articolo(
                    codice, nome, descrizione, colore,
                    sconto, prezzo, peso, dimensione, idCategoria
            );

            ImmagineArticolo img = new ImmagineArticolo();
            img.setCodice_articolo(codice);
            img.setUrl("img/articoli/" + codice + "/" + fileName);
            img.setIs_principale(true);
            img.setDescrizione("Immagine principale");

            try (Connection con = ConPool.getConnection()) {
                con.setAutoCommit(false);
                articoloDAO.doSave(con, articolo);
                new ImmagineArticoloDAO().doSave(con, img);
                con.commit();
            }

            response.sendRedirect("confermaInserimento.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            lanciaErrore(request, response, e.getMessage());
        }
    }

    // ================= AI =================

    private String chiamaFlask(File imageFile) throws Exception {

        String boundary = "----WebKitFormBoundary" + System.currentTimeMillis();
        URL url = new URL("http://127.0.0.1:5000/predict");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
        conn.setRequestProperty("Accept", "application/json");

        try (OutputStream out = conn.getOutputStream();
             DataOutputStream writer = new DataOutputStream(out)) {

            writer.writeBytes("--" + boundary + "\r\n");
            writer.writeBytes("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n");
            writer.writeBytes("Content-Type: image/jpeg\r\n\r\n");

            Files.copy(imageFile.toPath(), writer);
            writer.writeBytes("\r\n--" + boundary + "--\r\n");
            writer.flush();
        }

        int status = conn.getResponseCode();
        InputStream is = (status == 200)
                ? conn.getInputStream()
                : conn.getErrorStream();

        BufferedReader br = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();
        String line;

        while ((line = br.readLine()) != null) {
            sb.append(line);
        }

        String json = sb.toString().trim();
        System.out.println("FLASK RESPONSE: " + json);


        JSONObject obj = new JSONObject(json);

        if (status != 200) {
            throw new RuntimeException("Errore AI: " + obj.getString("error"));
        }

        return obj.getString("category");
    }



    private int mappaCategoriaItaliana(String ai) {
        return switch (ai) {
            case "bed" -> 1;    // Letti
            case "chair" -> 2;  // Sedie
            case "sofa" -> 3;   // Divani
            case "table" -> 4;  // Tavoli
            default -> 2;
        };
    }

    // ================= UTILS =================

    private boolean isJpegMagic(Part part) throws IOException {
        try (InputStream in = part.getInputStream()) {
            return in.read() == 0xFF && in.read() == 0xD8;
        }
    }

    private String sanitize(String s) {
        return s == null ? null : s.replace("<", "&lt;").replace(">", "&gt;");
    }

    private double parseDoubleOrZero(String s) {
        return (s == null || s.isEmpty()) ? 0.0 : Double.parseDouble(s);
    }

    private double parseSconto(String s) {
        if (s == null || s.isEmpty()) return 0.0;
        double v = Double.parseDouble(s);
        return v > 1 ? v / 100 : v;
    }

    private void lanciaErrore(HttpServletRequest req, HttpServletResponse res, String msg)
            throws ServletException, IOException {
        req.setAttribute("errore", msg);
        req.getRequestDispatcher("erroreInserimento.jsp").forward(req, res);
    }
}

