package com.java0830;

import java.util.Scanner;

public class hw3_28 {
	
	public static int convToInt(String a) {
		int number = Integer.parseInt(a);
		if(number>=0 && number<=9) {
		} else {
			number = 11;
		}
		
		return number;
	}
	
	
	public static String insertA(int a) {
		String sum = "B";
		for (int i = 1; i < a; i++) {
			System.out.println(sum);
			sum = "A" + sum;
		}
		return sum;
	}

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		System.out.println("0~9사이의 숫자를 입력");
		
		String num1 = sc.nextLine();
		int a = convToInt(num1);
		
		if(a<11) {
			System.out.println(a + "=>" + a);
		} else {
			System.out.println("잘못입력");
		}
		
		
		System.out.println("====");
		
		System.out.println("반복 횟수 입력");
		int num2 = sc.nextInt();
		String b = insertA(num2);
		System.out.println(b);

	}

}
