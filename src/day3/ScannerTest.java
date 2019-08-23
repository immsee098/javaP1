import java.util.Scanner;

class ScannerTest 
{
	public static void main(String[] args)
	{
		//사용자에게 키보드 입력받기
		//Scanner클래스의 nextInt(), nextLine(), nextDouble()등의 메서드 이용

		/*
		[1] static 메서드 호출
			클래스명.메서드();
		[2] 인스턴스 메서드 호출(static이 붙지 않은 메서드)
			해당 클래스의 객체를 생성한 후 참조변수.메서드()
		*/

		Scanner sc = new Scanner(System.in);
		System.out.println("이름을 입력하세요");
		String name = sc.nextLine();

		System.out.println("나이를 입력하세요");
		int age = sc.nextInt();

		System.out.println("이름 : " + name);
		System.out.println("나이 : " + age);
	}
}