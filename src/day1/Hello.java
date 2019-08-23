import java.lang.*;
//근데 위에 랭은 하도 많이써서 걍 생략해도됨

//패키지를 생략하고 클래스명만으로 쓰겠다는 으미
//본래는 import java.lang.String의 식으로 써야한다 -> 이걸 뒤에 *로 쓰면 java.lang패키지의 모든 패키지명을 생략하고 class명만으로 쓰겟다는 말이 됨
/* 패키지란? - 비슷한 유형의 클래스들끼리 묶어서 관리
import - 패키지명은 생략하고 클래스명만으로 사용하고자 할 때 사용
 import java.lang.String ~> java.lang패키지의 string 클래스를 패키지명을 생략하고 클래스명만으로 사용하겟다는 의미
import 패키지명.클래스명
*/

public class Hello {
	public static void main(String[] args) {
		//본래는 위의 스트링도  import java.lang.String이라고 썼어야함
		System.out.println("Hello java!!");
		System.out.println("안녕하세요");
	}
}

//한줄주석
/*여러줄 주석*/

//클래스명과 파일명은 동일해야 함
//=> class명이 Hello이면 파일명도 Hello.java의 형식
//자바는 대소문자도 구분함

/*
c:\>d:
d:>cd D:\lecture\java\src\day1
d:>cd D:\lecture\java\src\day1>javac Hello.java
d:>cd D:\lecture\java\src\day1>java Hello

d:>cd D:\lecture\java\src\day1>dir
*/