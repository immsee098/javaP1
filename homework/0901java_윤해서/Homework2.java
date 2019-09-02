import java.util.Scanner;

class Homework2 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("input string");

        String str = sc.nextLine();

        for(int i=0; i<str.length(); i++) {
            char ver = str.charAt(i);
            int num = (int)ver;

            System.out.println("str.charAt("+i+"):"+ver+"=>"+num);
        }
        
    }
}