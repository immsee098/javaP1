
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class StatementTest {

	public static void main(String[] args) {
		//statement 이용 - insert
		Scanner sc = new Scanner(System.in);
		System.out.println("이름, 전번 입력");
		String name = sc.nextLine();
		String tel = sc.nextLine();
		
		Connection con = null;
		Statement st = null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버 로딩 성공");
			
			String url = "jdbc:oracle:thin:@DESKTOP-IA9SFNU:1521:XE";
			String user ="testuser", pwd="testuser123";
			con = DriverManager.getConnection(url, user,pwd);
			System.out.println("db연결 성공");
			
			//3. sql문장을 처리할 Statement 객체 생성
			st = con.createStatement(); //메모리 캐시 안씀 매번 분석
			
			//4. 실행
			String sql="insert into person(no, name, tel)"+
						" values(person_seq.nextval, '"+name+"', '"+tel+"')";
			int cnt = st.executeUpdate(sql);
			System.out.println(cnt+"개의 행 입력");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(st!=null) st.close(); //이거 null이고 if문 없음 에러남
				if(con!=null) con.close();
				//생성한 것과 반대로 close
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
	}

}
