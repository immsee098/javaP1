public class Vartest5 
{
	public static void main(String[] args)
	{
		//실수형 - 소수 이하 정밀도와 관련있다
		//float, double
		//float은 뒤에 F를 붙여야 함, 붙이지 않으면 double로 인식

		float f=3.14F;
		double d=12.456;
		double o =f*d; //float*double => double*double=>double

		System.out.println("f="+f+", d="+d);
		System.out.println("f*d="+o);

		float a=22f, b=3f;
		float c=a/b;
		System.out.println("a="+a+", b="+b);
		System.out.println("a/b="+c);

		double e=22, g=3;
		double h=e/g;
		System.out.println("e="+e+", g="+g);
		System.out.println("e/g="+h);

		double i = .567;
		double k = 123;
		//double형은 정수(int)로 입력 받더라도 자동으로 double형 형변환되어 소숫점 .0이 붙ㅌ게 된다
		System.out.println("i="+i+", k="+k);

	}
}