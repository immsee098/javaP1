class CharTest
{
	public static void main(String[] args)
	{
		char a = 'A';
		char b = '��';
		char c=0xACF0; 
		char d=0x3051; 
		char e='\u3051'; //�����ڵ�� ���ӹ�

		System.out.println("a="+a+", b="+b+", c="+c+", d="+d+", e="+e);
	}
}