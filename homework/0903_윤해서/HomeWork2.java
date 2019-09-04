package com.java0904;

import java.util.Scanner;

class Time {
	int hour;
	int min;
	int sec;
	
	Time(int p_sec) {
		sec = p_sec;
	}
	
	Time(int p_sec, int p_min) {
		sec = p_sec;
		min = p_min;
	}
	
	Time(int p_sec, int p_min, int p_hour) {
		sec = p_sec;
		min = p_min;
		hour = p_hour;
	}
	
	void showInfo() {
		System.out.println(hour+"Ω√ "+min+"∫– "+30+"√ ");
	}
	
	public int secShow() {
		return hour*60*60 + min*60 +sec;
	}
}

public class HomeWork2 {

	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);

	}

}
