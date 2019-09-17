package com.day19;

//과일 판매자
public class FruitSeller2 {
	private int numOfApple;  //사과 개수 30=>27=>26,  20=>18
	private  int myMoney;  //판매수익 4500=>6000,  2000
	private final int PRICE_APPLE; //사과 가격 1500,  1000
	
	public FruitSeller2(int numOfApple, int price){
		this.numOfApple=numOfApple;
		PRICE_APPLE=price;
	}
	
	//과일 판매
	public FruitChange saleApple(int money) {
		int num=money/PRICE_APPLE; //사과 개수 3=> 1, 2
		
		//거스름돈
		int change=money%PRICE_APPLE; //2000%1500=> 500
		
		numOfApple-=num;
		myMoney+=(money-change); //1500
		
		FruitChange fc = new FruitChange(num, change);
		
		return fc;
	}
	
	public void showInfo() {
		System.out.println("판매자의 보유 사과수:"+ numOfApple);
		System.out.println("판매수익:"+ myMoney+"\n");
	}
}


