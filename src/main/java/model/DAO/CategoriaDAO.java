package model.DAO;

import model.ConPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import model.JavaBeans.*;
import java.sql.*;
import java.util.*;

public class CategoriaDAO {
    public Categoria doRetrieveById(int id_categoria){
        try(Connection con=ConPool.getConnection()){
            PreparedStatement ps=con.prepareStatement("select * from categoria where id_categoria=?");
            ps.setInt(1,id_categoria);
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                return new Categoria(
                        rs.getInt("id_categoria"),
                        rs.getString("tipologia"),
                        rs.getInt("codice")
                );
            }
            return null;
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
}

public List<Categoria> doRetrieveAll(){
    List<Categoria> categorie=new ArrayList<>();
    try(Connection con=ConPool.getConnection()){
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery("select * from categoria");
        while(rs.next()){
            Categoria c = new Categoria(
                    rs.getInt("id_categoria"),
                    rs.getString("tipologia"),
                    rs.getInt("codice")
            );
            categorie.add(c);
        }
        return categorie;
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
}

public void doSave(Categoria categoria){
    try(Connection con=ConPool.getConnection()){
        PreparedStatement ps=con.prepareStatement("INSERT INTO categoria (tipologia, codice) VALUES (?, ?)",
                Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, categoria.getTipologia());
        ps.setInt(2, categoria.getCodice());

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            categoria.setId_categoria(rs.getInt(1));
        }
    }catch (SQLException e) {
        throw new RuntimeException(e);
    }
}


public boolean doDelete(int id_categoria){
    try(Connection con=ConPool.getConnection()){
        PreparedStatement ps=con.prepareStatement("DELETE FROM categoria WHERE id_categoria=?");
        ps.setInt(1,id_categoria);
        return ps.executeUpdate()>0;
    }catch (SQLException e) {
        throw new RuntimeException(e);
    }
}

public Categoria doRetrieveByCodice(int codice) {
    try (Connection con = ConPool.getConnection()) {
        PreparedStatement ps = con.prepareStatement("SELECT * FROM categoria WHERE codice = ?");
        ps.setInt(1, codice);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new Categoria(
                    rs.getInt("id_categoria"),
                    rs.getString("tipologia"),
                    rs.getInt("codice")
            );
        }
        return null;
    } catch (SQLException e) {
        throw new RuntimeException(e);
        }
    }
}
