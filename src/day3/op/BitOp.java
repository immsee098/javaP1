class BitOp
{
	public static void main(String[] args)
	{
		//��Ʈ��ȯ ������ ~
		//�������� ǥ������ �� 0�� 1��, 1�� 0���� ��ȯ
		//������ char������ ��밡��

		int n = 10;
		System.out.println("n="+n);
		System.out.println(Integer.toBinaryString(n));

		int k = ~n;
		System.out.println("1�� ���� :" + ~k);
		System.out.println(Integer.toBinaryString(k));

		k=~n+1;
		System.out.println("1�� ���� +1 : " +k);
		System.out.println(Integer.toBinaryString(k));
	}
}