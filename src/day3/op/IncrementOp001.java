class IncrementOp001
{ 
	public static void main(String[] args) 
		{ 
		int a = 0; 
		System.out.println("a : " + a); //0
		System.out.println("a++ : " +  a++); //a가 사용되고 난 후에 1 증가 System.out.println("++a : " +  ++a); //a가 1 증가된 값을 사용 //0

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
