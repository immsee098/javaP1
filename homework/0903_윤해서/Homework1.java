package com.java0904;

import java.util.Scanner;

class NameCard {
	String Name;
	String phoneNum;
	String address;
	String rank;
	
	NameCard(String p_Name, String p_phoneNum, String p_address, String p_rank){
		Name = p_Name;
		phoneNum = p_phoneNum;
		address = p_address;
		rank = p_rank;
	}
	
	NameCard() {
		
	}
	
	public void showInfo() {
		System.out.println(Name);
		System.out.println(phoneNum);
		System.out.println(address);
		System.out.println(rank);
	}
}

public class Homework1 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.println("이름 전화번호 회사주소 직급 입력");
		String name = sc.nextLine();
		String phone = sc.nextLine();
		String address = sc.nextLine();
		String rank = sc.nextLine();
		System.out.println("================");
		NameCard name1 = new NameCard(name, phone, address, rank);
		name1.showInfo();

	}

}
