package com.iyoons.world.controller;

public class codingTest {
	public static void main(String[] args) {
        /**
         * 문제 : result의 값은 무엇일까요?
         * */
        String result = exR1(6);
        System.out.println("result : "+result);
    }

    private static String exR1(int n) {
        if (n <= 0) return "";
        System.out.println(exR1(n - 3) + n + exR1(n - 2) + n);
        return exR1(n - 3) + n + exR1(n - 2) + n;
    }
}
