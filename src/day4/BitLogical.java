class BitLogical
{
	public static void main(String[] args)
	{
		int a = 3, b=5;
		int c = a&b;

		System.out.println("a="+a+", b="+b);
		System.out.println("a&b="+c);
		System.out.println("a="+Integer.toBinaryString(a));
		System.out.println("b="+Integer.toBinaryString(b));
		System.out.println("a&b=>"+Integer.toBinaryString(c));

		/*
			3	0011
			5	0101
			--------
			&	0001 => 1
			|	0111 => 7
			^	0110 => 6
		*/

		System.out.println("a|b=" + (a|b)); //°ýÈ£ ¾ÈÇÏ¸é +ºÎÅÍ °è»êµÊ
		System.out.println("a^b="+(a^b));

		boolean m = true;
		boolean n = a>b; //false
		boolean result = m&n; //false
		System.out.println("m="+m+", n="+n);
		System.out.println("m&n="+result);//false
		System.out.println("m|n="+(m|n));//true
		System.out.println("m^n="+(m^n));

	}
}