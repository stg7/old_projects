#!/usr/bin/env python3
# -*- coding: utf8 -*-
import sys
import math
"""
	adds int(b) to char a
"""
def charAdd(a,b):
	return chr( ord('a') + ((ord(a) + b -ord('a')) %26 ))

def main(args):
	text = str(input('cipher: '))
	print("input text:" + text)

	#build histo:
	H = {}
	for i in text:
		if i not in " ,.-:":
			H[i] = H.get(i,0) +1
	freqChar = ' '
	for i in sorted(H.items(), key=lambda x: x[1], reverse=True):
		freqChar = i[0]
		break
	print(freqChar)

	# calc difference between 'e' and freqChar
	diff = ord(freqChar) - ord('e')
	print("freqChar:" + str(freqChar) + " diff to 'e'" + str(diff))

	for k in range(1, 25):
		print("key: " + str(k))
		for i in text:
			if i not in " ,.-:":
				print(charAdd(i,k) , end='')
			else:
				print(i, end='')
		print('')
	print(H)
	s = sum(H.values())
	print("sum:" + str(s))
	# calc entropy:
	entropy = 0
	for (k,v) in H.items():
		pi = v / s;
		entropy -= pi* math.log(pi,2)
	print("entropy: " + str(entropy))

if __name__ == "__main__":
    main(sys.argv[1:])
