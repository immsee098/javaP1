class BinaryTest
{
	public static void main(String[] args)
	{
		/*
		10���� 8�� �������� ��ȯ => 1000
			2 | 8
				---
				2 | 4...0
					---
					2 | 2...0
						---
						1...0


						2������ �ٲٰ� ������ 2�� ������ 16������ �ٲٰ� ������ 16���� ���� ��

		10���� 51�� 16������ ��ȯ =>0x33
			16 | 51
				---
				  3...3


		10���� 51�� 8������ ��ȯ => 063
			8 | 51
			   ---
			     6...3


		��� 8�� ������ ������ ��ȯ
		=> 2�� ������ ���Ѵ�
			(1�� ������ ���� �� 1�� ���ϸ� 2�� ����)

			00001000
			---------
			11110111 (1�� ����)
		+		   1
		-------------
			11111000 (1�� ����+1)


		��� 51�� ������ ������ ��ȯ
		00110011
		---------
		11001100  (�������� ������ �ȴ�!)
	+		   1
	-------------
		11001101


		������ ������ 10������ ��ȯ�ϱ�
			1) 11111000 (������ 1�� ���ϰ� �� ���� 1 ���ֱ�)
				1000 => -8+0+0+0=> -8

			2) 11001101
				1001101 => =-64+8+4+1 => =51


		*/
		int n = 8;
		System.out.println("n="+n);
		String s = Integer.toBinaryString(n);
		System.out.println(s);

		n = -8;
		System.out.println("\nn="+n);
		s = Integer.toBinaryString(n);
		System.out.println(s);

		n=51;
		System.out.println("\nn="+n);
		s = Integer.toBinaryString(n);
		System.out.println(s);
		System.out.println(Integer.toHexString(n));
		System.out.println(Integer.toOctalString(n));
	}
}