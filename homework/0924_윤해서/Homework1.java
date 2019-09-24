import java.util.*;

class Homework1 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("insert");
        int num = sc.nextInt();
        
        if(num%2 != 0){
            System.out.println("wrong");
        } else {
            int[] arr = new int[num];
            for(int i=0; i<num; i++){
                int ran = (int)((Math.random()*num/2));
                if(i==0){
                    arr[0] = ran;
                } else {
                    int count = 0;
                    loop1 : for(int j=0; j<i+1; j++){
                        if(count>=2){
                            System.out.println("break");
                            i--;
                            count = 3;
                            System.out.println(i+"time");
                            break loop1;
                        } else if(count<2 && ran==arr[j]){
                            System.out.println(ran+"val count");
                            count++;
                        } 
                    }
                    System.out.println(i+" time end");
                    if(count<2){
                        arr[i] = ran;
                    }
                }
            }
            for(int n:arr){
                System.out.print(n+"\t");
            }

        }

    }
}