class ToStringTest
{
	public static void main(String[] args)
	{
		int a = 10;
		String s = Integer.toString(a);
		System.out.println("s+100="+(s+100));

		double b = 3.14;
		s = Double.toString(b);
		System.out.println(s+"100="+(s+100));

		char ch = 'H';
		s = Character.toString(ch);
		System.out.println(s+"+100="+(a+100));

		boolean bool = true;
		s = Boolean.toString(bool);
		System.out.println(s+"100="+(s+100));
	}
}