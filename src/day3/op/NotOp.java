class NotOp
{
	public static void main(String[] args)
	{
		//논리부정 연산자 !
		//boolean에서만 사용
		//true는 false로, false는 true로 전환
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