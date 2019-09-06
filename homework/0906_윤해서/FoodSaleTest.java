package com.day13;

import java.util.Scanner;

class FoodSale {
	private String menu;
	private int qty;
	private int price;
	private int sold;
	
	static private float sale = 0.15f;
	static private int totalPrice;
	
	FoodSale(String menu, int qty, int price) {
		this.menu = menu;
		this.qty = qty;
		this.price = price;
	}
	
	public void soldPrice() {
		sold = qty*price - (int)(qty*price*sale);
	}
	
	
	public void findTotal() {
		totalPrice += sold; 
	}
	
	public int getTotalPrice() {
		return totalPrice;
	}
	
	public int getSoldPrice() {
		return sold;
	}
 	
}


public class FoodSaleTest {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		while(true) {
			System.out.println("메뉴, 수량, 단가를 입력");
			String menu = sc.nextLine();
			int qty = sc.nextInt();
			int price = sc.nextInt();
			
			FoodSale fs = new FoodSale(menu, qty, price);
			fs.soldPrice();
			fs.findTotal();
			
			System.out.println("판매금액= "+fs.getSoldPrice());
			System.out.println("판매가격 총합계=" +fs.getTotalPrice());
			
			System.out.println("그만하시겠습니까?<q>");
			sc.nextLine();
			
			String qq = sc.nextLine();
			if(qq.equalsIgnoreCase("Q")) break;
		}


	}

}
