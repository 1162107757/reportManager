package com.reportManager.utils;

import java.util.UUID;

public class UUIDUtil {

	public static void main(String[] args) throws Exception {
		System.out.println(UUID.randomUUID());
		System.out.println(MD5Util.getMd5("123456"));
		
		System.out.println(100 % 10);
		System.out.println(90 % 10);
		
		Page[] pages = new Page[5];
		
		pages[0] = new Page();
		System.out.println(pages);
	}
	
}
