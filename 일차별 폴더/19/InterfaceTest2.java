package com.day19;

interface III{
	public abstract void method();
}

//AAA�� BBB �� �������� ����
//BBB�� ����Ǿ AAA�� ������ �ʿ䰡 ����
/*
  Ŭ���� AAA �� Ŭ���� BBB�� ���� ȣ������ �ʰ� �������̽��� �Ű�ü�� �ϴ� ���
- Ŭ���� AAA�� ������ Ŭ���� BBB�� �޼��带 ȣ��������, 
    Ŭ���� AAA�� �������̽� III �ϰ� �������� ���迡 �ֱ� ������ 
    Ŭ���� BBB�� ���濡 ������ ���� ���� 
 */
class AAA{
	public void methodA(III i) {
		i.method();
	}
}

class BBB implements III{
	public void method() {
		System.out.println("BBB�� �޼���!!");
	}
}

class CCC implements III{
	public void method() {
		System.out.println("CCC�� �޼���!");
	}
}

public class InterfaceTest2 {

	public static void main(String[] args) {
		AAA obj = new AAA();
		
		//III i = new BBB();
		//obj.methodA(i);

		CCC c = new CCC();
		obj.methodA(c);
	}

}
