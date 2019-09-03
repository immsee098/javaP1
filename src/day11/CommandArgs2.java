public class CommandArgs2 {

	public static void main(String[] args) {
		// 명령줄 인수로 국, 영, 수 점수 입력받아 총점, 평균 구하기
		
		if(args.length<3) {
			System.out.println("국, 영, 수 점수를 입력하세요");
			return;
		}

        int lang = Integer.parseInt(args[0]);
		int eng = Integer.parseInt(args[1]);
		int math = Integer.parseInt(args[2]);
		int sum = lang+eng+math;
		float avg = (float)(sum/3.0);
		
		System.out.println("총점 :" + sum + ", 평균:"+avg);

	}

}