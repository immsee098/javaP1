public class Vartest7
{
	int age; //�������(�ν��Ͻ� ����)
	static String name; //Ŭ���� ����(static ����)
	static int price;

	public static void main(String[] args)
	{
		int num = 0;
		double d =0.0;
		boolean bool = false;
		String s = null;
		int n;

		System.out.println("Ŭ�������� name="+name+", price="+price);
		System.out.println("num=" + num +", d="+d+", bool="+bool+", s="+s);

		//System.out.println("n="+n);//error
		//���������� �ʱ�ȭ ���� �ʰ� ����ϸ� ����

		/*
		������ ����
		 [1] �������(�ν��Ͻ� ����)
		 [2] Ŭ��������(static����)-
				��������� Ŭ���� ������ �ʱ�ȭ ���� �ʾƵ� default ������ �ʱ�ȭ��
		 [3] �������� - �޼��峪 {}�� �ȿ��� ����� ����
						�ݵ�� �ʱ�ȭ �ؾ���
						�ʱ�ȭ ���� �ʰ� ����ϸ� ������
		*/
	}
}