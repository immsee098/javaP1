import java.util.*;

class ScannerTest4
{
	public static void main(String[] args)
	{	Scanner sc = new Scanner(System.in);
		System.out.print("지방의 그램을 입력하세요:");
		int fat = sc.nextInt();
		System.out.println();
		System.out.print("탄수화물의 그램을 입력하세요:");
		int cab = sc.nextInt();
		System.out.println();
		System.out.print("단백질의 그램을 입력하세요:");
		int protein = sc.nextInt();

		int total = fat*9 + cab*4 + protein*4;
		System.out.println();
		System.out.println("총 칼로리 :" + total);

		int kcal = total/1000;
		System.out.println();
		System.out.println("총 kcal칼로리 :" + kcal);
	}
}