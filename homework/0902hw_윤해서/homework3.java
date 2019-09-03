package com.java0903;

import java.util.Scanner;

public class homework3 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int[] coinUnit = {500, 100, 50, 10};
		int money = 3870; 
		System.out.println("money="+money+"\n");
		for(int i=0;i<coinUnit.length;i++) {  
			int a = money/coinUnit[i];
			money -= coinUnit[i]*a;
			System.out.println(coinUnit[i]+"¿ø : "+a);
		}

	}

}
