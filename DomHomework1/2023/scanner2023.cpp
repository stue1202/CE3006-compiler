#include<iostream>
#include<regex>
#include<vector>
#include<queue>
#include<set>
using namespace std; 
set<char> digital{'0','1','2','3','4','5','6','7','8','9'};
set<char> upperalpha{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
set<char> loweralpha{'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
set<char> symbol{'+','-','*','=','(',')','\{','}','<','>',';'};
set<string> keywords{"if","else","while"};
string cat(string s,char c){
	s+=' ';
	s+=c;
	return s; 
}
void toToken(vector<string> &v,string input){
    while(input.length()>0){
        if(input[0] == ' '){//space
            input.erase(0,1);
        }
        else if(upperalpha.count(input[0])||loweralpha.count(input[0])){//ID or KEYWORDS
        	string strID="";
        	while(upperalpha.count(input[0])||loweralpha.count(input[0])||digital.count(input[0])){
        		strID+=input[0];
				input.erase(0,1);
			}
			cout<<strID<<endl;
			if(keywords.count(strID)){
				v.push_back("KEYWORDS "+strID);
			}else{
				v.push_back("ID "+strID);
			}  
        }else if(digital.count(input[0])){//NUM
        	if(input[0]=='0'){
        		v.push_back(cat("NUM",input[0]));
        		input.erase(0,1);
			}else{
				string strNUM="";
	        	while(digital.count(input[0])){
	        		strNUM+=input[0];
					input.erase(0,1);
				}
				cout<<strNUM<<endl;
	            v.push_back("NUM "+strNUM);
			}
        }else if(symbol.count(input[0])){//SYMBOL
        	v.push_back(cat("SYMBOL",input[0]));
        	cout<<input[0]<<endl;
            input.erase(0,1);
		}else{//Invalid
			v.push_back("Invalid");
			cout<<input[0]<<endl;
            input.erase(0,1);
		}
    }
}
void print(vector<string> &v){
	cout<<"start"<<endl; 
	for(int i=0;i<v.size();i++){
		cout<<v[i]<<endl;
	}
}
int main(){
	string input,all;
	while(getline(cin,input,'\n')){
		all+=input;
	}
    vector<string> ans;
	toToken(ans,all);
	print(ans);
}

