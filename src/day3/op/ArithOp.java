class ArithOp
{
	public static void main(String[] args)
	{
		/*
		% �������� �켱����
		����>����>����
		���>��>��>����

		% ���������
		+, -, *, /(��), %(������)
		>>, <<, >>>
		*/

		int a=7+3;//10
		int b=7-3; //4
		int c=a*b;//40
		double d=7/3.0; //int/double => double
		int e = 7/3; //���� ���Ѵ�. int/int => int
		int f =7%3; //�������� ���Ѵ�. => 1

		System.out.println("a="+a+", b="+b+", a*b="+c);
		System.out.println("d="+d+", e="+e+", f="+f);
	}
}