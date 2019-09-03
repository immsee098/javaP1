package com.java0903;

import java.util.Scanner;

public class homework4 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int[] arr = new int[10];
		for(int i=0; i<arr.length; i++) {
			arr[i] = sc.nextInt();
		}
		
		for(int i=0; i<arr.length; i++) {
			for(int j=0; j<arr.length; j++) {
				if(arr[i]>=arr[j]) {
					int temp = 0;
					temp = arr[i];
					arr[i] =arr[j];
					arr[j] = temp;
				}
			}
		}
		
		System.out.println("A학점은 " + arr[1]+"점 이상이 되어야 합니다");

	}

}
