import java.util.Scanner;

class ScannerTest 
{
	public static void main(String[] args)
	{
		//����ڿ��� Ű���� �Է¹ޱ�
		//ScannerŬ������ nextInt(), nextLine(), nextDouble()���� �޼��� �̿�

		/*
		[1] static �޼��� ȣ��
			Ŭ������.�޼���();
		[2] �ν��Ͻ� �޼��� ȣ��(static�� ���� ���� �޼���)
			�ش� Ŭ������ ��ü�� ������ �� ��������.�޼���()
		*/

		Scanner sc = new Scanner(System.in);
		System.out.println("�̸��� �Է��ϼ���");
		String name = sc.nextLine();

		System.out.println("���̸� �Է��ϼ���");
		int age = sc.nextInt();

		System.out.println("�̸� : " + name);
		System.out.println("���� : " + age);
	}
}