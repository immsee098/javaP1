class Vartest2
{
	public static void main(String[] args) 
	{
		/*
		기본 자료형
		[1] 숫자형
			1) 정수형
				byte	1byte	-128~127
				short	2byte	대략 -32000 ~ 32000
				int		4byte	대략 -21억 ~ 21억
				long	8byte	대략 -922경 ~ 922경

			2) 실수형 - 정밀도에 의해 결정
				float	4byte	대략 소수 이하 7자리까지 유효
				double	8byte	대략 소수 이하 15자리까지 유효
			
		[2] 문자형 char
			문자 하나를 담을 수 있다.
			' (작은 따옴표) 로 감싸야 함
			문자에 해당하는 유니코드 값이 들어감
			=> 실상은 숫자형 => 연산도 가능
		[3] 논리형 boolean
			참, 거짓 => true, false가 들어감
		*/

		//정수형
		byte b =127;
		short sh = 32000;
		int i = 2100000000; //0을 8개 쳐보자
		long n = 21000000000L; //0이 9개
		//=> int의 범위를 벗어나는 경우에는 반드시 L을 붙여야 함
		long g = b*sh*i; //garbage 값(이상한 음수값이나옴)
		//=>byte*short*int => int*int*int => int (가장 큰 단위값으로 형변환되어 곱해짐)
		//int 범위를 벗어나버려서 garbage값이 생긴다
		long o = (long)b*sh*i;
		//그래서 b를 롱으로 바꿔 형변환을 해줘야한다
		//=>long*short*int => long*long*long => long (가방 큰 단위값으로 형변환되어 곱해짐)

		System.out.println("b="+b+", sh="+sh+", i=" + i);
		System.out.println("n="+n);
		System.out.println("b*sh*i=>"+g);
		System.out.println("(long)b*sh*i=>"+o);

		//byte b2 =128; //error
		byte b3 =127;
		b3++; //증감연산자 ~> 1증가
		System.out.println("1증가 후 b3="+b3); //garbage값(범위 벗어나버려서..)
	}
}