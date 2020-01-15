package edu.manazirahsan.utility;

import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class RandomString {
	public String generate(int n) {
		String ALPHA_NUMERIC_STRING = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		StringBuilder randomString = new StringBuilder();
		Random random = new Random();
		for(int i = 0; i < n; i++) {
			randomString.append(ALPHA_NUMERIC_STRING.charAt(random.nextInt(62)));
		}
		return randomString.toString();
	}
}
