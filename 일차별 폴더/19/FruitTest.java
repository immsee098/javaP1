package com.day19;

public class FruitTest {

	public static void main(String[] args) {
		//�������1 : ��� 30��, ���� ���� 1500��
		FruitSeller seller1 = new FruitSeller(30, 1500);
		
		//�������2 : ��� 20��, ���� ���� 1000��
		FruitSeller seller2 = new FruitSeller(20, 1000);
		
		//������ : �����ڻ� 10000��
		FruitBuyer buyer = new FruitBuyer(10000);
		
		//�����ڰ� �������1���� 4500����ġ ��� ����
		buyer.buyApple(seller1, 4500);
		
		//�����ڰ� �������2���� 2000����ġ ��� ����
		buyer.buyApple(seller2, 2000);
		
		//�������1�� ���� ���� ���
		System.out.println("=====�������1=======");
		seller1.showInfo();
		
		//�������2�� ���� ���� ���
		System.out.println("\n=====�������2=======");
		seller2.showInfo();
		
		//�������� ���� ���� ���
		System.out.println("\n=====������=======");
		buyer.showInfo();
		
		//�������1���� 2000�� ��ġ ��� ����
		buyer.buyApple(seller1, 2000);
		
		//�������2���� 5000�� ��ġ ��� ����
		buyer.buyApple(seller2, 5000);
		
		System.out.println("\n====���� ������====");
		buyer.showInfo();
		
		System.out.println("\n======���� �Ǹ���1=====");
		seller1.showInfo();
	}

}
