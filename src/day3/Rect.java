import java.util.*;

class Rect
{
	public static void main(String[] args)
	{
		//사각형의 면적ㄱㅖ산
		Scanner sc = new Scanner(System.in);
		System.out.println("가로를 입력하세요");
		int w = sc.nextInt();

		System.out.println("세로를 입력하세요");
		int h = sc.nextInt();

		//로직처리-사각형 면적 계산
		int area = w*h;

		//결과 출력
		System.out.println("사각형 면적: " + area);

	}
}