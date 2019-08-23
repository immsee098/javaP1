class CoversionPrac
{
	public static void main(String[] args)
	{
		byte a = 1;
		short b = 10;
		int c = a-b;
		System.out.println(c);

		int d = 22;
		long e = 35235454L;
		long f = d*e;
		System.out.println(f);

		long g = 4345L;
		double h = g;
		System.out.println(h);

		float i = 54.4F;
		long j = (long)i;
		System.out.println(j);

		char k = 'a';
		int l = (int)k;
		System.out.println(l);

		char ch = 'a';
		int ar = ch - 32;
		System.out.println( ch + " => 대문자로 변환 : " + (char)ar);

		float pi = 3.131592f;
		//int in = (int)(pi*1000);
		//float div = (float)in/1000;
		//System.out.println(div);

		float shortPi = (int)(pi*1000)/1000f;
		System.out.println(shortPi);
	}
}