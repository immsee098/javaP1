class IncrementOp
{
	public static void main(String[] args)
	{
		//증감연산자 ++, --
		/*
			++a : 선증가(먼저 증가한 후 처리)
					a=a+1
			a++ : 후증가(나중에 증가)
			--a : 선감소
					a=a-1
			a-- : 후감소
		*/

		//어떤 수식에 포함된 것이 아니라 단독으로 사용되는 겨웅
		//=> 선증가, 후증가의 결과가 동일함

		int a = 5;
		System.out.println("a="+a);

		a++; //a=a+1
		System.out.println("a++ 후 a="+a); //6

		a=5;
		++a;
		System.out.println("++a 후 a="+a); //6

	}
}