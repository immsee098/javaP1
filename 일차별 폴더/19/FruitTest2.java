package com.day19;

public class FruitTest2 {

	public static void main(String[] args) {
		//과일장사1 : 사과 30개, 개당 가격 1500원
		FruitSeller2 seller1 = new FruitSeller2(30, 1500);
		
		//과일장사2 : 사과 20개, 개당 가격 1000원
		FruitSeller2 seller2 = new FruitSeller2(20, 1000);
		
		//구매자 : 보유자산 10000원
		FruitBuyer2 buyer = new FruitBuyer2(10000);
		
		//구매자가 과일장사1에게 4500원어치 사과 구매
		buyer.buyApple(seller1, 4500);
		
		//구매자가 과일장사2에게 2000원어치 사과 구매
		buyer.buyApple(seller2, 2000);
		
		//과일장사1의 현재 상태 출력
		System.out.println("=====과일장사1=======");
		seller1.showInfo();
		
		//과일장사2의 현재 상태 출력
		System.out.println("\n=====과일장사2=======");
		seller2.showInfo();
		
		//구매자의 현재 상태 출력
		System.out.println("\n=====구매자=======");
		buyer.showInfo();
		
		//과일장사1에게 2000원 어치 사과 구매
		buyer.buyApple(seller1, 2000);
		
		//과일장사2에게 5000원 어치 사과 구매
		buyer.buyApple(seller2, 5000);
		
		System.out.println("\n====최종 구매자====");
		buyer.showInfo();
		
		System.out.println("\n======최종 판매자1=====");
		seller1.showInfo();
	}

}
