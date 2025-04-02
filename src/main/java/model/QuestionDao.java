package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Paging;
import dto.QuestionDto;

// Table : question crud
public class QuestionDao {
	
	// 질문 목록 조회 (페이징 처리)
	public ArrayList<QuestionDto> selectQuestionList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<QuestionDto> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

	
			// MySQL 연결
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "wkqk1234");
			
			// 페이징 쿼리
			String sql = "SELECT num, title, startdate, enddate, type FROM question ORDER BY num DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, p.getBeginRow());  // 시작 행 번호
			stmt.setInt(2, p.getRowPerPage()); // 한 페이지에 보여줄 행 수
			
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				QuestionDto question = new QuestionDto();
				question.setNum(rs.getInt("num"));
				question.setTitle(rs.getString("title"));
				question.setStartdate(rs.getString("startdate"));
				question.setEnddate(rs.getString("enddate"));
				question.setType(rs.getInt("type"));
				list.add(question);
			}
		
		return list;
	}

	// 입력 후 자동으로 생성된 키값 반환
	public int insertQuestion(QuestionDto questionDto) throws ClassNotFoundException, SQLException {
		int pk = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

	
			// MySQL 연결
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "wkqk1234");

			// 데이터 삽입 쿼리
			String sql = "INSERT INTO question(title, startdate, enddate, type) VALUES(?, ?, ?, ?)";
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, questionDto.getTitle());
			stmt.setString(2, questionDto.getStartdate());
			stmt.setString(3, questionDto.getEnddate());
			stmt.setInt(4, questionDto.getType());

			int row = stmt.executeUpdate(); // insert

			// 자동 생성된 키값 가져오기
			rs = stmt.getGeneratedKeys();
			if (rs.next()) {
				pk = rs.getInt(1);
			}
		
		
		return pk;
	}
	
	public QuestionDto selectQuestionByNum(int num) throws SQLException {
	    QuestionDto question = null;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	  
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "wkqk1234");
	        String sql = "SELECT * FROM question WHERE num = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, num);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            question = new QuestionDto();
	            question.setNum(rs.getInt("num"));
	            question.setTitle(rs.getString("title"));
	           // question.setContent(rs.getContent("content"));
	            question.setStartdate(rs.getString("startdate"));
	            question.setEnddate(rs.getString("enddate"));
	            question.setType(rs.getInt("type"));
	        }
	 
	    return question;
	}

}
