class IncrementOp2
{
	public static void main(String[] args)
	{
		//���������ڰ� ���Ŀ� ���ԵǴ� ���
		int i = 5;
		System.out.println("���� i="+i);

		int k=0;
		k = ++i;
		System.out.println("������ : i="+i+", k="+k);

		i =5 ;
		k=i++;
		System.out.println("������ : i="+i+", k="+k); //i=6,k=5

		int a =3, b=3;
		System.out.println("a="+a+", b="+b);
		System.out.println("������ : " + ++a); //4
		System.out.println("������ : " + b++); //3
		System.out.println("���� a="+a+", b="+b); //4, 4
	}
}