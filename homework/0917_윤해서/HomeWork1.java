package com.java0917;

import java.util.*;
class Account{
	protected String num;
	protected double balance;
	
	Account(String num, double balance){
		this.num = num;
		this.balance = balance;
	}

	public void withdraw(double money) {
		balance -= money;
		
	}
	
	public void display() {
		System.out.println("계좌번호 : "+num);
		System.out.println("잔액 : "+balance);
	}

	public void deposit(double money) {
		balance += money; 
		
	}
}

class FaithAccount extends Account{
	
	FaithAccount(String num, double balance){
		super(num,balance+=balance*0.01);
	}
	
	public void deposit(double money) {
		balance += money+(money*0.01);
	}
}

class ContriAccount extends Account{
	
	private static double contribution;
	
	ContriAccount(String num, double balance){
		super(num,balance-=balance*0.01);
		contribution=balance*0.01;
	}
	
	public void deposit(double money) {
		super.deposit(money-money*0.01);
		contribution+=money*0.01;
	}
	
	public void display() {
		System.out.println("계좌 번호 : "+num);
		System.out.println("계좌 잔액 : "+balance);
		System.out.println("총 기부액 : "+contribution);
	}
}

public class HomeWork1 {

	public static void main(String[] args) {
		Scanner sc= new Scanner(System.in);
		Account ac= null;
		
		System.out.println("개설할 계좌종류 - 일반계좌(A), 신용계좌(F), 기부계좌(C), 계좌번호, 잔액을 입력해 주십시오.");
		String type = sc.nextLine();
		String num = sc.nextLine();
		Double balance = sc.nextDouble();
		
		if(type.equalsIgnoreCase("A")) {
			ac= new Account(num, balance);
		}else if (type.equalsIgnoreCase("F")) {
			ac= new FaithAccount(num, balance);
		}else if (type.equalsIgnoreCase("C") ) {
			ac = new ContriAccount(num, balance);
		}
		
		ac.display();
		
		System.out.println("입금할 금액을 입력하세요.");
		double money = sc.nextDouble();
		ac.deposit(money);
		ac.display();
	}
}


