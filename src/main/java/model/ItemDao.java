package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.ItemDto;

public class ItemDao {

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "wkqk1234");
    }

    public int selectItemCountByQnum(int qnum) throws ClassNotFoundException, SQLException {
        int count = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        conn = getConnection(); 

        String sql = "select sum(count) cnt from item group by qnum having qnum = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, qnum);
        rs = stmt.executeQuery();

        if (rs.next()) {
            count = rs.getInt("cnt");
        }

        return count;
    }

    public void updateItemCountPlus(int qnum, int inum) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        conn = getConnection();
        
        String sql = "update item set count = count+1 where qnum = ? and inum = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, qnum);
        stmt.setInt(2, inum);

        int row = stmt.executeUpdate();

        if (row == 1) {
            System.out.println("ItemDao.updateItemCountPlus#입력 성공");
        } else {
            System.out.println("ItemDao.updateItemCountPlus#입력 실패");
        }

        conn.close();
    }

    public ArrayList<ItemDto> selectItemListbyQnum(int qnum) throws ClassNotFoundException, SQLException {
        ArrayList<ItemDto> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        conn = getConnection(); 
        
        String sql = "select * from item where qnum = ? order by inum asc";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, qnum);
        rs = stmt.executeQuery();

        while (rs.next()) {
            ItemDto i = new ItemDto();
            i.setQnum(qnum);
            i.setInum(rs.getInt("inum"));
            i.setContent(rs.getString("content"));
            i.setCount(rs.getInt("count"));
            list.add(i);
        }

        return list;
    }

    public ArrayList<ItemDto> selectItem(int qnum) throws ClassNotFoundException, SQLException {
        ArrayList<ItemDto> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        conn = getConnection();
        
        String sql = "select content from item where qnum = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, qnum);
        rs = stmt.executeQuery();

        while (rs.next()) {
            ItemDto itemDto = new ItemDto();
            itemDto.setContent(rs.getString("content"));
            list.add(itemDto);
        }

        conn.close();
        return list;
    }

    public void insertItem(ItemDto itemdto) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        conn = getConnection();

        String sql = "insert into item(qnum, inum, content) values(?,?,?)";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, itemdto.getQnum());
        stmt.setInt(2, itemdto.getInum());
        stmt.setString(3, itemdto.getContent());

        int row = stmt.executeUpdate();

        if (row == 1) {
            System.out.println("ItemDao.insertItem - 입력 성공");
        } else {
            System.out.println("ItemDao.insertItem - 입력 실패");
        }

        conn.close();
    }

    public void deleteItem(int num) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        conn = getConnection();
        
        String sql = "DELETE FROM item WHERE qnum = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, num);

        int result = stmt.executeUpdate();  

        if (result > 0) {
            System.out.println("item이 삭제되었습니다");
        } else {
            System.out.println("삭제된 item이 없습니다");
        }

        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
}
