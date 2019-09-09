package com.java0908;

import java.util.Scanner;

class PhoneInfo{
	private String name;
	private String phoneNumber;
	private String birth;
	
	public PhoneInfo(){	
	}

	public PhoneInfo(String name, String phoneNumber, String birth){
		this.name=name;
		this.phoneNumber=phoneNumber;
		this.birth=birth;
	}

	public PhoneInfo(String name, String phoneNumber){
		this.name=name;
		this.phoneNumber=phoneNumber;
	}
	
	public String getName() {
		return name;
	}

	public void showPhoneInfo()	{
		System.out.println("name: "+name);
		System.out.println("phone: "+phoneNumber);

		if(birth!=null && !birth.isEmpty())
			System.out.println("birth: "+birth);
		
		System.out.println();
	}
}

class PhoneNum1
{
	//static Scanner sc=new Scanner(System.in);
	
	public static void showMenu(){
		System.out.println("1. 데이터 입력(저장)");
		System.out.println("2. 전체 데이터 조회");
		System.out.println("3. 데이터 검색");
		System.out.println("4. 테이터 삭제");
		System.out.println("5. 프로그램 종류");
	}
	
	public static PhoneInfo inputData(){
		Scanner sc=new Scanner(System.in);

		System.out.print("이름: ");
		String name=sc.nextLine();
		System.out.print("전화번호: ");
		String phone=sc.nextLine();
		System.out.print("생년월일: ");
		String birth=sc.nextLine();
		
		PhoneInfo info=new PhoneInfo(name, phone, birth);
		return info;
	}
	
	public static void main(String[] args){
		Scanner sc=new Scanner(System.in);
		int choice=0;
		PhoneInfo[] info = new PhoneInfo[100];
		
		while(true)	{
			showMenu();
			choice=sc.nextInt();
			sc.nextLine();	
			
			switch(choice){
				case 1:
					PhoneInfo ph = inputData();
					for(int i=0; i<info.length; i++) {
						if(info[i]==null) {
							info[i] = ph;
							break;
						}
					}
					break;
					
				case 2:
					for(int i=0; i<info.length;i++) {
						if(info[i] != null) {
							info[i].showPhoneInfo();
						}
					}
					break;
				case 3:
					System.out.println("데이터 검색을 시작합니다.");
					System.out.print("이름:");
					String search = sc.nextLine();
					for(int i=0; i<info.length;i++) {
						if(info[i].getName().equals(search)) {
							info[i].showPhoneInfo();
							break;
						}
					}
					break;
				case 4:
//					String del = sc.nextLine();
//					for(int i=0; i<info.length;i++) {
//						if(info[i].getName().equals(del)) {
//							info[i] = null;
//						}
//					}
					break;
				case 5:
					System.out.println("프로그램을 종료합니다.");
					return;
				default:
					System.out.println("잘못 선택하였습니다. 다시 선택하세요\n");
					continue;
			}
		}//while
	}
}