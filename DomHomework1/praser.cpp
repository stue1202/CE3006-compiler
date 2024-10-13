#include<iostream>
#include<regex>
#include<vector>
#include<queue>
using namespace std; 
int stmtbase=0;
bool err=false;
queue<string> k;
smatch result;
const regex regexID("[A-Za-z_][A-Za-z0-9_]*");
const regex regexSTRLIT("\"[^\"]*\"");           
const regex regexLBR("\\(");                       
const regex regexRBR("\\)");                       
const regex regexDOT("\\.");  
bool stmt(vector<string>& ,int);
bool is_sign(string i,string mode){
    return (i=="DOT"|| i=="ID"||i=="LBR"||i=="RBR"||i=="STRLIT");
}  
bool peek(vector<string> &v,int base,string mode){
	if(is_sign(v[base],mode)){
    	//cout<<v[base]<<endl;
        return true;
    }
    return false;
}                  
bool LBR(vector<string> &v,int base){
    //cout<<"in LBR"<<endl;
    if(base>=v.size()){
        return false;
    }
    if(v[base]=="LBR"){
    	stmtbase=base+1;
        return true;
    }
    return false;
}
bool RBR(vector<string> &v,int base){
    //cout<<"in RBR:"<<base<<endl;
	//stmtbase=base+1;
    if(base>=v.size()){
        return false;
    }
    //cout<<v[base]<<" "<<base<<endl;
    if(v[base]=="RBR"){
    	stmtbase=base+1;
        return true;
    }
    return false;
}
bool STRLIT(vector<string> &v,int base){
	//cout<<"in STRLIT"<<stmtbase<<endl;
    if(base>=v.size()){
        return false;
    }
    if(v[base]=="STRLIT"){
    	stmtbase=base+1;
        return true;
    }
    return false;
}
bool ID(vector<string> &v,int base){
    //stmtbase=base+1;
    //cout<<"in ID"<<stmtbase<<endl;
    if(base>=v.size()){
        return false;
    }
    if(v[base]=="ID"){
    	stmtbase=base+1;
        return true;
    } 
    
    return false; 
}
bool DOT(vector<string> &v,int base){
    //stmtbase=base+1; 
    //cout<<"in DOT"<<endl;
    if(base>=v.size()){
        return false;
    }
    if(v[base]=="DOT"){
    	stmtbase=base+1;
        return true;
    }
    return false;
}
bool primary_tail(vector<string> &v,int base){
   //cout<<"in tail:"<<stmtbase<<endl;

    if(base>=v.size()){//empty
        return true;
    }
    else if(DOT(v,base)&&ID(v,stmtbase)&&primary_tail(v,stmtbase)){//patten1
        return true;
    }else if(LBR(v,base)&&stmt(v,stmtbase)&&RBR(v,stmtbase)&&primary_tail(v,stmtbase)){//patten2
		return true;
    }else if(peek(v,base,"primary_tail")){//empty
    	//cout<<"peek"<<endl;
        return true;
    }
    return false;
}
bool primary(vector<string> &v,int base){
    //cout<<"in prime"<<stmtbase<<endl;
    if(base>=v.size()){
        return false;
    }else if(ID(v,base)&&primary_tail(v,stmtbase)){
        return true;
    }
    return false;
}
bool stmt(vector<string> &v,int base){
	//cout<<"in stmt"<<stmtbase<<endl;
    if(base>=v.size()){
    	stmtbase=base;
        return true;
    }
    if(primary(v,base)){
        return true;
    }else if(STRLIT(v,base)){
        return true;       
    }else if(peek(v,base,"stmt")){
    	//cout<<"A"<<endl;
        return true;
    }
    //cout<<"B"<<endl;
    return false;
}
bool stmts(vector<string> &v){
	//cout<<"in stmts"<<endl;
    if(stmtbase>=v.size()){
        return true;
    }
    //cout<<v[stmtbase]<<endl;
    if(v[stmtbase]=="STRLIT"||v[stmtbase]=="ID"){
		if(stmt(v,stmtbase)&&stmts(v)){
            return true;
        }
    }
    //cout<<"false"<<endl;
    return false;
}
vector<string> transfer(string input) {
    vector<string> q;
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
            }else{
                err=true;
                break;
			}
    }
    return q;
}
int main() {
    string input,all;
	int pointer=0;
	while(getline(cin,input,'\n')){
		all+=input;
	}
    vector<string> ans;
    ans=transfer(all); 
    if(!err&&stmts(ans)){
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
        	}
    	}
	}else{
        	cout<<"invalid input"<<endl;
    }
}




