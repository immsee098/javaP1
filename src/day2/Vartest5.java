public class Vartest5 
{
	public static void main(String[] args)
	{
		//�Ǽ��� - �Ҽ� ���� ���е��� �����ִ�
		//float, double
		//float�� �ڿ� F�� �ٿ��� ��, ������ ������ double�� �ν�

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
		//double���� ����(int)�� �Է� �޴��� �ڵ����� double�� ����ȯ�Ǿ� �Ҽ��� .0�� �٤��� �ȴ�
		System.out.println("i="+i+", k="+k);

	}
}