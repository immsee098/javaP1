class IncrementOp001
{ 
	public static void main(String[] args) 
		{ 
		int a = 0; 
		System.out.println("a : " + a); //0
		System.out.println("a++ : " +  a++); //a�� ���ǰ� �� �Ŀ� 1 ���� System.out.println("++a : " +  ++a); //a�� 1 ������ ���� ��� //0

		double b = 7; 
		System.out.println("b : " +  b); //7
		System.out.println("b-- : " +  b--); //7 
		System.out.println("--b : " +  --b); //5

		char c = 'A'; 
		System.out.println("c : " + c); //A
		System.out.println("++c : " + ++c); //B

		c = 'a'; 
		System.out.println("c : " +  c); //a
		c++; 
		System.out.println("c++ : " +  c);//b
	}
}
