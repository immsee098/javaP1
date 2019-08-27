import java.io.IOException;
import  java.lang.Character;

class Homework3 {
    public static void main(String[] args) throws IOException {
		System.out.println("0~9나 알파벳, 그 외 문자를 입력하세요");
        char ch = (char)System.in.read();
		String result = "";

		if(ch>='0' && ch <='9') {
			result = "숫자입니다";
		} else if (Character.toUpperCase(ch)>= 65 && Character.toUpperCase(ch)<=90)
		{
			result = "알파벳입니다";
		} else {
			result = "기타 문자입니다";
		}
        System.out.println("입력한 값 : " + ch + "\t"+result);
		System.out.println("--------------");

		boolean a = Character.isDigit((int)ch);
		if (a)
		{
			System.out.println("숫자가 맞습니다");
		} else {
			System.out.println("숫자가 아닙니다");
		}
    }
}