// simple brainfuck to c++ "compiler" without error handling

// tidy up kann entfernt werden
#include <iostream>
#include <fstream>
#include <cstdio>
#include <vector>

using namespace std;

string readFile(string filename) {
	ifstream myfile;
	myfile.open(filename.c_str());
	string res="";
	string line;
	while (myfile.good()) {
      getline (myfile,line);
      res+=line;
    }
	myfile.close();
	return res;
}

void writeFile(const string& filename, const string &c) {
	ofstream myfile;
	myfile.open (filename.c_str());
	myfile << c;
	myfile.close();
}
/*
 * brainfuck syntax ref:  , . > < [ ] + -
 */
string tidyUp(const string& brain){
	string res = "";
	string tmp = "";
	for(int i = 0; i < brain.length(); i++) {
		tmp = brain[i];
		if(tmp == "," || tmp == "." || tmp == ">" || tmp == "<" || tmp == "[" || tmp == "]" || tmp == "+" || tmp == "-" ) {
			res += tmp;
		}
	}

	return res;
}

string leadingSpaces(int s){
	string res = "";
	for(int i = 0; i < s; i++) {
		res += " ";
	}
	return res;
}

string brainToCPP(const string& brain){
	string prog = "";
	int space = 3;
	for(int i = 0; i < brain.length(); i++) {

		switch(brain[i]) {
		 case ',':
			prog += leadingSpaces(space) + "memory[pos] = getchar();\n";
			break;
		 case '.':
			prog += leadingSpaces(space) + "cout << (char)memory[pos];\n";
			break;
		 case '[':
			prog += leadingSpaces(space) + "while (memory[pos] != 0) {\n";
			space *= 2;
			break;
		 case ']':
			space /= 2;
			prog += leadingSpaces(space) + "};\n";
		 	break;
		 case '>':
			prog += leadingSpaces(space) + "pos++; memory.push_back(0);\n";
		 	break;
		 case '<':
			prog += leadingSpaces(space) + "pos--;\n";
		 	break;
		 case '+':
			prog += leadingSpaces(space) + "memory[pos]++;\n";
		 	break;
		 case '-':
			prog+=leadingSpaces(space) + "memory[pos]--;\n";
		 	break;
		}

	}

	return "#include <iostream> \n#include <cstdio>\n#include <vector> \nusing namespace std; \n\nint main(){\n   vector<int> memory(1);\n   int pos = 0;\n   memory.push_back(0);\n" + prog + "\n   return 0;\n}\n"	;
}

int main(int argc, char* argv[]){
	cout << "Brainfuck to C++ compiler" << endl;

	if(argc != 3) {
		cout << "Error: \n usage: " << argv[0] << " brain.b output.c" << endl;
		return -1;
	}

	string filename = argv[1];

	cout << "processing file:" << filename << endl;
	string brain = tidyUp(readFile(filename));
	cout << brain << endl;
	cout << "generated code:" << endl;
	brain = brainToCPP(brain);
	cout << brain << endl;
	filename = argv[2];
	cout << "write to file:" << filename << endl;
	writeFile(filename, brain);
	return 0;
}
