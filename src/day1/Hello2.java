public class Hello2
{
	public static void main(String[] args)
	{
		System.out.println("Hi Java!");
	}
}



//클래스가 여러개인 경우 파일명은 main() 메서드가 있는 클래스명과 동일해야 함
//클래스가 여러개여도 public class는 하나만 가능
//파일명과 동일한 클래스에만 public을 붙일 수 있다
//public class는 아예 없거나 하나만 있어야 함


class Test
{
	public void func()
	{
		System.out.println("Test 클래스의 func()메서드");
	}
}
