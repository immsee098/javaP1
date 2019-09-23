package com.java0923;

import java.util.ArrayList;
import java.util.Scanner;

interface SpecialInterest {
    public void Special(String it);
}

class Account{
    protected int account;
    protected int balance;
    protected String name;

    Account(int account, int balance, String name) {
        this.account = account;
        this.balance = balance;
        this.name = name;
    }

    void setAccount(int account) {
        this.account = account;
    }

    void setBalance(int balance) {
        this.balance = balance;
    }

    void setName(String name) {
        this.name = name;
    }

    int getAccount() {
        return account;
    }

    int getBalance() {
        return balance;
    }

    String getName() {
        return name;
    }

    void deposit(int input) {
        this.balance += input;
    }

    int withdraw(int output) {
        int a = 0;
        if (balance > output) {
            a = balance - output;
        } else {
        }
        return a;
    }

    void display() {
        System.out.println("계좌번호:" + account);
        System.out.println("잔액:" + balance);
        System.out.println("고객이름:" + name);
    }

}

class NormalAccount extends Account {
    protected final int interest;

    NormalAccount(int account, int balance, String name, int interest) {
        super(account, balance, name);
        this.interest = interest;
    }

    void deposit(int input) {
        double realInte = 0.01*interest;
        this.balance += (input*(1+realInte));
    }

    void display() {
        System.out.println("계좌번호:" + account);
        System.out.println("잔액:" + balance);
        System.out.println("고객이름:" + name);
        System.out.println("이자율:"+interest);
    }

}


class HighCreditAccount extends NormalAccount implements SpecialInterest{
    private String specialInt;
    private int int2;
    HighCreditAccount(int account, int balance, String name, int interest, String specialInt) {
        super(account, balance, name, interest);
        this.specialInt = specialInt;
    }

    public void Special(String it){
        if(it.equals("A")){
            this.int2 = 3;
        } else if(it.equals("B")){
            this.int2 = 2;
        } else if(it.equals("C")){
            this.int2 = 1;
        }
    }

    void deposit(int input) {
        double realInte = 0.01*interest;
        double realSpeInt = 0.01*int2;
        this.balance += (input*(1+realInte)+input*(realInte));
    }

}

class Homework1 {
    public static void main(String[] args) {
    	
    	ArrayList<Account> arr = new ArrayList<Account>();
    	
        Scanner sc = new Scanner(System.in);
        System.out.println("----Menu----");
        
        while(true) {
	        System.out.println("1.계좌 계설\n2.입금\n3.출금\n4.계좌정보 전체출력\n5.프로그램 종료");
	        System.out.print("\n선택: ");
	        int select = sc.nextInt();
	        
	        if(select==1) {
	        	System.out.println("[계좌종류선택]\n1.보통예금계좌\n2.신용신뢰계좌");
	        	System.out.print("\n선택: ");
	        	int accSel = sc.nextInt();
	        	if(accSel==1) {
	        		System.out.print("계좌ID: ");
	        		int acc = sc.nextInt();
	        		sc.nextLine();
	        		System.out.print("이름: ");
	        		String name = sc.nextLine();
	        		System.out.print("입금액: ");
	        		int input = sc.nextInt();
	        		System.out.print("이자율:");
	        		int interest = sc.nextInt();
	        		
	        		arr.add(new NormalAccount(acc, input, name, interest));
	        	} else if(accSel==2) {
	        		System.out.print("계좌ID: ");
	        		int acc = sc.nextInt();
	        		sc.nextLine();
	        		System.out.print("이름: ");
	        		String name = sc.nextLine();
	        		System.out.print("입금액: ");
	        		int input = sc.nextInt();
	        		System.out.print("이자율:");
	        		int interest = sc.nextInt();
	        		sc.nextLine();
	        		System.out.print("신용등급:");
	        		String credit = sc.nextLine();
	        		
	        		arr.add(new HighCreditAccount(acc, input, name, interest, credit));
	        	} 
	        } else if (select==2) {
	        	System.out.println("\n[입   금]");
				System.out.print("계좌ID: ");
				int acc=sc.nextInt();
				sc.nextLine();
				System.out.print("입금액: ");
				int money=sc.nextInt();
				sc.nextLine();
				for(Account n : arr) {
					if(n.getAccount()==acc) {
						n.deposit(money);
					} else {
					System.out.println("유효하지 않은 ID입니다.");
					}
				} 
	        } else if (select==3) {
	        	System.out.println("\n[출   금]");
				System.out.print("계좌ID: ");
				int acc=sc.nextInt();
				sc.nextLine();
				System.out.print("출금액: ");
				int money=sc.nextInt();
				sc.nextLine();
				for(Account n : arr) {
					if(n.getAccount()==acc) {
						n.withdraw(money);
					} else {
					System.out.println("유효하지 않은 ID입니다.");
					}
				} 
	        } else if(select==4){
	        	for(Account n : arr) {
	        		System.out.println();
	        		n.display();
	        	}
	        } else if(select==5) {
	        	break;
	        } else {
	        	System.out.println("잘못 입력하였습니다.");
	        }
        }
       
    }
}