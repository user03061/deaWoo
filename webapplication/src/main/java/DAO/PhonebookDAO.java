package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PhonebookDAO {

    public int insert(PhonebookVO pvo) {
        String sql = "INSERT INTO phonebook (id, name, hp, memo) VALUES (?, ?, ?, ?)";
        return executeUpdate(sql, pvo.getId(), pvo.getName(), pvo.getHp(), pvo.getMemo());
        
    }

    
    public List<PhonebookVO> selectAll() {
        List<PhonebookVO> list = new ArrayList<>();
        String sql = "SELECT * FROM phonebook";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                PhonebookVO pvo = new PhonebookVO();
                pvo.setId(rs.getInt("id"));
                pvo.setName(rs.getString("name"));
                pvo.setHp(rs.getString("hp"));
                pvo.setMemo(rs.getString("memo"));
                list.add(pvo);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }


    public List<PhonebookVO> search(String keyword) {
        List<PhonebookVO> list = new ArrayList<>();
        String sql = "SELECT * FROM phonebook WHERE name LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "%" + keyword + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    PhonebookVO pvo = new PhonebookVO();
                    pvo.setId(rs.getInt("id"));
                    pvo.setName(rs.getString("name"));
                    pvo.setHp(rs.getString("hp"));
                    pvo.setMemo(rs.getString("memo"));
                    list.add(pvo);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("DB Not Connected " + e.getMessage());
        }
        return list;
    }

    public PhonebookVO selectById(int id) {
        PhonebookVO pvo = null;
        String sql = "SELECT * FROM phonebook WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    pvo = new PhonebookVO();
                    pvo.setId(rs.getInt("id"));
                    pvo.setName(rs.getString("name"));
                    pvo.setHp(rs.getString("hp"));
                    pvo.setMemo(rs.getString("memo"));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("DB Not Connection " + e.getMessage());
        }
        return pvo;
    }

    public int update(PhonebookVO pvo) {
        String sql = "UPDATE phonebook SET name = ?, hp = ?, memo = ? WHERE id = ?";
        return executeUpdate(sql, pvo.getId(), pvo.getName(), pvo.getHp(), pvo.getMemo());
    }

    public int delete(int id) {
        String sql = "DELETE FROM phonebook WHERE id = ?";
        return executeUpdate(sql, id);
    }

    private int executeUpdate(String sql, Object... params) {
        int result = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            for (int i = 0; i < params.length; i++) {
                if (params[i] instanceof Integer) {
                    pstmt.setInt(i + 1, (Integer) params[i]);
                } else if (params[i] instanceof String) {
                    pstmt.setString(i + 1, (String) params[i]);
                } else if (params[i] instanceof Double) {
                    pstmt.setDouble(i + 1, (Double) params[i]);
                } // 필요한 경우 추가적인 타입 처리
            }

            result = pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("DB Connected Error: " + e.getMessage());
        }
        return result;
    }
}

