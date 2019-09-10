//package com.day16;

class AAA{
	public void showInfo() {
		System.out.println("AAA메서드");
	}
}

class BBB{
	public void showInfo() {
		System.out.println("BBB메서드");
	}
}

public class ClassPathTest {

	public static void main(String[] args) {
		System.out.println("class path연습");
		
		AAA obj = new AAA();
		obj.showInfo();
		
		
		BBB b = new BBB();
		b.showInfo();

	}

}
