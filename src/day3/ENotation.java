class ENotation 
{
	public static void main(String[] args)
	{
		//eǥ���
		double a = 1.5e-3; //1.5*10^-3 => 0.0015
		double b = 1.5E+3; //1.5*10^3 => 1500
		double c = 1.5e3; // 1.5*10^3 => 1500

		//16���� 8���� ǥ��
		int d = 0xA0E; //16������ 0x�� ����
		int e = 0125; //8������ 0���� ����

		/*
			10���� 1234 => 1*1000+2*100+3*10+4
			16���� 0xA0E => 10*16^2 + 0*16 + 14
			8���� 0125 => 1*8^2 + 2*8 + 5
		*/

		System.out.println("a="+a+", b="+b+", c="+c);
		System.out.println("d="+d+", e="+e);
	}
}
