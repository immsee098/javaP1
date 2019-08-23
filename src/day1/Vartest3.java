class Vartest3
{
	public static void main(String[] args)
	{
		char ch ='A'; //문자 하나가 들어감, 작은 따옴표 '로 감싸야 함
		//=>실제로는 유니코드 값인 65가 들어감
		char a = '가';
		//char b = 'abc'; //error, 한 글자만 넣어야 함

		int c = ch+1; //연산도 가능
		System.out.println("ch="+ch+", a="+a);
		System.out.println("ch+1=>"+c+", (char)c=>"+(char)c);

		int d = (int)ch;
		System.out.println("(int)ch=>" +d);
		char e =97; //직접 유니코드 값을 넣을 수도 있다
		System.out.println("e="+ e + ", (int)e=>"+(int)e);
	}
}