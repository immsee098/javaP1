import java.util.*;

class ScannerTest3 
{
	public static void main(String[] args)
	{
		Scanner sc = new Scanner(System.in);
		System.out.println("���θ� �Է��ϼ���");
		String w = sc.nextLine();
		System.out.println("���θ� �Է��ϼ���");
		String h = sc.nextLine();

		int width = Integer.parseInt(w);
		int height = Integer.parseInt(h);

		int area = width*height;

		System.out.println("\n���� => " +area);
	}
}