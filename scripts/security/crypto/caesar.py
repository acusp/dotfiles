# _*_ coding: utf-8 _*_
import sys

#a的ANSI码是97, z的ANSI码是122。
#A的ANSI码是65, Z的ANSI码是90。

def caesar_encry():
	cipher = ""
	plain = raw_input("Please input plain text: ")
	shift = raw_input("Please input key: ")
	plain_list = list(plain)
	 
	try:
		shift=int(shift)
	except shiftError:
		print("Please input an integer.")
		sys.exit()
		
	plain_list_len = len(plain_list)
	times = 0
	while times < plain_list_len:
		times=times+1
		#ansi_raw即没有经过任何处理的原始ANSI。
		ansi_raw=ord(plain_list[times-1])
		
		if ansi_raw == 32:
			cipher += " "
			continue
		 
		#ansi是经过移位加密的ANSI。
		ansi=ansi_raw+int(shift) 
		#word是用户输入的原始字符。
		word=(plain_list[times-1])
	 
		#如果ansi_raw小于65或大于90，而且还不是小写字母，那么则说明它根本就不是字母。不加密，直接输出原始内容。
		if (ansi_raw < 65 or ansi_raw > 90) and word.islower() == False :
			print "Plain text is not letter,", word
		#如果ansi_raw小于97或大于122，而且还不是大写字母，那么则说明它根本不是字母。不加密，直接输出原始内容。
		elif (ansi_raw < 97 or ansi_raw > 122) and word.isupper() == False:
			print "Plain text is not letter,", word
	 
		#否则，它就是字母。
		else:
			#如果它是大写字母，而且ANSI码大于90，则说明向后出界。那么通过这个公式回到开头，直到不出界为止。
			while word.isupper() == True and ansi > 90:
				ansi = -26 + ansi 
			#如果它是大写字母，而且ANSI码小于65，则说明向前出界。那么通过这个公式回到结尾，直到不出界为止。
			while word.isupper() == True and ansi < 65:
				ansi = 26 + ansi
			#如果它是小写字母，而且ANSI码大于122，则说明向后出界。那么通过这个公式回到开头，直到不出界为止。
			while word.isupper() == False and ansi > 122:
				ansi = -26 + ansi
			#如果它是小写字母，而且ANSI码小于97，则说明向前出界。那么通过这个公式回到结尾，直到不出界为止。
			while word.isupper() == False and ansi < 97:
				ansi = 26 + ansi
		 
			#将处理过的ANSI转换为字符，来输出密文。
			cipher += chr(ansi)
		
	print "Cipher text: ", cipher
	
def caesar_decry():
	plain = ["","","","","","","","","","","","","","","","","","","","","","","","","",""]
	cipher = raw_input("Please input cipher text: ")
	cipher_list = list(cipher)
		
	cipher_list_len = len(cipher_list)
	
	for shift in range(1, 26):
		times = 0
		while times < cipher_list_len:
			times=times+1
			#ansi_raw即没有经过任何处理的原始ANSI。
			ansi_raw=ord(cipher_list[times-1])
			
			if ansi_raw == 32:
				plain[shift] += " "
				continue
			 
			#ansi是经过移位加密的ANSI。
			ansi=ansi_raw+int(shift) 
			#word是用户输入的原始字符。
			word=(cipher_list[times-1])
		 
			#如果ansi_raw小于65或大于90，而且还不是小写字母，那么则说明它根本就不是字母。不加密，直接输出原始内容。
			if (ansi_raw < 65 or ansi_raw > 90) and word.islower() == False :
				print "Cipher text is not letter,", word
			#如果ansi_raw小于97或大于122，而且还不是大写字母，那么则说明它根本不是字母。不加密，直接输出原始内容。
			elif (ansi_raw < 97 or ansi_raw > 122) and word.isupper() == False:
				print "Cipher text is not letter,", word
		 
			#否则，它就是字母。
			else:
				#如果它是大写字母，而且ANSI码大于90，则说明向后出界。那么通过这个公式回到开头，直到不出界为止。
				while word.isupper() == True and ansi > 90:
					ansi = -26 + ansi 
				#如果它是大写字母，而且ANSI码小于65，则说明向前出界。那么通过这个公式回到结尾，直到不出界为止。
				while word.isupper() == True and ansi < 65:
					ansi = 26 + ansi
				#如果它是小写字母，而且ANSI码大于122，则说明向后出界。那么通过这个公式回到开头，直到不出界为止。
				while word.isupper() == False and ansi > 122:
					ansi = -26 + ansi
				#如果它是小写字母，而且ANSI码小于97，则说明向前出界。那么通过这个公式回到结尾，直到不出界为止。
				while word.isupper() == False and ansi < 97:
					ansi = 26 + ansi
			 
				#将处理过的ANSI转换为字符，来输出密文。
				plain[shift] += chr(ansi)
			
		print shift, "-", "Plain text: ", plain[shift]


if __name__ == "__main__":
	#caesar_encry()
	caesar_decry()
	input()