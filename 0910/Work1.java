package Work;
import java.util.*;
class Account{
	protected String accno;
	protected double balance;
	
	Account(String accno, double balance){
		this.accno = accno;
		this.balance = balance;
	}
	
	public void deposit(double money) {
		balance+=money;
	}
	
	public void withdraw(double money) {
		balance-=money;
	}
	
	public void display() {
		System.out.println("계좌 번호 : "+accno);
		System.out.println("계좌 잔액 : "+balance);
	}
}

class FaithAccount extends Account{
	
	FaithAccount(String accno, double balance){
		super(accno,balance+=balance*0.01);
	}
	
	public void deposit(double money) {
		balance += money+(money*0.01);
	}
}

class ContriAccount extends Account{
	
	private static double contributione;
	
	ContriAccount(String accno, double balance){
		super(accno,balance-=balance*0.01);
		contributione=balance*0.01;
	}
	
	public void deposit(double money) {
		super.deposit(money-money*0.01);
		contributione+=money*0.01;
	}
	
	public void display() {
		System.out.println("계좌 번호 : "+accno);
		System.out.println("계좌 잔액 : "+balance);
		System.out.println("총 기부액 : "+contributione);
	}
}

public class Work1 {

	public static void main(String[] args) {
		Scanner sc= new Scanner(System.in);
		Account ac= null;
		
		System.out.println("개설할 계좌종류 - 일반계좌(A), 신용계좌(F), 기부계좌(C), 계좌번호,"
				+ "잔액을 입력해 주십시오.");
		String type = sc.nextLine();
		String accno = sc.nextLine();
		Double balance = sc.nextDouble();
		
		if(type.equalsIgnoreCase("A")) {
			ac= new Account(accno, balance);
		}else if (type.equalsIgnoreCase("F")) {
			ac= new FaithAccount(accno, balance);
		}else if (type.equalsIgnoreCase("C") ) {
			ac = new ContriAccount(accno, balance);
		}
		
		ac.display();
		
		System.out.println("입금할 금액을 입력하세요.");
		double money = sc.nextDouble();
		ac.deposit(money);
		ac.display();
	}

}
