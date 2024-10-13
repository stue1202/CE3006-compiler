#include <iostream>
#include <vector>
#include <regex> 
#include <queue>

using namespace std;
const regex regexID("[A-Za-z_][A-Za-z0-9_]*");
const regex regexSTRLIT("\"[^\"]*\"");           
const regex regexLBR("\\(");                       
const regex regexRBR("\\)");                       
const regex regexDOT("\\.");
const regex regexSEMICOLON(";");
int nowbase=0;
bool err=false;
queue<string> k;
smatch result;

bool stmts(vector<string> &,int);
bool stmt(vector<string> &,int);
bool exp(vector<string> &,int);
bool primary(vector<string> &,int);
bool primary_tail(vector<string> &,int);
bool SEMICOLON(vector<string> &,int);
bool ID(vector<string> &,int);
bool STRLIT(vector<string> &,int);
bool LBR(vector<string> &,int);
bool RBR(vector<string> &,int);
bool DOT(vector<string> &,int);
bool END(vector<string> &,int);
bool any(vector<string> &,int);


bool checkrange(vector<string> &v,int base){//outOfR  ange
	if(v.size()<=base){
		return true;
	}
	return false;
}
bool stmts(vector<string> &v,int base){
	cout<<"in stmts"<<endl;
	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
	if(STRLIT(v,base)||ID(v,base)){
		if(stmt(v,base)&&stmts(v,nowbase)){
			return true;
		}
	}else if(END(v,base)){
		return true;
	}
	return false;
}
bool stmt(vector<string> &v,int base){
				cout<<"in stmt"<<endl;

	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
	if(STRLIT(v,base)||ID(v,base)){
		if(exp(v,base)&&SEMICOLON(v,nowbase)){
			return true;
		}
	}else if(any(v,base)){
		return true;
	}
	return false;
}
bool exp(vector<string> &v,int base){
	cout<<"in exp"<<endl;
	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
	if(ID(v,base)){
		if(primary(v,base)){
			return true;
		}
	}else if(STRLIT(v,base)){
		return true;
	}else if(any(v,base)){
		return true;
	}
	return false;
}
bool primary(vector<string> &v,int base){
	cout<<"in primary"<<endl;
	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
	if(ID(v,base)&&primary_tail(v,nowbase)){
		return true;
	}
	return false;
}
bool primary_tail(vector<string> &v,int base){
	cout<<"in primary_tail"<<endl;
	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
	if(DOT(v,base)&&ID(v,nowbase)&& primary_tail(v,nowbase)){
		return true;
	}else if(LBR(v,base)&& exp(v,nowbase)&& RBR(v,nowbase)&& primary_tail(v,nowbase)){
		return true;
	}else if(any(v,base)){
		return true;
	}
	return false;
}
bool ID(vector<string> &v,int base){
		cout<<"in ID"<<endl;

	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
	if(v[base]=="ID"){
		nowbase=base+1;
		return true;
	}
	return false;
	
}
bool STRLIT(vector<string> &v,int base){
		cout<<"in STRLIT"<<endl;

	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
		if(v[base]=="STRLIT"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool LBR(vector<string> &v,int base){
			cout<<"in LBR"<<endl;

	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
		if(v[base]=="LBR"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool END(vector<string> &v,int base){
				cout<<"in END"<<endl;

	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
	if(v[base]=="EOF"){
		return true;
	}
	return false;
}
bool RBR(vector<string> &v,int base){
				cout<<"in RBR"<<endl;

	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
		if(v[base]=="RBR"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool DOT(vector<string> &v,int base){
				cout<<"in DOT"<<endl;

	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
		if(v[base]=="DOT"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool SEMICOLON(vector<string> &v,int base){
				cout<<"in SEMI"<<endl;

	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
		if(v[base]=="SEMICOLON"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool any(vector<string> &v,int base){
				cout<<"in any"<<endl;

	if(checkrange(v,base)){
		return false;
	}
	cout<<v[base]<<endl;
	if(END(v,base)){
		return false;
	}
	return true;

}
void toToken(vector<string> &q,string input){
    while(input.length()>0){
            if(input[0]==' '){
                input.erase(0,1);
            }
            else if(regex_search(input, result,regexID)&&input.find(result.str())==0) {
                q.push_back("ID");
                k.push(result.str());
                input.erase(0,result.str().length());
            }
            else if (regex_search(input,result,regexSTRLIT)&&input.find(result.str())==0) {
                q.push_back("STRLIT");
                k.push(result.str());
                input.erase(0,result.str().length());
            }
            else if (regex_search(input,result,regexLBR)&&input.find(result.str())==0) {
                q.push_back("LBR");
                input.erase(0,result.str().length());
            }
            else if (regex_search(input,result,regexRBR)&&input.find(result.str())==0) {
                q.push_back("RBR");
                input.erase(0,result.str().length());
            }
            else if (regex_search(input,result,regexDOT)&&input.find(result.str())==0) {
                q.push_back("DOT");
                input.erase(0,result.str().length());
            }else if(regex_search(input,result,regexSEMICOLON)&&input.find(result.str())==0){
            	q.push_back("SEMICOLON");
                input.erase(0,result.str().length());
			}else{
                err=true;
                break;
			}
    }
	q.push_back("EOF");
}
void print(vector<string> &v){
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
	cout<<err;
    if(!err&&stmts(ans,0)){
    		cout<<"start"<<endl; 

        for(int i=0;i<ans.size();i++){
        	if(ans[i]=="DOT"){
        		cout<<"DOT ."<<endl;
			}else if(ans[i]=="RBR"){
				cout<<"RBR )"<<endl;
			}else if(ans[i]=="LBR"){
				cout<<"LBR ("<<endl;
			}else if(ans[i]=="ID"){
				cout<<"ID "<<k.front()<<endl;
				k.pop();
			}else if(ans[i]=="STRLIT"){
				cout<<"STRLIT "<<k.front()<<endl;
				k.pop();
        	}else if(ans[i]=="SEMICOLON"){
        		cout<<"SEMICOLON ;"<<endl;
			}
    	}
	}else{
        cout<<"invalid input"<<endl;
    }
}
