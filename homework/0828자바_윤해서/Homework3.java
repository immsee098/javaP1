import java.util.*;
class Homework3 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        String value = sc.nextLine();

        boolean k = true;
        
        for(int i =0; i<value.length(); i++) {
            char a = value.charAt(i);
            if (a>=48 && a<=57) {
                System.out.print("");
            } else {
                k = false;
            }
        }

        if (k) {
            System.out.println(value+" is num");
        } else {
            System.out.println(value+" is not a num");
        }



        
    }
}