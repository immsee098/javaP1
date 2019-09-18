/*
1. 구슬치기 놀이 클래스 정의하기
- 어린아이가 소유하고 있는 구슬의 개수 정보를 담을 수 있다.
- 놀이를 통한 구슬의 주고받음을 표현하는 메소드가 존재한다.
  (두 아이가 구슬치기를 하는 과정에서 구슬의 잃고 얻음을 의미함)
- 어린이의 현재 보유자산(구슬의 수)을 출력하는 메소드가 존재한다.

2. 다음 조건을 만족하는 객체를 각각 생성하기
- 어린이1의 보유자산 => 구슬 15개
- 어린이2의 보유자산 => 구슬 9개

3. 객체의 생성이 완료되면 다음의 상황을 Main 메소드 내에서 시뮬레이션 하기
- 1차 게임에서 어린이1은 어린이2의 구슬 2개를 획득한다.
- 2차 게임에서 어린이2는 어린이1의 구슬 7개를 획득한다.
- 각각의 어린이가 보유하고 있는 구슬의 수를 출력한다.
*/
import java.util.Scanner;

class Child{
	//멤버필드
	private int numOfBead; //구슬의 개수

	//생성자
	public Child(int numOfBead)	{
		this.numOfBead=numOfBead;
	}

	//메소드
	//다른 어린이에게 구슬을 획득하는 메소드
	public void obtainBead(Child child, int obtainCount)
	{
		int obtainBeadCount=child.loseBead(obtainCount); //상대 어린이의 구슬은 감소
		numOfBead += obtainBeadCount; //구슬을 획득하면 보유구슬 증가
	}

	//구슬을 잃는 메소드
	public int loseBead(int loseCount){
		if(numOfBead<loseCount) //보유한 구슬보다 더 많이 잃은 경우, 보유한 구슬만큼만 잃는다
		{
			int retValue=numOfBead;
			numOfBead=0;

			return retValue;

			//loseCount=numOfBead;
		}

		numOfBead -= loseCount; //구슬을 잃으면 보유구슬의 개수 감소

		return loseCount;
	}

	//현재 보유하고 있는 구슬의 개수를 출력하는 메소드
	public void showProperty(){
		System.out.println("보유 구슬의 개수: " + numOfBead);
	}
}//class

class BeadGame{
	public static void main(String[] args){
		Child child1 = new Child(15);
		Child child2 = new Child(9);

		System.out.println("게임 전 구슬의 보유 개수");
		System.out.println("===어린이1====");
		child1.showProperty();

		System.out.println("===어린이2====");
		child2.showProperty();

		//1차 게임-어린이1은 어린이2의 구슬 2개를 획득한다.
		child1.obtainBead(child2, 2);

		//2차 게임-어린이2는 어린이1의 구슬 7개를 획득한다.
		child2.obtainBead(child1, 7);

		System.out.println("\n게임 후 구슬의 보유 개수");
		System.out.println("===어린이1====");
		child1.showProperty();

		System.out.println("===어린이2====");
		child2.showProperty();
	}
}//class