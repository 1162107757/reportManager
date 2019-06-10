package com.reportManager.utils;

import org.apache.commons.codec.digest.DigestUtils;

public class MD5Util {
	
	public static String getMd5(String password) {
		// ¼ÓÃÜºóµÄ×Ö·û´®
		String encodeStr = null;
		try {
			encodeStr = DigestUtils.md5Hex(password);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return encodeStr;
	}
	
}