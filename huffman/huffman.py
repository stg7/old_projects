#!/usr/bin/env python3
import sys,os,queue,pickle
def dotOutputCodeTable(codetable, parent, tree, ROOT):
	s = []
	pr = lambda x : s.append(x)

	r = 0
	pr("digraph graphname {")
	#pr("	graph [ordering=\"out\"];")
	pr("# parent: " + str(parent))
	pr("# codetable: " + str(codetable))
	pr("# tree: " + str(tree))
	pr("# ROOT: " + str(ROOT[1]))

	for v in parent:
		if v in codetable:
			pr("\t" + parent[v] + " -> " + "n" + str(r) +";")
			pr("\t\tn" + str(r) +"[label=\"" + repr(v).replace("\"","'") + "\" ];" )

			pr("\t\t" + codetable[v] + "[shape=box];")
			pr("\t\t" + "n" + str(r) + " -> " + codetable[v] +";")
			r += 1
		else:
			pr("\t" + parent[v] + " -> " + v +";")

	pr("}")
	return "\n".join(s)

# freqs = histogram with chars and frequency
def huffmanCompress(freqs):
	Q = queue.PriorityQueue()
	# n logn
	for k in freqs:
		Q.put((freqs[k],k))

	tree = {}
	parent = {}
	k = 0
	while Q.qsize() > 1:
		first = Q.get()
		second = Q.get()

		# combine most freqeuent chars
		combined = (first[0] + second[0], "X" + str(k)) # (first[0] + second[0], first[1] + second[1])
		k += 1
		tree[first[1] ] = 0
		tree[second[1]] = 1
		parent[first[1]] = combined[1]
		parent[second[1]] = combined[1]

		#print(str(first) + " + " + str(second) + str(combined))
		Q.put(combined)
	ROOT = Q.get()

	#build up encoding/decoding table
	table = {}
	for k in freqs:
		code = str(tree.get(k,""))
		pNode = parent.get(k,None)
		while pNode != None:
			code += str(tree.get(pNode,""))
			pNode = parent.get(pNode,None)

		table[k] = code[::-1] # reverse code string

	dot = dotOutputCodeTable(table, parent, tree, ROOT)

	print("code table")
	for k in table:
		print(k + " -> " + table[k]) # table[k] should be not a string (better a binary vector or something similar, own datastruct needed)
	print("..")

	return (table, dot)
def huffmanDecode(filename, codetablefilename):
	s = ""
	codetablefile = open(codetablefilename, "rb")
	codetable = pickle.load(codetablefile)
	codetablefile.close()

	# build up decoding table
	for k in codetable:
		print(k + " -> " + codetable[k])

	f = open(filename,"r")

	f.close()
	return "not yet implemented"



def bufferToFile(buff, f):
	#f.write(buff)

	splittedBytes = [ buff[ 8*i : 8 * (i + 1) ] for i in range(0,len(buff) // 8) ]
	for b in splittedBytes:
		f.write( chr(int(b,2)))

def handleFile(filename):

	if not os.path.isfile(filename):
		print("file is not valid")
		return

	# extract frequencies
	freqs =  {}
	f = open(filename) # open file
	for line in f:
		for c in line:
			freqs[c] = freqs.get(c,0) + 1

	f.close()
	#print("frequencies of each char: " + str(freqs))

	(table, dot) = huffmanCompress(freqs)

	d = open(filename + "_dot.dot", "w")
	d.write(dot)
	d.close()

	f = open(filename) # open file
	s = open(filename +"_comp", "w")

	buff = ""
	for line in f:
		for c in line:
			buff += table[c]
		if (len(buff) % 8 == 0) :
			# write to bytesBuffer
			bufferToFile(buff, s)
			buff = ""

	#align buff with zeros
	buff += (8 - len(buff) % 8) * "0"
	bufferToFile(buff, s)

	s.close()
	f.close()

	#store code table to file
	codetable = open(filename + "_table", "wb")
	pickle.dump(table, codetable)
	codetable.close()


	# test open huffman coded file and decode
	s = huffmanDecode(filename + "_comp", filename + "_table")



def main(params):
	if len(params) != 1:
		print("need one file as parameter")
		exit(-1)

	# -d is the directory batch modus: handle all files with .txt in the current directory
	if params[0] == "-d":
		print("not yet implemented!")
		# batch mode
		#fileList = os.listdir(".")
		#fileList = [ f for f in fileList if not("_transformed" in f) and ".txt" in f ]
		#for f in fileList:
		#	print("processing of file: " + f, end="")
		#	handleFile(f)
		#	print(" ..done")

	else: # single file modus: just handle given filename
		handleFile(params[0])



if __name__ == "__main__":
    main(sys.argv[1:])
