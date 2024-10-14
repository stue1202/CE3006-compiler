#include <iostream>
#include <vector>
#include <regex> 
#include <queue>
//PHONENUM(10字)、YEAR(4字)、NATIONNUM(3字)、DAY(2字)順序很重要 
//數字不會撞車是因為題目有刻意設計
using namespace std;

const regex regexID("^[A-Z]\\d{9}");
const regex regexNATIONNUM("\\d{3}");
const regex regexPHONENUM("9[0-9]{8}");
const regex regexYEAR("^[12]\\d{3}");
const regex regexMONTH("(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)");
const regex regexDAY("^[1-9]|[12]\\d|3[01]");
const regex regexPLUS("\\+");
const regex regexSLASH("\\/");           
const regex regexLBR("\\(");                       
const regex regexRBR("\\)");                       
const regex regexDOT("\\.");

int nowbase=0;
bool err=false;
queue<string> k;
smatch result;

bool stmt(vector<string> &,int);
bool phone(vector<string> &,int);
bool primary(vector<string> &,int);
bool date(vector<string> &,int);
bool ID(vector<string> &,int);
bool NATIONNUM(vector<string> &,int);
bool PHONENUM(vector<string> &,int);
bool YEAR(vector<string> &,int);
bool MONTH(vector<string> &,int);
bool DAY(vector<string> &,int);
bool PLUS(vector<string> &,int);
bool DOT(vector<string> &,int);
bool LBR(vector<string> &,int);
bool RBR(vector<string> &,int);
bool SLASH(vector<string> &,int);
bool END(vector<string> &,int);
bool any(vector<string> &,int);


bool OutOfRange(vector<string> &v,int base){//outOfR  ange
	if(v.size()<=base){
		return true;
	}
	return false;
}
bool stmt(vector<string> &v,int base){
	cout<<"in stmt"<<endl;
	if(OutOfRange(v,base)){
		return false;
	}
	if(ID(v,base)&&END(v,nowbase)){
		return true;
	}else if(PLUS(v,base)){
		if(phone(v,base)&&END(v,nowbase)){
			return true;
		}
	}else if(MONTH(v,base)||YEAR(v,base)){
		if(date(v,base)&&END(v,nowbase)){
			return true;
		}
	}
	return false;
}
bool phone(vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(PLUS(v,base)&& LBR(v,nowbase)&& NATIONNUM(v,nowbase)&& RBR(v,nowbase)&& PHONENUM(v,nowbase)){
		return true;
	}
	return false;
}
bool date(vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(MONTH(v,base)&& DOT (v,nowbase)&&DAY(v,nowbase)&& DOT (v,nowbase)&&YEAR(v,nowbase)){
		return true;
	}else if(YEAR(v,base)&& SLASH(v,nowbase)&& MONTH(v,nowbase)&& SLASH (v,nowbase)&&DAY(v,nowbase)){
		return true;
	}
	return false;
}
bool ID (vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="ID"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool NATIONNUM (vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="NATIONNUM"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool PHONENUM (vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="PHONENUM"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool YEAR (vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="YEAR"){
				nowbase=base+1;

		return true;
	}
	return false;
}
bool MONTH (vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="MONTH"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool DAY (vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="DAY"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool PLUS (vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="PLUS"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool DOT (vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="DOT"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool LBR (vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="LBR"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool RBR (vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="RBR"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool SLASH (vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="SLASH"){
		nowbase=base+1;
		return true;
	}
	return false;
}
bool END(vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(v[base]=="EOF"){
		return true;
	}
	return false;
}

bool any(vector<string> &v,int base){
	if(OutOfRange(v,base)){
		return false;
	}
	if(END(v,base)){
		return false;
	}
	return true;
}
void toToken(vector<string> &q,string input){
    while(input.length()>0){
            if(input[0]==' '){
                input.erase(0,1);
            }else if(regex_search(input, result,regexID)&&input.find(result.str())==0) {
                q.push_back("ID");
                k.push(result.str());
                input.erase(0,result.str().length());
            }else if (regex_search(input,result,regexPHONENUM)&&input.find(result.str())==0) {
                q.push_back("PHONENUM");
                k.push(result.str());
                input.erase(0,result.str().length());
            }else if (regex_search(input,result,regexYEAR)&&input.find(result.str())==0) {
                q.push_back("YEAR");
                k.push(result.str());
                input.erase(0,result.str().length());
            }else if (regex_search(input,result,regexNATIONNUM)&&input.find(result.str())==0) {
                q.push_back("NATIONNUM");
                k.push(result.str());
                input.erase(0,result.str().length());
            }else if (regex_search(input,result,regexMONTH)&&input.find(result.str())==0) {
                q.push_back("MONTH");
                k.push(result.str());
                input.erase(0,result.str().length());
            }else if (regex_search(input,result,regexDAY)&&input.find(result.str())==0) {
                q.push_back("DAY");
                k.push(result.str());
                input.erase(0,result.str().length());
            }else if (regex_search(input,result,regexPLUS)&&input.find(result.str())==0) {
                q.push_back("PLUS");
                input.erase(0,result.str().length());
            }else if (regex_search(input,result,regexSLASH)&&input.find(result.str())==0) {
                q.push_back("SLASH");
                input.erase(0,result.str().length());
            }else if (regex_search(input,result,regexLBR)&&input.find(result.str())==0) {
                q.push_back("LBR");
                input.erase(0,result.str().length());
            }else if (regex_search(input,result,regexRBR)&&input.find(result.str())==0) {
                q.push_back("RBR");
                input.erase(0,result.str().length());
            }else if (regex_search(input,result,regexDOT)&&input.find(result.str())==0) {
                q.push_back("DOT");
                input.erase(0,result.str().length());
            }else{
                err=true;
                break;
			}
    }
	q.push_back("EOF");
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
	cout<<err;
    if(!err&&stmt(ans,0)){
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
			}else if(ans[i]=="NATIONNUM"){
				cout<<"NATIONNUM "<<k.front()<<endl;
				k.pop();
        	}else if(ans[i]=="PHONENUM"){
        		cout<<"PHONENUM "<<k.front()<<endl;
				k.pop();
			}else if(ans[i]=="YEAR"){
        		cout<<"YEAR "<<k.front()<<endl;
				k.pop();
			}else if(ans[i]=="MONTH"){
        		cout<<"MONTH "<<k.front()<<endl;
				k.pop();
			}else if(ans[i]=="DAY"){
        		cout<<"DAY "<<k.front()<<endl;
				k.pop();
			}else if(ans[i]=="PLUS"){
        		cout<<"PLUS +"<<endl;
			}else if(ans[i]=="SLASH"){
        		cout<<"SLASH /"<<endl;
			}
    	}
	}else{
        cout<<"invalid input"<<endl;
    }
}
