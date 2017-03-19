# _*_ coding: utf-8 _*_

def decode():
	res = ''
	r = int(input('row: '))
	c = int(input('column: '))
	msg = raw_input('CIPHER TEXT: ')
	for i in range(0, c):
		for j in range(0, r*c, c):
			res += msg[i+j]
	print "ANSWER: ", res

if __name__ == "__main__":
	decode()
	input()