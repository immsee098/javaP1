class ConversionTest 
{
	public static void main(String[] args)
	{
		/*
		����ȯ(Type Conversion)
		- �ڷ����� �ϳ��� ��ġ��Ű�� ��
		- �����̳� ������ ��� ����ȯ �߻���
		[1] ����
			1) �ڵ� ����ȯ - ���� ������ �����͸� ū ������ ������ �����ϴ� ���
							�ڵ� ����ȯ �߻�
							���� �ս��� �߻����� �ʴ� ��� �ڵ�����ȯ��
			2) ����� ����ȯ - ū ������ �����͸� ���� ������ ������ �����ϴ� ��쿡�� 
							��������� ����ȯ �ؾ���

		[2] ����
			1) �ڵ� ����ȯ - ���� ū �ڷ������� �ڵ�����ȯ�Ǿ� ������
			2) ����� ����ȯ - �ʿ信 ���� ��������� ����ȯ����

		cast �����ڸ� �̿��Ͽ� ��������� ����ȯ��
		(�ڷ���) ����
		��) long num = 100L;
		int a = (int)num;
		*/

		//[1]������ ���
		//�ڵ�����ȯ
		int a = 10;
		long b = a;

		//����� ����ȯ
		int c = 30;
		byte d = (byte)c;

		float e = 3.14f;
		long f = (long)e;


		//[2]����
		//�ڵ�����ȯ
		int g = 50;
		double h =5.46;
		double i = g*h; //int*double => double*double => double
		//int�� double�� �ڵ�����ȯ��

		//����� ����ȯ
		int j = 1, k=2;
		float m = (float)j/k; //float*int => float*float => float
		//=>0.5

		int n = j/k; //int / int => int => 0

		float o = 10.23f, p=5.78f;
		double q = o*p; //float*float => float => ���Խ� float�� double�� �ڵ�����ȯ��

		System.out.println("e="+e+", f="+f);
		System.out.println("g="+g+", h="+h+", g*h="+i);
		System.out.println("j="+j+", k="+k);
		System.out.println("(float)j/k="+m+", j/k="+n);
		System.out.println("o="+o+", p="+p+ ", o*p="+q);


	}
}
