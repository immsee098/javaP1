
public class CommandArgs {

	public static void main(String[] args) {
		
		System.out.println("매개변수 args의 크기: "+args.length);
		if(args.length<2) {
			System.out.println("매개변수를 2개 입력하세요!");
			return;
		}
		
		String name = args[0];
		int age = Integer.parseInt(args[1]);
		
		System.out.println(name);
		System.out.println(age);

	}

}
