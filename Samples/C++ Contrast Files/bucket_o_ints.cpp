#include <iostream>
#include <fstream>
#include <cstdlib>
#include <ctime>
#include <list>
using namespace std;

int main()
{
srand(time(NULL));

fstream fout;
fout.open("outdata.txt",ios::out);

list<int> my_ints;
list<int>::iterator myitr;

int r;
for(int i=0; i<20; i++)
{r = rand()%100+1;
my_ints.push_back(r);
}
string temp;
myitr=my_ints.begin();
int j=0;
while(myitr!= my_ints.end())
    {
    j=rand()%8+1;
    fout<<"group("<<j<<","<<*myitr<<")."<<endl;
    myitr++;
   }
fout<<endl;
cout<<"done"<<endl;

return 0;}
