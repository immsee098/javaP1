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
		System.out.println("���� ��ȣ : "+accno);
		System.out.println("���� �ܾ� : "+balance);
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
		System.out.println("���� ��ȣ : "+accno);
		System.out.println("���� �ܾ� : "+balance);
		System.out.println("�� ��ξ� : "+contributione);
	}
}

public class Work1 {

	public static void main(String[] args) {
		Scanner sc= new Scanner(System.in);
		Account ac= null;
		
		System.out.println("������ �������� - �Ϲݰ���(A), �ſ����(F), ��ΰ���(C), ���¹�ȣ,"
				+ "�ܾ��� �Է��� �ֽʽÿ�.");
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
		
		System.out.println("�Ա��� �ݾ��� �Է��ϼ���.");
		double money = sc.nextDouble();
		ac.deposit(money);
		ac.display();
	}

}
