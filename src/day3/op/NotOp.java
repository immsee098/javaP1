class NotOp
{
	public static void main(String[] args)
	{
		//������ ������ !
		//boolean������ ���
		//true�� false��, false�� true�� ��ȯ
		boolean power = true;
		System.out.println("power ="+power);

		power =! power; //false
		System.out.println("!power="+power);
		System.out.println("!power=" + !power); //true

		int a=3, b=5;
		boolean bool = a>b; //false
		System.out.println("a="+a+", b="+b);
		System.out.println("a>b :"+bool);

		bool =! (a>b); //true
		System.out.println("!(a>b) : "+bool);
	}
}