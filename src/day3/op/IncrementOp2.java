class IncrementOp2
{
	public static void main(String[] args)
	{
		//증감연산자가 수식에 포함되는 경우
		int i = 5;
		System.out.println("최초 i="+i);

		int k=0;
		k = ++i;
		System.out.println("선증가 : i="+i+", k="+k);

		i =5 ;
		k=i++;
		System.out.println("후증가 : i="+i+", k="+k); //i=6,k=5

		int a =3, b=3;
		System.out.println("a="+a+", b="+b);
		System.out.println("선증가 : " + ++a); //4
		System.out.println("후증가 : " + b++); //3
		System.out.println("최종 a="+a+", b="+b); //4, 4
	}
}