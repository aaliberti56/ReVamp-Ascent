package model.DAO;

import model.ConPool;
import model.JavaBeans.Ordine;
import java.sql.*;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;



public class OrdineDAO {

    public Ordine doRetrieveById(int id_ordine) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM ordine WHERE id_ordine = ?");
            ps.setInt(1, id_ordine);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                GregorianCalendar data = new GregorianCalendar();
                data.setTime(rs.getDate("data"));
                return new Ordine(
                        rs.getInt("id_ordine"),
                        rs.getInt("num_articoli"),
                        rs.getString("fattura"),
                        data,
                        rs.getDouble("importo_totale"),
                        rs.getTime("orario_ritiro"),
                        rs.getString("punto_ritiro"),
                        rs.getString("info_corriere"),
                        rs.getInt("id_indirizzo"),
                        rs.getString("nome_utente")
                );
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Ordine> doRetrieveAll() {
        List<Ordine> lista = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM ordine");
            while (rs.next()) {
                GregorianCalendar data = new GregorianCalendar();
                data.setTime(rs.getDate("data"));
                Ordine o = new Ordine(
                        rs.getInt("id_ordine"),
                        rs.getInt("num_articoli"),
                        rs.getString("fattura"),
                        data,
                        rs.getDouble("importo_totale"),
                        rs.getTime("orario_ritiro"),
                        rs.getString("punto_ritiro"),
                        rs.getString("info_corriere"),
                        rs.getInt("id_indirizzo"),
                        rs.getString("nome_utente")
                );
                lista.add(o);
            }
            return lista;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Ordine ordine) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO ordine (num_articoli, fattura, data, importo_totale, orario_ritiro, punto_ritiro, info_corriere, id_indirizzo, nome_utente) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setInt(1, ordine.getNum_articoli());
            ps.setString(2, ordine.getFattura());
            ps.setDate(3, new java.sql.Date(ordine.getData().getTimeInMillis()));
            ps.setDouble(4, ordine.getImporto_totale());
            ps.setTime(5, ordine.getOrario_ritiro());
            ps.setString(6, ordine.getPunto_ritiro());
            ps.setString(7, ordine.getInfo_corriere());
            ps.setInt(8, ordine.getId_indirizzo());
            ps.setString(9, ordine.getNome_utente());

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                ordine.setId_ordine(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean doDelete(int id_ordine) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM ordine WHERE id_ordine=?");
            ps.setInt(1, id_ordine);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Ordine> doRetrieveByDate(GregorianCalendar data1, GregorianCalendar data2) {
        List<Ordine> lista = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM ordine WHERE data BETWEEN ? AND ? ORDER BY data DESC"
            );
            ps.setDate(1, new java.sql.Date(data1.getTimeInMillis()));
            ps.setDate(2, new java.sql.Date(data2.getTimeInMillis()));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                GregorianCalendar data = new GregorianCalendar();
                data.setTime(rs.getDate("data"));

                Ordine o = new Ordine(
                        rs.getInt("id_ordine"),
                        rs.getInt("num_articoli"),
                        rs.getString("fattura"),
                        data,
                        rs.getDouble("importo_totale"),
                        rs.getTime("orario_ritiro"),
                        rs.getString("punto_ritiro"),
                        rs.getString("info_corriere"),
                        rs.getInt("id_indirizzo"),
                        rs.getString("nome_utente")
                );
                lista.add(o);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lista;
    }


}