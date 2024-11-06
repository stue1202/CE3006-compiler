#include <iostream>
#include <vector>
#include <sstream>
#include <cctype>
#include <map>
#include <set>
using namespace std;
map<char,set<char>> DP;
map<char,vector<string>> inputData;
std::vector<std::string> split(const std::string& str, char delim) {
    std::vector<std::string> tokens;
    std::stringstream ss(str);
    std::string token;
    while (std::getline(ss, token, delim)) {
        tokens.push_back(token);
    }
    return tokens;
}
void _union(set<char> &a,set<char> &b){
    for (char x : b) {
        a.insert(x);
    }
}
set<char> first(char c){
    if(!isupper(c)){
        return {c};
    }else if(!DP[c].empty()){//DP
        return DP[c];
    }
    set<char> rhsAnwser;
    bool semi=false;
    for(int i=0;i<inputData[c].size();i++){//iterating every RHS grammer
        string targetStr=inputData[c][i];
        for(int j=0;j<targetStr.length();j++){//iterating one of RHS grammer
            set<char> a=first(targetStr[j]);
            _union(rhsAnwser,a);
            if(a.count(';')==0){//last detect and have ';'
                break;
            }
            if(a.count(';')&&j==targetStr.length()-1){
                semi=true;
            }
        }
    }
    if(semi){
        rhsAnwser.insert(';');
    }else{
        rhsAnwser.erase(';');
    }
    DP[c]=rhsAnwser;
    return rhsAnwser;

}
int main(){
    string LHS,ans,tmp;
    vector<string> RHS;
    while(1){//get input
        cin>>LHS;
        if(LHS=="END_OF_GRAMMAR"){
            break;
        }
        cin>>tmp;
        RHS=split(tmp,'|');
        inputData[LHS[0]]=RHS;
    }
    for (auto it = inputData.begin(); it != inputData.end(); ++it) {//iterating LHS
        first(it->first);
    }
    for (auto it = DP.begin(); it != DP.end(); ++it) {//iterating LHS
        cout<<it->first<<" ";
        for(char c:it->second){
            cout<<c;
        }
        cout<<endl;
    }
    cout<<"END_OF_FIRST"<<endl;
    return 0;
}