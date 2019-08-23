class ConversionTest3
{
	public static void main(String[] args)
	{

		byte a = 10, b=3, c;
		//c=a+b //에러남
		//왜냐?? CPU는 int형 정수연산을 가장 고속으로 처리하게끔 설계되어 있음
		//따라서 정수형 연산을 진행할 때, 모든 피연산자를 int형으로 변환하는 과정을 거침 int가 byte로 뒤집힐 수는 없음
		int d = a+b;

		/*
			연산의 경우 자동 형변환
			[1] int보다 작은 자료형의 연산시 int로 형변환되어 연산함
			[2] int보다 큰 자료형의 연산의 경우는 가장 큰 자료형으로 형변환되어 연산함
		*/

		System.out.println("a="+a+", b="+b);
		System.out.println("d="+d);

		long e = 1000L;
		int f = 34;
		long g =e*f; //long*int=>long*long=>long

		System.out.println("e="+e+", f="+f);
		System.out.println("e*f="+g);

		byte h =127;
		short sh = 32000;
		int i = 2100000000;
		long k = h*sh*i; //garbage값 ~>(long)(h*sh*i)도 가비지 why? 이미 괄호 때문에 int의 가비지값으로 되어있음
		//=>byte*short*int => int*int*int=>int
		long m = (long)h*sh*i; //long*short*int=>long*long*long
		//=>long

		long n = (long)(h*sh*i); //garbage값
		System.out.println("h="+h+", sh="+sh+", i="+i);
		System.out.println("h*sh*i="+k);
		System.out.println("(long)h*sh*i="+m);
		System.out.println("(long)(h*sh*i)="+n);
	}

}