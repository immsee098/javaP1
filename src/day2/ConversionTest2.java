class ConversionTest2
{
	public static void main(String[] args)
	{
		char ch = 'A', ch2 = 'z';
		int i = ch;
		int k = (int)ch2;

		System.out.println("ch="+ch+"=>"+i);
		System.out.println("ch2="+ch2+"=>"+k);

		int m = ch+1; //char+int => int+int => int => 65+1 -> 66
		char ch3 = (char)(ch+2);//65+2=>67=>C
		System.out.println("ch+1="+m+", (char)(ch+2)=>"+ch3);

		int n =97;
		char ch4 = (char)n;
		//char ch5 = n; //error
		System.out.println("n="+n+", (char)n=>"+ch4);

		char ch5 = 'd';
		System.out.println("ch5="+ch5+", (int)ch5=>"+(int)ch5);
	}

}