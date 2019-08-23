class BinaryTest
{
	public static void main(String[] args)
	{
		/*
		10진수 8을 이진수로 변환 => 1000
			2 | 8
				---
				2 | 4...0
					---
					2 | 2...0
						---
						1...0


						2진수로 바꾸고 싶으면 2로 나누고 16진수로 바꾸고 싶으면 16으로 나눔 됨

		10진수 51을 16진수로 변환 =>0x33
			16 | 51
				---
				  3...3


		10진수 51을 8진수로 변환 => 063
			8 | 51
			   ---
			     6...3


		양수 8을 이진수 음수로 변환
		=> 2의 보수를 구한다
			(1의 보수를 구한 후 1을 더하면 2의 보수)

			00001000
			---------
			11110111 (1의 보수)
		+		   1
		-------------
			11111000 (1의 보수+1)


		양수 51을 이진수 음수로 변환
		00110011
		---------
		11001100  (뒤집으면 음수가 된다!)
	+		   1
	-------------
		11001101


		이진수 음수를 10진수로 변환하기
			1) 11111000 (마지막 1만 취하고 다 앞의 1 없애기)
				1000 => -8+0+0+0=> -8

			2) 11001101
				1001101 => =-64+8+4+1 => =51


		*/
		int n = 8;
		System.out.println("n="+n);
		String s = Integer.toBinaryString(n);
		System.out.println(s);

		n = -8;
		System.out.println("\nn="+n);
		s = Integer.toBinaryString(n);
		System.out.println(s);

		n=51;
		System.out.println("\nn="+n);
		s = Integer.toBinaryString(n);
		System.out.println(s);
		System.out.println(Integer.toHexString(n));
		System.out.println(Integer.toOctalString(n));
	}
}