class ConversionTest3
{
	public static void main(String[] args)
	{

		byte a = 10, b=3, c;
		//c=a+b //������
		//�ֳ�?? CPU�� int�� ���������� ���� ������� ó���ϰԲ� ����Ǿ� ����
		//���� ������ ������ ������ ��, ��� �ǿ����ڸ� int������ ��ȯ�ϴ� ������ ��ħ int�� byte�� ������ ���� ����
		int d = a+b;

		/*
			������ ��� �ڵ� ����ȯ
			[1] int���� ���� �ڷ����� ����� int�� ����ȯ�Ǿ� ������
			[2] int���� ū �ڷ����� ������ ���� ���� ū �ڷ������� ����ȯ�Ǿ� ������
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
		long k = h*sh*i; //garbage�� ~>(long)(h*sh*i)�� ������ why? �̹� ��ȣ ������ int�� ������������ �Ǿ�����
		//=>byte*short*int => int*int*int=>int
		long m = (long)h*sh*i; //long*short*int=>long*long*long
		//=>long

		long n = (long)(h*sh*i); //garbage��
		System.out.println("h="+h+", sh="+sh+", i="+i);
		System.out.println("h*sh*i="+k);
		System.out.println("(long)h*sh*i="+m);
		System.out.println("(long)(h*sh*i)="+n);
	}

}