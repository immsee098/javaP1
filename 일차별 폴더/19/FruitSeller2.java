package com.day19;

//���� �Ǹ���
public class FruitSeller2 {
	private int numOfApple;  //��� ���� 30=>27=>26,  20=>18
	private  int myMoney;  //�Ǹż��� 4500=>6000,  2000
	private final int PRICE_APPLE; //��� ���� 1500,  1000
	
	public FruitSeller2(int numOfApple, int price){
		this.numOfApple=numOfApple;
		PRICE_APPLE=price;
	}
	
	//���� �Ǹ�
	public FruitChange saleApple(int money) {
		int num=money/PRICE_APPLE; //��� ���� 3=> 1, 2
		
		//�Ž�����
		int change=money%PRICE_APPLE; //2000%1500=> 500
		
		numOfApple-=num;
		myMoney+=(money-change); //1500
		
		FruitChange fc = new FruitChange(num, change);
		
		return fc;
	}
	
	public void showInfo() {
		System.out.println("�Ǹ����� ���� �����:"+ numOfApple);
		System.out.println("�Ǹż���:"+ myMoney+"\n");
	}
}


