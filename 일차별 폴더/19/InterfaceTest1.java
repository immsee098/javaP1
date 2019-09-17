package com.day19;

//AA�� BB�� �������� ����
//���� : �������� ������ �� Ŭ������ ����(Provider-BB)�� ����Ǹ�, 
//�̸� ����ϴ� �ٸ� �� ��(User-AA)�� ����Ǿ�� ��
class AA{
	/*public void methodA(BB b) {
		b.methodB();
	}*/
	
	public void methodA(CC c) {
		c.methodC();
	}
}

class BB{
	public void methodB() {
		System.out.println("BBŬ������ �޼���!");
	}
}

class CC{
	public void methodC() {
		System.out.println("CC Ŭ������ �޼���");
	}
}

public class InterfaceTest1 {
	public static void main(String[] args) {
		AA obj=new AA();
		//BB b=new BB();
		//obj.methodA(b);
		
		obj.methodA(new CC());
		
	}

}
