package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import dto.ItemDto;

// Table : item crud
public class ItemDao {
	public void insertItem(ItemDto itemdto) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "insert into item(qnum, inum, content) values(?,?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","wkqk1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, itemdto.getQnum());
		stmt.setInt(2, itemdto.getInum());
		stmt.setString(3, itemdto.getContent());
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("ItemDao.insertItem - 입력성공");
		} else {
			System.out.println("ItemDao.insertItem - 입력실패");
		}
		conn.close();
	}
}
