package com;

import com.herb.*;
import com.happy.*;

class  TestPackage{
	public static void main(String[] args) 	{
		MyTest t=new MyTest();
		t.showTest();

		MyHerb h = new MyHerb();
		h.showHerb();

		MyHappy ha = new MyHappy();
		ha.showHappy();
	}
}
