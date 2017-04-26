#include <iostream>
#include <ctime>
#include <cstdlib>

using namespace std;
int main()
{int n, num;
    srand(time(NULL));
    cout<<"enter number of groups"<<endl;
    cin>>n;
    cout<<"enter number of individuals"<<endl;
    cin>>num;
    cout<<"average business size: "<<double(num)/double(n)<<endl;
int r;
cout<<"generating work groups"<<endl;

int *gmembers = new int[n];
for(int  i=0; i<n; i++){gmembers[i]=0;}
for (int i=0; i<num; i++)
    {r=rand()%n;
    gmembers[r]++;
    }
for(int i=0; i<n; i++)
    cout<<"members of group "<<i<<" = "<<gmembers[i]<<endl;
cout<<"***********************"<<endl;
int V[4]; for(int i=0; i<4; i++){V[i]=0;}
for(int i=0; i<100; i++)
{
    r=rand()%100;
    if(r < 5){V[0]++;}
    else if (r<50){V[1]++;}
    else if (r<90){V[2]++;}
    else{V[3]++;}

}
cout<<"weighted distribution"<<endl;
for(int i=0; i<4; i++){cout<<V[i]<<endl;}
return 0;
}
