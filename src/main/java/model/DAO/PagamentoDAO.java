package model.DAO;

import model.JavaBeans.*;
import model.ConPool;

import java.sql.*;
import java.util.GregorianCalendar;

public class PagamentoDAO {

    public boolean doSave(Pagamento p) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO pagamento (id_pagamento, data_pagamento, importo, metodo_pagamento, stato_pagamento, id_ordine) VALUES (?, ?, ?, ?, ?, ?)"
            );
            ps.setInt(1, p.getId_pagamento());
            ps.setDate(2, new Date(p.getData_pagamento().getTimeInMillis()));
            ps.setDouble(3, p.getImporto());
            ps.setString(4, p.getMetodo_pagamento());
            ps.setString(5, p.getStato_pagamento());
            ps.setInt(6, p.getId_ordine());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Pagamento doRetrieveByOrdine(int idOrdine) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM pagamento WHERE id_ordine = ?"
            );
            ps.setInt(1, idOrdine);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                GregorianCalendar data = new GregorianCalendar();
                data.setTime(rs.getDate("data_pagamento"));
                return new Pagamento(
                        rs.getInt("id_pagamento"),
                        data,
                        rs.getDouble("importo"),
                        rs.getString("metodo_pagamento"),
                        rs.getString("stato_pagamento"),
                        rs.getInt("id_ordine")
                );
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean doUpdateStato(int idPagamento, String nuovoStato) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE pagamento SET stato_pagamento = ? WHERE id_pagamento = ?"
            );
            ps.setString(1, nuovoStato);
            ps.setInt(2, idPagamento);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean doDelete(int idPagamento) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM pagamento WHERE id_pagamento = ?"
            );
            ps.setInt(1, idPagamento);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
