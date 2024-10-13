#include<iostream>
#include<queue>
using namespace std; 
void CheckQueue(queue<char> &q){
	if(!q.empty()){
		cout<<"NUM ";
		while(!q.empty()){
			cout<<q.front();
			q.pop();
		}
		cout<<endl;
	}
}
int main(){
	string input,all;
	queue<char> q;
	int pointer=0;
	while(getline(cin,input,'\n')){
		all+=input;
	}
	while(pointer<all.length()){
		//cout<<pointer<<endl;
		if(all[pointer]=='('){
			CheckQueue(q);
			cout<<"LPR"<<endl;
		}else if(all[pointer]==')'){
			CheckQueue(q);
			cout<<"RPR"<<endl;
		}else if(all[pointer]=='+'){
			CheckQueue(q);
			cout<<"PLUS"<<endl;
		}else if(all[pointer]=='-'){
			CheckQueue(q);
			cout<<"MINUS"<<endl;
		}else if(all[pointer]=='/'){
			CheckQueue(q);
			cout<<"DIV"<<endl;
		}else if(all[pointer]=='*'){
			CheckQueue(q);
			cout<<"MUL"<<endl;
		}else if(all[pointer]!=' '){//number
			q.push(all[pointer]);
		}
		pointer++;
	}
	CheckQueue(q);
} 
