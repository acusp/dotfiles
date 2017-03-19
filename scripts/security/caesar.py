# _*_ coding: utf-8 _*_
import sys

#a��ANSI����97, z��ANSI����122��
#A��ANSI����65, Z��ANSI����90��

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
		#ansi_raw��û�о����κδ����ԭʼANSI��
		ansi_raw=ord(plain_list[times-1])
		
		if ansi_raw == 32:
			cipher += " "
			continue
		 
		#ansi�Ǿ�����λ���ܵ�ANSI��
		ansi=ansi_raw+int(shift) 
		#word���û������ԭʼ�ַ���
		word=(plain_list[times-1])
	 
		#���ansi_rawС��65�����90�����һ�����Сд��ĸ����ô��˵���������Ͳ�����ĸ�������ܣ�ֱ�����ԭʼ���ݡ�
		if (ansi_raw < 65 or ansi_raw > 90) and word.islower() == False :
			print "Plain text is not letter,", word
		#���ansi_rawС��97�����122�����һ����Ǵ�д��ĸ����ô��˵��������������ĸ�������ܣ�ֱ�����ԭʼ���ݡ�
		elif (ansi_raw < 97 or ansi_raw > 122) and word.isupper() == False:
			print "Plain text is not letter,", word
	 
		#������������ĸ��
		else:
			#������Ǵ�д��ĸ������ANSI�����90����˵�������硣��ôͨ�������ʽ�ص���ͷ��ֱ��������Ϊֹ��
			while word.isupper() == True and ansi > 90:
				ansi = -26 + ansi 
			#������Ǵ�д��ĸ������ANSI��С��65����˵����ǰ���硣��ôͨ�������ʽ�ص���β��ֱ��������Ϊֹ��
			while word.isupper() == True and ansi < 65:
				ansi = 26 + ansi
			#�������Сд��ĸ������ANSI�����122����˵�������硣��ôͨ�������ʽ�ص���ͷ��ֱ��������Ϊֹ��
			while word.isupper() == False and ansi > 122:
				ansi = -26 + ansi
			#�������Сд��ĸ������ANSI��С��97����˵����ǰ���硣��ôͨ�������ʽ�ص���β��ֱ��������Ϊֹ��
			while word.isupper() == False and ansi < 97:
				ansi = 26 + ansi
		 
			#���������ANSIת��Ϊ�ַ�����������ġ�
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
			#ansi_raw��û�о����κδ����ԭʼANSI��
			ansi_raw=ord(cipher_list[times-1])
			
			if ansi_raw == 32:
				plain[shift] += " "
				continue
			 
			#ansi�Ǿ�����λ���ܵ�ANSI��
			ansi=ansi_raw+int(shift) 
			#word���û������ԭʼ�ַ���
			word=(cipher_list[times-1])
		 
			#���ansi_rawС��65�����90�����һ�����Сд��ĸ����ô��˵���������Ͳ�����ĸ�������ܣ�ֱ�����ԭʼ���ݡ�
			if (ansi_raw < 65 or ansi_raw > 90) and word.islower() == False :
				print "Cipher text is not letter,", word
			#���ansi_rawС��97�����122�����һ����Ǵ�д��ĸ����ô��˵��������������ĸ�������ܣ�ֱ�����ԭʼ���ݡ�
			elif (ansi_raw < 97 or ansi_raw > 122) and word.isupper() == False:
				print "Cipher text is not letter,", word
		 
			#������������ĸ��
			else:
				#������Ǵ�д��ĸ������ANSI�����90����˵�������硣��ôͨ�������ʽ�ص���ͷ��ֱ��������Ϊֹ��
				while word.isupper() == True and ansi > 90:
					ansi = -26 + ansi 
				#������Ǵ�д��ĸ������ANSI��С��65����˵����ǰ���硣��ôͨ�������ʽ�ص���β��ֱ��������Ϊֹ��
				while word.isupper() == True and ansi < 65:
					ansi = 26 + ansi
				#�������Сд��ĸ������ANSI�����122����˵�������硣��ôͨ�������ʽ�ص���ͷ��ֱ��������Ϊֹ��
				while word.isupper() == False and ansi > 122:
					ansi = -26 + ansi
				#�������Сд��ĸ������ANSI��С��97����˵����ǰ���硣��ôͨ�������ʽ�ص���β��ֱ��������Ϊֹ��
				while word.isupper() == False and ansi < 97:
					ansi = 26 + ansi
			 
				#���������ANSIת��Ϊ�ַ�����������ġ�
				plain[shift] += chr(ansi)
			
		print shift, "-", "Plain text: ", plain[shift]


if __name__ == "__main__":
	#caesar_encry()
	caesar_decry()
	input()