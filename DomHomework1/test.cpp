#include<iostream>
using namespace std;
void toSet(int start,int end){
	for(int i=start;i<=end;i++){
		cout<<"\'"<<char(i)<<"\',";
	}
	cout<<endl;
	
}
int main(){
	toSet(48,57);
		toSet(65,90);
			toSet(97,122);
	
}
