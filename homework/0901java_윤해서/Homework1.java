import java.util.Scanner;

class Homework1 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int[] lottery = new int[8];



        while(true) {
            System.out.println("shop1~8 input");
            String shopNum = sc.nextLine().trim(); //이 부분에 공백 제거 처리를 하지 않으면 숫자를 넣어도 에러가 납니다... 왜 이럴까요? 공백을 넣지 않아도 에러가 납니다... 
            if(shopNum == null || shopNum.equals("")){
                shopNum = "0";
            } 

            int shop2 = Integer.parseInt(shopNum);
            int sell = sc.nextInt();
            System.out.println(shop2+", "+sell);

            if(shop2>=1&&shop2<=8) {
                lottery[shop2-1] = lottery[shop2-1] + sell;
                System.out.println("group : " + shop2+", sell : "+lottery[shop2-1]);
            } else if (shop2=='q' || shop2=='Q') {
                break;
            } else {
                System.out.println("error / input 1~8");
                continue;
            }
            sc.nextLine();
            System.out.println("next");

        }

    }
}