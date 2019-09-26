import java.util.*;

class Homework1 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("insert");
        int num = sc.nextInt();

        int sum =0;
        while(true) {
            int remain = num%10;
            num = (int)(num/10);
            sum += remain;
            System.out.println(remain);
            if(num==0){
                break;
            }
        }

        System.out.println(sum);
    }
}