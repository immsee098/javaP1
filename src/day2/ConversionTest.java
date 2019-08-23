class ConversionTest 
{
	public static void main(String[] args)
	{
		/*
		형변환(Type Conversion)
		- 자료형을 하나로 일치시키는 것
		- 연산이나 대입의 경우 형변환 발생함
		[1] 대입
			1) 자동 형변환 - 작은 범위의 데이터를 큰 범위의 변수에 대입하는 경우
							자동 형변환 발생
							값의 손실이 발생하지 않는 경우 자동형변환됨
			2) 명시적 형변환 - 큰 범위의 데이터를 작은 범위의 변수에 대입하는 경우에는 
							명시적으로 형변환 해야함

		[2] 연산
			1) 자동 형변환 - 가장 큰 자료형으로 자동형변환되어 연산함
			2) 명시적 형변환 - 필요에 따라 명시적으로 형변환해줌

		cast 연산자를 이용하여 명시적으로 형변환함
		(자료형) 변수
		예) long num = 100L;
		int a = (int)num;
		*/

		//[1]대입의 경우
		//자동형변환
		int a = 10;
		long b = a;

		//명시적 형변환
		int c = 30;
		byte d = (byte)c;

		float e = 3.14f;
		long f = (long)e;


		//[2]연산
		//자동형변환
		int g = 50;
		double h =5.46;
		double i = g*h; //int*double => double*double => double
		//int가 double로 자동형변환됨

		//명시적 형변환
		int j = 1, k=2;
		float m = (float)j/k; //float*int => float*float => float
		//=>0.5

		int n = j/k; //int / int => int => 0

		float o = 10.23f, p=5.78f;
		double q = o*p; //float*float => float => 대입시 float이 double로 자동형변환됨

		System.out.println("e="+e+", f="+f);
		System.out.println("g="+g+", h="+h+", g*h="+i);
		System.out.println("j="+j+", k="+k);
		System.out.println("(float)j/k="+m+", j/k="+n);
		System.out.println("o="+o+", p="+p+ ", o*p="+q);


	}
}
