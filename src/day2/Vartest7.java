public class Vartest7
{
	int age; //멤버변수(인스턴스 변수)
	static String name; //클래스 변수(static 변수)
	static int price;

	public static void main(String[] args)
	{
		int num = 0;
		double d =0.0;
		boolean bool = false;
		String s = null;
		int n;

		System.out.println("클래스변수 name="+name+", price="+price);
		System.out.println("num=" + num +", d="+d+", bool="+bool+", s="+s);

		//System.out.println("n="+n);//error
		//지역변수는 초기화 하지 않고 사용하면 에러

		/*
		변수의 종류
		 [1] 멤버변수(인스턴스 변수)
		 [2] 클래스변수(static변수)-
				멤버변수나 클래스 변수는 초기화 하지 않아도 default 값으로 초기화됨
		 [3] 지역변수 - 메서드나 {}블럭 안에서 선언된 변수
						반드시 초기화 해야함
						초기화 하지 않고 사용하면 에러남
		*/
	}
}