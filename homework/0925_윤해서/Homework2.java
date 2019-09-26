import java.util.*;
class Verify{
    String ver(int num){
        String print = "";
        String num2 = Integer.toString(num);
        for(int i=0; i<num2.length();i++){
            int a = Integer.parseInt(num2.substring(i,i+1));
            if(a%3==0){
                print="*";
                break;
            } else {
                print= num2;
            }
        }
        return print;
    }
}

class Homework2 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int num = sc.nextInt();

        Verify ver = new Verify();

        for(int i=1; i<num+1; i++){
            if(i%10!=0){
                System.out.print(ver.ver(i)+"\t");
            } else {
                System.out.print(ver.ver(i)+"\t");
                System.out.println();
            }
        }

    }
}