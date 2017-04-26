#include <iostream>
#include <fstream>
#include <iomanip>
#include <cmath>
#include <ctime>
#include <list>
#include <cstdlib>
using namespace std;
#include "smallpox_person.h"

int main()
{
 srand(time(NULL));
 int tempi;
 person * pptr;
 list<person> community;
 list<person>::iterator pitr;
 cout<<"simulation for 100 individuals"<<endl;
 for(int n=0; n<4; n++)
    {
    for(int i=0; i<250; i++)
        {tempi= 250*n+i;
        pptr=new person;
        pptr->init(tempi);
        pptr->setneighborhood(n);
        community.push_back(*pptr);
        }
    }

pitr=community.begin();
while(pitr!=community.end())
    {
     if(pitr->getwork()==38){pitr->exposed();}
     pitr->display();
     pitr++;}
cout<<endl<<endl<<"Exposed work group sample#38"<<endl;
pitr=community.begin();
while(pitr!=community.end())
{
    if(pitr->getstate()==1){pitr->display();}
    pitr++;
}
return 0;
}
