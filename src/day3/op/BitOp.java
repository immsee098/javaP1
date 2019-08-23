class BitOp
{
	public static void main(String[] args)
	{
		//비트전환 연산자 ~
		//이진수로 표현했을 때 0은 1로, 1은 0으로 변환
		//정수와 char에서만 사용가능

		int n = 10;
		System.out.println("n="+n);
		System.out.println(Integer.toBinaryString(n));

		int k = ~n;
		System.out.println("1의 보수 :" + ~k);
		System.out.println(Integer.toBinaryString(k));

		k=~n+1;
		System.out.println("1의 보수 +1 : " +k);
		System.out.println(Integer.toBinaryString(k));
	}
}