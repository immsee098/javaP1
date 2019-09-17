package com.day19;

//���� ������
public class FruitBuyer2 {
	private int myMoney; //�ڻ�  10000=> 5500 =>3500=> 2000
	private int numOfApple;  //�þ �����  3=>5=>6
	
	public FruitBuyer2(int myMoney){
		this.myMoney=myMoney;
	}
	
	//��� ����
	//���, �ݾ� (������� ������, ��� 2000����ġ �ּ���)
	public void buyApple(FruitSeller2 seller, int money) {
		if(money>myMoney) {
			System.out.println("�ܾ��� �����Ͽ� ������ �� �����ϴ�.");
			return;
		}
		
		FruitChange fc=seller.saleApple(money); //��������� �ǸŸ޼��� ȣ��
		int num=fc.getNum(); //1
		int change=fc.getChange(); //500
		
		numOfApple+=num;
		myMoney-=(money-change); //2000-500=>1500
	}
	
	public void showInfo() {
		System.out.println("�������� ���� �ڻ�:"+ myMoney);
		System.out.println("������ �� ��� ����:"+ numOfApple+"\n");
	}
}
