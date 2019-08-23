class RelationOp
{
	public static void main(String[] args)
	{
		//비교 연산자 >, <, >=, <=, ==, !=
		int a=7, b=3;
		boolean bool = a>=b; //true;

		System.out.println("a="+a+", b="+b);
		System.out.println("a>=b : " + bool);
		System.out.println("a==b : " + (a==b));
		System.out.println("a!=b : " + (a!=b));
		System.out.println("a<=b : " + (a<=b));
		System.out.println("a<b : " + (a<b));
		System.out.println("a>b : " + (a>b));
	}
}