package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.ImageDto;
import dto.Paging;

public class ImageDao {
	private Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "wkqk1234");
	}

	public void insertImage(ImageDto img) throws ClassNotFoundException, SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;

		String sql = "insert into image(memo,filename) values(?,?)";
		conn = getConnection(); 
		stmt= conn.prepareStatement(sql); // 
		stmt.setString(1, img.getMemo());
		stmt.setString(2, img.getFileName());

		int result = stmt.executeUpdate();  

		if (result > 0) {
			System.out.println("이미지가 삭제되었습니다");
		} else {
			System.out.println("삭제된 이미지가 없습니다");
		}

		if (stmt != null) stmt.close();
		if (conn != null) conn.close();


		conn.close();		
	}

	@SuppressWarnings("null")
	public ArrayList<ImageDto> selectImageList(Paging p) throws ClassNotFoundException, SQLException{
		ArrayList<ImageDto> list = new ArrayList<ImageDto>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		conn = getConnection(); 

		String sql = "select * from image order by num desc limit ? , ?";

		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());

		rs = stmt.executeQuery();
		while (rs.next()) {
			ImageDto imageDto = new ImageDto();
			imageDto.setNum(rs.getInt("num"));
			imageDto.setMemo(rs.getString("memo"));
			imageDto.setFileName(rs.getString("fileName"));
			imageDto.setCreateDate(rs.getString("createDate"));
			list.add(imageDto);
		}


		return list;
	}
	public void deleteImage(int num) throws ClassNotFoundException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;

		conn = getConnection();

		String sql = "DELETE FROM image WHERE num = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);

		int result = stmt.executeUpdate();  

		if (result > 0) {
			System.out.println("이미지가 삭제되었습니다");
		} else {
			System.out.println("삭제된 이미지가 없습니다");
		}

		if (stmt != null) stmt.close();
		if (conn != null) conn.close();
	}
}
