class ParseTest
{
	public static void main(String[] args)
	{
		String s = "123";
		//int n = (int)s // error
		//기본 자료형  사이에서만 cast연산자에 의한 형변환 가능
		//기본자료형과 참조형 사이에서는 불가능

		//public static int parseInt(String s)
		// - 숫자형태의 문자열을 int로 변환하는 매서드
		int num = Integer.parseInt(s);

		System.out.println("s+10="+(s+10)); //12310
		System.out.println("num+10="+(num+10)); //133

		s = "abc";
		int n = Integer.parseInt(s); //실행에러가 발생


	}

}