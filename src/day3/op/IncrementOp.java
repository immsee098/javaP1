class IncrementOp
{
	public static void main(String[] args)
	{
		//���������� ++, --
		/*
			++a : ������(���� ������ �� ó��)
					a=a+1
			a++ : ������(���߿� ����)
			--a : ������
					a=a-1
			a-- : �İ���
		*/

		//� ���Ŀ� ���Ե� ���� �ƴ϶� �ܵ����� ���Ǵ� �ܿ�
		//=> ������, �������� ����� ������

		int a = 5;
		System.out.println("a="+a);

		a++; //a=a+1
		System.out.println("a++ �� a="+a); //6

		a=5;
		++a;
		System.out.println("++a �� a="+a); //6

	}
}