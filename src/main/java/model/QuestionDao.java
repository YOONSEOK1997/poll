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


public class QuestionDao {

	private Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "wkqk1234");
	}

	// 질문 목록 조회 (페이징 처리)
	public ArrayList<QuestionDto> selectQuestionList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<QuestionDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = getConnection(); 

		// 페이징 쿼리
		String sql = "SELECT q.num, q.title, q.startdate, q.enddate, q.type ,t.total_count"
				+ " FROM question q"
				+ "  INNER JOIN (SELECT qnum ,SUM(COUNT) AS total_count"
				+ "			 	FROM item "
				+ "				GROUP BY qnum) t "
				+ "				ON q.num = t.qnum "
				+ "ORDER BY q.num ASC LIMIT ?, ?";

		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());

		rs = stmt.executeQuery();

		while (rs.next()) {
			QuestionDto question = new QuestionDto();
			question.setNum(rs.getInt("num"));
			question.setTitle(rs.getString("title"));
			question.setStartdate(rs.getString("startdate"));
			question.setEnddate(rs.getString("enddate"));
			question.setType(rs.getInt("type"));
			question.setTotalCount(rs.getInt("total_count")); 
			list.add(question);
		}
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();
		return list;
	}
	// 설문상세
	
	public QuestionDto selectQuestionByNum(int qnum) throws ClassNotFoundException, SQLException {
	    QuestionDto question = null;
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    conn = getConnection();

	    String sql = "SELECT q.num, q.title, q.startdate, q.enddate, q.type, t.total_count"
	               + " FROM question q"
	               + " INNER JOIN (SELECT qnum, SUM(count) AS total_count FROM item GROUP BY qnum) t"
	               + " ON q.num = t.qnum"
	               + " WHERE q.num = ?";
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, qnum);
	    rs = stmt.executeQuery();

	    if (rs.next()) {
	        question = new QuestionDto();
	        question.setNum(rs.getInt("num"));
	        question.setTitle(rs.getString("title"));
	        question.setStartdate(rs.getString("startdate"));
	        question.setEnddate(rs.getString("enddate"));
	        question.setType(rs.getInt("type"));
	        question.setTotalCount(rs.getInt("total_count"));
	    }

	    if (stmt != null) stmt.close();
	    if (conn != null) conn.close();

	    return question;
	}

	// 입력 후 자동으로 생성된 키값 반환
	public int insertQuestion(QuestionDto questionDto) throws ClassNotFoundException, SQLException {
		int pk = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = getConnection(); 

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
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();

		return pk;
	} 
	//종료날짜 수정 
	public void updateQuestionEndDate(QuestionDto questionDto) throws ClassNotFoundException, SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		conn = getConnection();  
		String sql = "UPDATE question SET enddate = ? WHERE num = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, questionDto.getEnddate());
		stmt.setInt(2, questionDto.getNum());  
		int result = stmt.executeUpdate();  
		System.out.println(result + "개 행이 업데이트되었습니다.");

		if (stmt != null) stmt.close();
		if (conn != null) conn.close();

	}
	
	public void updateQuestion(QuestionDto questionDto) throws ClassNotFoundException, SQLException {
	    Connection conn = getConnection();
	    String sql = "UPDATE question SET title = ?, startdate = ?, enddate = ?, type = ? WHERE num = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);

	    stmt.setString(1, questionDto.getTitle());
	    stmt.setString(2, questionDto.getStartdate());
	    stmt.setString(3, questionDto.getEnddate());
	    stmt.setInt(4, questionDto.getType());
	    stmt.setInt(5, questionDto.getNum());

	    stmt.executeUpdate();

	    if (stmt != null) stmt.close();
	    if (conn != null) conn.close();
	}

	// 삭제
	public void deleteQuestion(int num) throws ClassNotFoundException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = getConnection();
		String sql = "DELETE FROM question WHERE num = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		int result = stmt.executeUpdate();

		if (result > 0) {
			System.out.println("Question이 삭제되었습니다");
		} else {
			System.out.println("삭제된 Question이 없습니다");
		}

		if (stmt != null) stmt.close();
		if (conn != null) conn.close();
	}

	
}
