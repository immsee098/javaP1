package com.day19;

interface III{
	public abstract void method();
}

//AAA와 BBB 는 간접적인 관계
//BBB가 변경되어도 AAA는 변경할 필요가 없다
/*
  클래스 AAA 가 클래스 BBB를 직접 호출하지 않고 인터페이스를 매개체로 하는 경우
- 클래스 AAA는 여전히 클래스 BBB의 메서드를 호출하지만, 
    클래스 AAA는 인터페이스 III 하고만 직접적인 관계에 있기 때문에 
    클래스 BBB의 변경에 영향을 받지 않음 
 */
class AAA{
	public void methodA(III i) {
		i.method();
	}
}

class BBB implements III{
	public void method() {
		System.out.println("BBB의 메서드!!");
	}
}

class CCC implements III{
	public void method() {
		System.out.println("CCC의 메서드!");
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
