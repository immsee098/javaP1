class ParseTest
{
	public static void main(String[] args)
	{
		String s = "123";
		//int n = (int)s // error
		//�⺻ �ڷ���  ���̿����� cast�����ڿ� ���� ����ȯ ����
		//�⺻�ڷ����� ������ ���̿����� �Ұ���

		//public static int parseInt(String s)
		// - ���������� ���ڿ��� int�� ��ȯ�ϴ� �ż���
		int num = Integer.parseInt(s);

		System.out.println("s+10="+(s+10)); //12310
		System.out.println("num+10="+(num+10)); //133

		s = "abc";
		int n = Integer.parseInt(s); //���࿡���� �߻�


	}

}