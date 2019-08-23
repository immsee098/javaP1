class ENotation 
{
	public static void main(String[] args)
	{
		//e표기법
		double a = 1.5e-3; //1.5*10^-3 => 0.0015
		double b = 1.5E+3; //1.5*10^3 => 1500
		double c = 1.5e3; // 1.5*10^3 => 1500

		//16진수 8진수 표기
		int d = 0xA0E; //16진수는 0x로 시작
		int e = 0125; //8진수는 0으로 시작

		/*
			10진수 1234 => 1*1000+2*100+3*10+4
			16진수 0xA0E => 10*16^2 + 0*16 + 14
			8진수 0125 => 1*8^2 + 2*8 + 5
		*/

		System.out.println("a="+a+", b="+b+", c="+c);
		System.out.println("d="+d+", e="+e);
	}
}
