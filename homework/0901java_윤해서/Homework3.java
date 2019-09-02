import java.util.Scanner;

class Homework3 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        double[] arr = new double[5];

        for(int i=0; i<arr.length; i++) {
            System.out.println((i+1)+"번 이용자의 잔고를 입력하세요");
            arr[i] = sc.nextDouble();        
        }

        System.out.println("이자율을 입력하세요");
        double interest = sc.nextDouble();

        for(int i=0; i<arr.length; i++) {
            double money = arr[i] * ((interest * 0.01) +1);
            System.out.println((i+1)+"번 이용자의 이자가 반영된 잔고 조회 : " + Math.round(money));
        }
    }
}