import java.util.*;

class ScannerTest3 
{
	public static void main(String[] args)
	{
		Scanner sc = new Scanner(System.in);
		System.out.println("가로를 입력하세요");
		String w = sc.nextLine();
		System.out.println("세로를 입력하세요");
		String h = sc.nextLine();

		int width = Integer.parseInt(w);
		int height = Integer.parseInt(h);

		int area = width*height;

		System.out.println("\n면적 => " +area);
	}
}