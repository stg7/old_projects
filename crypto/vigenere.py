#!/usr/bin/env python3
# -*- coding: utf8 -*-
import sys, math
"""
	adds int(b) to char a
"""
def charAdd(a,b):
	return chr( ord('a') + ((ord(a) + b -ord('a')) %26 ))


def unCaesar(text):
	#build histo:
	H = {}
	for i in text:
		H[i] = H.get(i,0) +1
	freqChar = ' '
	for i in sorted(H.items(), key=lambda x: x[1], reverse=True):
		freqChar = i[0]
		break
	# calc difference between 'e' and freqChar
	diff = ord(freqChar) - ord('e')
	res = ""
	for i in text:
		res += charAdd(i, -diff)
	return res

def wordFreq(text):
	p = text.split(" ")
	H = {}
	for w in p:
		H[w] = H.get(w,0) + 1
	for i in sorted(H.items(), key=lambda x: x[1], reverse=True):
		freqWord = i
		print("freq word:" + str(freqWord))

def main(args):
	text = str(input('cipher: '))

	# first analyse word frequency
	wordFreq(text)

	text = text.replace(" ",'').replace('.','').replace(",",'')
	print("input text: \n\t" + text)

	print("friedman test for key length:")
	mu = 0.0762
	fi = 0.0385

	m = len(text)
	#build histo:
	H = {}
	for i in text:
		H[i] = H.get(i,0) + 1
	# index of coincidence
	summ = 0.0
	for i in H:
		summ += H[i]*(H[i]-1)
	ic = summ / (m * (m - 1) )

	print("coincidence:" + str(ic))
	# calc key length (friedman-test)
	n = m * (mu - fi)/(ic * (m-1) + mu - m*fi)

	print("friedman-test based length of key:" + str(n))
	n = round(n) +1
	print("used key length:\t" + str(n))

	# foreach key char build up text for caesar decoder:
	texts = ["" for i in range(0,n)]
	i = 0
	for c in text:
		texts[i % n ] += c
		i += 1
	print("split text along keylength:")
	for t in texts:
		print("\t" + t)

	print("unCaesar each text part")
	unVig = []
	for t in texts:
		unVig +=[unCaesar(t)]

	i = 0
	z= [0 for i in range(0,n)]
	dec = ""
	for c in text:
		dec += unVig[i % n ][z[i % n ]]
		z[i % n ]+=1
		i += 1
	print("decoded msg: \n\t" + dec)

	key = ''.join([charAdd(text[i], ord('a')-ord(dec[i]))
		for i in range(0,n)])
	print("used decoding key:" + str(key))
	print("H:" )
	print("& ".join(H.keys()))
	print("& ".join([ str(x) for x in H.values()]))
	s = sum(H.values())
	print("sum" + str(s))
	# calc entropy:
	entropy = 0
	for (k,v) in H.items():
		pi = v / s;
		entropy -= pi* math.log(pi,2)
	print("entropy: " + str(entropy))

	# entropy of decoded message
	H = {}
	for i in dec:
		H[i] = H.get(i,0) +1
	print("H_dec:" )
	print("& ".join(H.keys()))
	print("& ".join([ str(x) for x in H.values()]))
	s = sum(H.values())
	print("sum_dec" + str(s))
	# calc entropy:
	entropy = 0
	for (k,v) in H.items():
		pi = v / s;
		entropy -= pi* math.log(pi,2)
	print("entropy_dec: " + str(entropy))


if __name__ == "__main__":
    main(sys.argv[1:])

