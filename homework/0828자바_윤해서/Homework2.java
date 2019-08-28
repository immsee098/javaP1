import java.util.*;
class Homework2 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("input1");
        int sum = 0;
        String num = sc.nextLine();

        for(int i=0; i<num.length(); i++) {
            sum += num.charAt(i) - '0';
            System.out.println("1번 숫자의 합은"+sum);
        }


        System.out.println();
        System.out.println("input2");

        int num2 = sc.nextInt();
        int length = (int)(Math.log10(num2)+1);

        int sum2 = 0;

        for(int i=1; i<length+1; i++) {
            int left = num2%10;
			sum2 += left;
			num2 = num2/10;
        }
        System.out.println("2번 숫자의 합은="+sum2);
    }
}