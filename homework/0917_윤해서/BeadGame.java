/*
1. ����ġ�� ���� Ŭ���� �����ϱ�
- ����̰� �����ϰ� �ִ� ������ ���� ������ ���� �� �ִ�.
- ���̸� ���� ������ �ְ������ ǥ���ϴ� �޼ҵ尡 �����Ѵ�.
  (�� ���̰� ����ġ�⸦ �ϴ� �������� ������ �Ұ� ������ �ǹ���)
- ����� ���� �����ڻ�(������ ��)�� ����ϴ� �޼ҵ尡 �����Ѵ�.

2. ���� ������ �����ϴ� ��ü�� ���� �����ϱ�
- ���1�� �����ڻ� => ���� 15��
- ���2�� �����ڻ� => ���� 9��

3. ��ü�� ������ �Ϸ�Ǹ� ������ ��Ȳ�� Main �޼ҵ� ������ �ùķ��̼� �ϱ�
- 1�� ���ӿ��� ���1�� ���2�� ���� 2���� ȹ���Ѵ�.
- 2�� ���ӿ��� ���2�� ���1�� ���� 7���� ȹ���Ѵ�.
- ������ ��̰� �����ϰ� �ִ� ������ ���� ����Ѵ�.
*/
import java.util.Scanner;

class Child{
	//����ʵ�
	private int numOfBead; //������ ����

	//������
	public Child(int numOfBead)	{
		this.numOfBead=numOfBead;
	}

	//�޼ҵ�
	//�ٸ� ��̿��� ������ ȹ���ϴ� �޼ҵ�
	public void obtainBead(Child child, int obtainCount)
	{
		int obtainBeadCount=child.loseBead(obtainCount); //��� ����� ������ ����
		numOfBead += obtainBeadCount; //������ ȹ���ϸ� �������� ����
	}

	//������ �Ҵ� �޼ҵ�
	public int loseBead(int loseCount){
		if(numOfBead<loseCount) //������ �������� �� ���� ���� ���, ������ ������ŭ�� �Ҵ´�
		{
			int retValue=numOfBead;
			numOfBead=0;

			return retValue;

			//loseCount=numOfBead;
		}

		numOfBead -= loseCount; //������ ������ ���������� ���� ����

		return loseCount;
	}

	//���� �����ϰ� �ִ� ������ ������ ����ϴ� �޼ҵ�
	public void showProperty(){
		System.out.println("���� ������ ����: " + numOfBead);
	}
}//class

class BeadGame{
	public static void main(String[] args){
		Child child1 = new Child(15);
		Child child2 = new Child(9);

		System.out.println("���� �� ������ ���� ����");
		System.out.println("===���1====");
		child1.showProperty();

		System.out.println("===���2====");
		child2.showProperty();

		//1�� ����-���1�� ���2�� ���� 2���� ȹ���Ѵ�.
		child1.obtainBead(child2, 2);

		//2�� ����-���2�� ���1�� ���� 7���� ȹ���Ѵ�.
		child2.obtainBead(child1, 7);

		System.out.println("\n���� �� ������ ���� ����");
		System.out.println("===���1====");
		child1.showProperty();

		System.out.println("===���2====");
		child2.showProperty();
	}
}//class