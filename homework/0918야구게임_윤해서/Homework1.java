package com.java0919;

import java.util.Scanner;

class Pitcher{
	private int[] answer = new int[3];
	public Object[] input;
	
	void makeAnswer() {
		for(int i=0; i<answer.length;i++) {
			int temp = (int)(Math.random()*10);
			if(i==0) {
				answer[0] = temp;
			} else {
				for(int j=0; j<i; j++) {
					if(temp==answer[j]) {
						i--;
					} else {
						answer[i] = temp;
					}
				}
			}
		}
	}
	
	int[] showAnswer() {
		return answer;
	}
	
	void showIt() {
		System.out.println("테스트를 위한 본 정답 확인용");
		for(int n:answer) {
			System.out.println(n);
		}
	}
}

class Hiter{
	private int[] input = new int[3];
	
	void inputNum(int a, int b, int c) {
		input[0] = a;
		input[1] = b;
		input[2] = c;
	}
	
	
	int[] showInput() {
		return input;
	}
}

class Umpire{
	private int strike;
	private int ball;
	
	void Verify(Pitcher pi, Hiter hi) {
		for(int i=0; i<3; i++) {
			for(int j=0; j<3; j++) {
				if(pi.showAnswer()[i]==hi.showInput()[j] && i==j) {
					strike++;
				} else if(pi.showAnswer()[i]==hi.showInput()[j] && i!=j) {
					ball++;
				}
			}
		}
	}
	
	int getStrike() {
		return strike;
	}
	
	int getBall() {
		return ball;
	}
	
}

public class Homework1 {

	public static void main(String[] args) {
		Pitcher pi = new Pitcher();
		
		pi.makeAnswer();
		pi.showAnswer();
		pi.showIt();
		
		Scanner sc = new Scanner(System.in);
		
		int count = 0;
		
		while(true) {
			System.out.println("===숫자 세 개 입력(0~9)===");
			int a = sc.nextInt();
			int b = sc.nextInt();
			int c = sc.nextInt();
			
			Hiter hi = new Hiter();
			hi.inputNum(a, b, c);
			
			Umpire um = new Umpire();
			um.Verify(pi, hi);
			
			if(um.getStrike()==3) {
				System.out.println("you win");
				break;
			} else {
				System.out.println("스트라이크의 수:"+um.getStrike());
				System.out.println("볼의 수:"+um.getBall());
			}
			
			count++;	
			
			if(count==2) {
				System.out.println("you lose");
				System.out.println("계속하시겠습니까?<y/n>");
				sc.nextLine();
				String quit = sc.nextLine();
				
				if(quit.equalsIgnoreCase("y")) {
					count=0;
				} else if(quit.equalsIgnoreCase("n")) {
					break;
				}
			}
		}

	}

}
