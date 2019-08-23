class Wrapper
{
	public static void main(String[] args)
	{
		//Wrapper 클래스 - 자료형을 대체하는 클래스
		//기본자료형을 객체로 다루어야 하는 경우 사용
		//Boolean, Character, Byte, Short, Integer
		//Long, Float, Double

		byte b_max = Byte.MAX_VALUE;
		byte b_min = Byte.MIN_VALUE;

		int i_max = Integer.MAX_VALUE;
		int i_min = Integer.MIN_VALUE;

		char c_max = Character.MAX_VALUE;
		char c_min = Character.MIN_VALUE;

		System.out.println("byte 최대값:"+b_max+", 최소값:"+b_min);
		System.out.println("int 최대값:"+i_max+", 최소값:"+i_min);
		System.out.println("byte 최대값+1:"+(i_max+1)); //garbage
		System.out.println("char 최대값:"+c_max+", 최소값:"+c_min); 
		System.out.println("int size:" + Integer.SIZE + ", Bytes:"+Integer.BYTES); 
		System.out.println("int type:"+Integer.TYPE);
	}
}
