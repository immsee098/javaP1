import java.io.IOException;
import  java.lang.Character;

class Homework3 {
    public static void main(String[] args) throws IOException {
		System.out.println("0~9�� ���ĺ�, �� �� ���ڸ� �Է��ϼ���");
        char ch = (char)System.in.read();
		String result = "";

		if(ch>='0' && ch <='9') {
			result = "�����Դϴ�";
		} else if (Character.toUpperCase(ch)>= 65 && Character.toUpperCase(ch)<=90)
		{
			result = "���ĺ��Դϴ�";
		} else {
			result = "��Ÿ �����Դϴ�";
		}
        System.out.println("�Է��� �� : " + ch + "\t"+result);
		System.out.println("--------------");

		boolean a = Character.isDigit((int)ch);
		if (a)
		{
			System.out.println("���ڰ� �½��ϴ�");
		} else {
			System.out.println("���ڰ� �ƴմϴ�");
		}
    }
}