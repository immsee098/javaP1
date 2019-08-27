import java.util.*;

class Homework1 {
    public static void main(String[] args) {
        System.out.println("산술연산자를 입력하세요 + - * /");
        Scanner sc = new Scanner(System.in);
        String math = sc.nextLine();
        System.out.println("실수 두 개를 입력하세요");
        float a = sc.nextFloat();
        float b = sc.nextFloat();
        float result = 0;


        switch(math) {
            case "+":
                result = a+b;
                break;
            case "-":
                result = a-b;
                break;
            case "*":
                result = a*b;
                break;
            case "/":
                result= a/b;
                break;
            default:
                System.out.println("잘못 입력하셨습니다");
        }

        System.out.println("결과값:" + result);

    }
}