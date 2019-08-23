public class Vartest4
{
	public static void main(String[] args){
		//논리형
		//자바의 논리형은 0, 1로 호환되지 않음
		boolean bool = true;

		int a=3, b=5;
		boolean bool2 = a>b;
		System.out.println("bool="+bool);
		System.out.println("a="+a+", b="+b);
		System.out.println("a>b :"+bool2);

	}

}