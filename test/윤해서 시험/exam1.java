package com.dqy15;

import java.util.*;

public class exam1 {

	public static void main(String[] args) {
		// #문항 2
		float pi = 3.14152f;
		int c = (int)(pi*100);
		float d = (float)c/100;
		System.out.println(d);
		
		// #문항 3
		int num = 17;
		String oe = num%2 == 0 ? "짝수" : "홀수";
		System.out.println(oe);
		
		
		// #문항6
		Scanner sc = new Scanner(System.in);
		System.out.println("난수를 입력");
		int num1 = sc.nextInt();
		int sum = 0;
		for (int i =0; i<num1; i++) {
			int rand = (int)(Math.random()*45+1);
			System.out.println(rand);
			sum += rand;
		}
		System.out.println(sum);
		
		
		// #문항 7
		System.out.println("국어, 영어, 수학 점수를 입력하세요");
		int kor = sc.nextInt();
		int eng = sc.nextInt();
		int math = sc.nextInt();
		
		float aver = (float)(kor+eng+math)/3;
		System.out.println("평균:" + aver);
		
		if(aver>=70) {
			if(kor>=50&&eng>=50&&math>50) {
				System.out.println("합격여부: 합격");
			} else {
				System.out.println("합격여부:과락");
			}
		} else {
			System.out.println("합격여부:불합격");
		}
		
		// #문항 8
		String sum1="";
		for(int i = 1; i<11; i++) {
			if(i!= 1) {
				sum1 += ("+"+Integer.toString(i)) ;
			} else {
				sum1 += Integer.toString(i);
			}
			System.out.println(sum1);
		}
		
		//#문항9
		int sum2 = 0;
		int count=0;
		int[][] arr = {{10,10,10,10,10}, {20,20,20,20,20}, {30,30,30,30,30}, {50,50,50,50,50}};
		for(int i=0; i<arr.length; i++) {
			for(int j=0; j<arr[i].length; j++) {
				sum2 += arr[i][j];
				count++;
			}
		}
		System.out.println("총합:"+sum2);
		System.out.println("평균:" +(float)sum2/count);

	}

}
