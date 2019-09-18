//import util.java.*;

class Child {
    private int numOfBead;
    private int other;


    Child(int numOfBead){
        this.numOfBead = numOfBead;
    }

    public int loseBead(int loseCount){
        if(numOfBead<loseCount) {
            numOfBead = 0;
        } else {
            numOfBead = numOfBead - loseCount;
        }
        return numOfBead;
    }

    public void obtainBead(Child child, int obtainCount){
        child.numOfBead = child.loseBead(obtainCount);
        other = child.numOfBead;
        numOfBead = this.numOfBead + obtainCount;
    }

    public void showProperty(){
        System.out.println("게임 전 구슬의 보유 개수");
        System.out.println("===어린이1===");
        System.out.println("보유 구슬의 개수: " + numOfBead);
        System.out.println("===어린이2===");
        System.out.println("보유 구슬의 개수: " + other);
    }

}

class Homework1{
    public static void main(String[] args){
        // Scanner sc = new Scanner(System.in);
        Child ch1 = new Child(14);
        Child ch2 = new Child(9);
        ch1.obtainBead(ch2, 2);
        ch2.obtainBead(ch1, 7);
        ch1.showProperty();
        // System.out.println("===>교환 후<==");
        // ch1.loseBead(10);
        // ch1.showProperty();
    }
}