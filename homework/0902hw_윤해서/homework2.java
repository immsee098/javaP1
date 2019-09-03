package com.java0903;

import java.util.Scanner;

public class homework2 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int sum = 0;
		int[][] arr = {{10, 10, 10, 10, 10}, {20, 20, 20,20,20}, {30,30,30,30,30}, {45,45,45,45,45}};
		for(int i=0; i<arr.length;i++) {
			for(int j=0; j<arr[i].length; j++) {
				sum += arr[i][j];
			}
		}
		
		System.out.println("ÃÑÇÕ : " +sum);
		System.out.println("Æò±Õ :" + (sum/20.0));
	}

}
