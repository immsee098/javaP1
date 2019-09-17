package com.day19;

//과일 구매자
public class FruitBuyer2 {
	private int myMoney; //자산  10000=> 5500 =>3500=> 2000
	private int numOfApple;  //늘어난 사과수  3=>5=>6
	
	public FruitBuyer2(int myMoney){
		this.myMoney=myMoney;
	}
	
	//사과 구매
	//대상, 금액 (과일장사 아저씨, 사과 2000원어치 주세요)
	public void buyApple(FruitSeller2 seller, int money) {
		if(money>myMoney) {
			System.out.println("잔액이 부족하여 구매할 수 없습니다.");
			return;
		}
		
		FruitChange fc=seller.saleApple(money); //과일장사의 판매메서드 호출
		int num=fc.getNum(); //1
		int change=fc.getChange(); //500
		
		numOfApple+=num;
		myMoney-=(money-change); //2000-500=>1500
	}
	
	public void showInfo() {
		System.out.println("구매자의 현재 자산:"+ myMoney);
		System.out.println("구매한 총 사과 개수:"+ numOfApple+"\n");
	}
}
