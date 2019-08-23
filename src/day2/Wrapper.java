class Wrapper
{
	public static void main(String[] args)
	{
		//Wrapper Ŭ���� - �ڷ����� ��ü�ϴ� Ŭ����
		//�⺻�ڷ����� ��ü�� �ٷ��� �ϴ� ��� ���
		//Boolean, Character, Byte, Short, Integer
		//Long, Float, Double

		byte b_max = Byte.MAX_VALUE;
		byte b_min = Byte.MIN_VALUE;

		int i_max = Integer.MAX_VALUE;
		int i_min = Integer.MIN_VALUE;

		char c_max = Character.MAX_VALUE;
		char c_min = Character.MIN_VALUE;

		System.out.println("byte �ִ밪:"+b_max+", �ּҰ�:"+b_min);
		System.out.println("int �ִ밪:"+i_max+", �ּҰ�:"+i_min);
		System.out.println("byte �ִ밪+1:"+(i_max+1)); //garbage
		System.out.println("char �ִ밪:"+c_max+", �ּҰ�:"+c_min); 
		System.out.println("int size:" + Integer.SIZE + ", Bytes:"+Integer.BYTES); 
		System.out.println("int type:"+Integer.TYPE);
	}
}
