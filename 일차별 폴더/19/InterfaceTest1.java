package com.day19;

//AA와 BB는 직접적인 관계
//단점 : 직접적인 관계의 두 클래스는 한쪽(Provider-BB)이 변경되면, 
//이를 사용하는 다른 한 쪽(User-AA)도 변경되어야 함
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
		System.out.println("BB클래스의 메서드!");
	}
}

class CC{
	public void methodC() {
		System.out.println("CC 클래스의 메서드");
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
