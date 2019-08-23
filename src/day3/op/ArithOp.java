class ArithOp
{
	public static void main(String[] args)
	{
		/*
		% 연산자의 우선순위
		단항>이항>삼항
		산술>비교>논리>대입

		% 산술연산자
		+, -, *, /(몫), %(나머지)
		>>, <<, >>>
		*/

		int a=7+3;//10
		int b=7-3; //4
		int c=a*b;//40
		double d=7/3.0; //int/double => double
		int e = 7/3; //몫을 구한다. int/int => int
		int f =7%3; //나머지를 구한다. => 1

		System.out.println("a="+a+", b="+b+", a*b="+c);
		System.out.println("d="+d+", e="+e+", f="+f);
	}
}