import java.util.*;
class Homework1 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String sum ="";


        for(int i=1; i<6; i++) {
            sum += "*";
            System.out.println(sum);
        }

        System.out.println();

        String sum2 = "";
        for(int i=1; i<6; i++) {
            for (int j = 6; j >= i+1; j--) {
                System.out.print("*");	
                				
            }
            System.out.println();
        }

        String sum3 = "";
        System.out.println("1부터 10까지의 합");
        for(int i=1; i<11; i++) {
            if(i != 10 ) {
                sum3 += i + " + ";
            } else {
                sum3 += i;
            }
            System.out.println(sum3);
        }
    }
}