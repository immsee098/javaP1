import java.util.*;

class ScannerTest4
{
	public static void main(String[] args)
	{	Scanner sc = new Scanner(System.in);
		System.out.print("������ �׷��� �Է��ϼ���:");
		int fat = sc.nextInt();
		System.out.println();
		System.out.print("ź��ȭ���� �׷��� �Է��ϼ���:");
		int cab = sc.nextInt();
		System.out.println();
		System.out.print("�ܹ����� �׷��� �Է��ϼ���:");
		int protein = sc.nextInt();

		int total = fat*9 + cab*4 + protein*4;
		System.out.println();
		System.out.println("�� Į�θ� :" + total);

		int kcal = total/1000;
		System.out.println();
		System.out.println("�� kcalĮ�θ� :" + kcal);
	}
}