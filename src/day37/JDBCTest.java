package com.jdbc.day1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class JDBCTest {

	public static void main(String[] args) {
		//INSERT
		Scanner sc = new Scanner(System.in);
		System.out.println("이름, 전번 입력!");
		String name = sc.nextLine();
		String tel = sc.nextLine();
		
		Connection con = null;
		PreparedStatement ps = null;
		try {
			//1.데이터베이스와 연결하는 드라이버 클래스 찾기(드라이버 로딩)
			Class.forName("oracle.jdbc.driver.OracleDriver"); //얘때매 클래스 익셉션 필요
			//드라이버 로딩
			System.out.println("드라이버 로딩 성공");
			//2.데이터베이스 서버와 연결하기 위한 Connection 객체 생성
			String url = "jdbc:oracle:thin:@DESKTOP-IA9SFNU:1521:XE";
			String user ="testuser", pwd="testuser123";
			con = DriverManager.getConnection(url, user,pwd);
			System.out.println("db연결 성공");
			//3. sql 문장을 처리할 PreparesStatement 객체 생성
			String sql = "insert into person(no, name, tel)" + 
					" values(person_seq.nextval, ?, ?)";
			ps = con.prepareStatement(sql);
			
			//in parameter setting
			ps.setString(1, name);
			ps.setString(2, tel);
			
			//4. 실행 
			int cnt = ps.executeUpdate(); //처리된 행의 갯수 리턴
			System.out.println(cnt+"개 행이 입력됨!");
			
			
		} catch(ClassNotFoundException e) {
			System.out.println("class not found!");
			e.printStackTrace();
		} catch(SQLException e) {
			System.out.println("sql예외!");
			e.printStackTrace();
		} finally {
			//5. 자원반납 접속종료
			try {
				if(ps!=null) ps.close(); //이거 null이고 if문 없음 에러남
				if(con!=null) con.close();
				//생성한 것과 반대로 close
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
