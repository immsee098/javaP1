import java.util.*;
class Homework2 {
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        System.out.println("국어, 수학, 영어 점수를 입력하세요");

        int lang = sc.nextInt();
        int math = sc.nextInt();
        int eng = sc.nextInt();

        float aver = (lang + math + eng) / 3 ;
        String result = "";

        if (aver>=70) {
            if(lang >= 50 && eng >=50 && math>=50) {
				result = "합격";
			} else {
				result = "과락";
			}
        } else {
            result = "불합격";
        }
        System.out.println(result);
        System.out.println();

		String result2 = "";

		switch((int)(aver/10)){
			case 9:
				result2 = "A";
				break;
			case 8:
				result2 = "B";
				break;
			case 7:
				result2 = "C";
				break;
			case 6:
				result2 = "D";
				break;
			default:
				result2 = "F";
		}
		System.out.println(result2);
				
    }
}
