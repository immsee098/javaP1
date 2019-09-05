package com.day12;

import java.util.Scanner;

class PhoneInfo{
	private String name;
	private String num;
	private String birth;
	
	PhoneInfo(String name, String num, String birth){
		this.name = name;
		this.num = num;
		this.birth = birth;
	}
	
	PhoneInfo(String name, String num){
		this.name = name;
		this.num = num;
	}

	public void getname(String p_name) {
		name = p_name;
	}
	
	public String setname() {
		return name;
	}
	
	public void gettime(String p_num) {
		num = p_num;
	}
	
	public String setnum() {
		return num;
	}
	public void getbirth(String p_birth) {
		birth = p_birth;
	}
	
	public String setbirth() {
		return birth;
	}
	
}


public class PhoneInfoTest {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		
		while(true) {
			System.out.println("선택하세요...");
			System.out.println("1.데이터 입력");
			System.out.println("2. 프로그램 종료");
			
			System.out.print("\n선택 : ");
			int select = sc.nextInt();
			
			if (select==2) {
				System.out.println("프로그램을 종료합니다");
				break;
			}
			sc.nextLine();
			
			System.out.print("이름을 입력 :");
			String name = sc.nextLine();
			
			System.out.print("폰번호를 입력 : ");
			String phone = sc.nextLine();
			
			System.out.print("생년월일 입력(선택) : ");
			String birth = sc.nextLine().trim();
			
			System.out.println("========입력된 정보 출력========");
			
			if(birth.equals("\n")||birth.equals("")||birth.equals(null)) {
				PhoneInfo p1 = new PhoneInfo(name, phone);
				System.out.println("name: "+p1.setname());
				System.out.println("phone: "+p1.setnum());
				
			} else {
				PhoneInfo p1 = new PhoneInfo(name, phone, birth);
				System.out.println("name: "+p1.setname());
				System.out.println("phone: "+p1.setnum());
				System.out.println("birth: "+p1.setbirth());
			}
			
		}

		
		
		
		

	}

}
