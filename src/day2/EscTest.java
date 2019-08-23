class EscTest
{
	public static void main(String[] args)
	{
		/* Escape Sequence
		문자열 안에서 특별한 의미로 해석되는 문자
		표현하기 어려운 문자상수를 표현하는 방법

		\n 줄바꿈
		\t 탭
		\" 큰따옴표 표현
		\\ 역슬래시 표현
		*/

		String path = "d:\\java\\test.txt";
		String s = "Hello\tjava! \"Hi\" oracle";
		System.out.println(path);
		System.out.println(s+"\n");
		System.out.println("안녕\njsp");
	}
}