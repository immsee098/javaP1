package com.java0905;

import java.util.Scanner;

class rspGame{
	private String result;
	private int user;
	private int com;
	
	rspGame(int user, int com){
		this.user = user;
		this.com = com;
	}
	
	
	public void getuser(int p_user) {
		user = p_user;
	}
	
	public int setuser() {
		return user;
	}
	
	public void getcom(int p_com) {
		com = p_com;
	}
	
	public int setcom() {
		return com;
	}
	
	String verify() {
		int b = (user-com+3)%3;
		
		if (b==1) {
			result = "이김";
		} else if(b==2) {
			result="짐";
		} else if(b==0) {
			result="비김";
		} 
		return result;
	}
}

public class homework1 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int user = 0;
		System.out.println("가위(0), 바위(1), 보(2), Q(quit)");
		String start = sc.nextLine();
		
		if(start.equals("Q") || start.equals("q")) {
			System.out.println("끝");
		} else if (start.equals("0")) {
			System.out.println("사용자 = 가위");	
			user = 0;		
		} else if(start.equals("1")) {
			System.out.println("사용자 = 바위");
			user = 1;
		}else if(start.equals("2")) {
			System.out.println
			("사용자 = 보");
			user =2;
		} 
		
		int computer = (int)(Math.random()*3);
		if (computer==0) {
			System.out.println("컴퓨터 = 가위");		
		} else if(computer==1) {
			System.out.println("컴퓨터 = 바위");
		}else if(computer==2) {
			System.out.println("컴퓨터 = 보");
		}
		
		rspGame r1 = new rspGame(user, computer);
		System.out.println(r1.verify());

	}

}
