#include <string>
#include <iostream>
#include <list>
#include <random>
#include <ctime>
using namespace std;
#include "person.h"

    int main()
{
    list<person>pop;
    list<person>::iterator pitr;
    person * pptr;
    int age;
    int fid = 100;
    int fsize;
    int pcount;
    int Num = 1000;
    int Old;
    int kount=0;
    int numg;
    int x;
    double res;

    default_random_engine Gen(time(NULL));
    ///Adist is athe age distribution
    uniform_int_distribution<int> OldDist(0,100);
    uniform_int_distribution<int> Adist(1,65);
    ///Sdist the size of the family group
    uniform_int_distribution<int> Sdist(1,7);
    ///Gdist is the number of additional groups each belongs
    uniform_int_distribution<int> Gdist(2,4);
    ///generic mixing groups non-work/school/family/hosp
    uniform_int_distribution<int> MGdist(2000,2050);
    ///Edist returns a value greater than 0 but
    ///with 3.5 terminating at 1.0-ish
    exponential_distribution<double>Edist(3.0);
    ///days after exposure  mean = 11.48, std div = 2.0
    normal_distribution<double> DAEdist(11.48, 1.5);
    //The resistance value mean = 1.0, std div = 0.15
    normal_distribution<double> REdist(1.0, 0.15);
    ///days after fever when death may occur
    uniform_int_distribution<int> DDAdist(7,14);
    int dae=0;
    int daefail=0;
    int dda=0;
    for(int i=10000; i<Num+10000; i++)
    {
       pptr=new person(i);
       dae = DAEdist(Gen);
       dda = OldDist(Gen);
       res = REdist(Gen);
       if(dda<31){dda = DDAdist(Gen);}
       else{dda=99;  }///means they dont
                     ///die in first 7/14 days after fever
       if((dae<7)||(dae>15)){daefail++;}
       pptr->setExDays(dae);
       pptr->setResistance(res);
       pptr->setDDAfter(dda);
       dda=0;
       pop.push_back(*pptr);
    }
    pitr=pop.begin();

    while(kount<Num)
    {
        fsize=Sdist(Gen);
        for(int j=0; j<fsize; j++)
        {   Old = OldDist(Gen);
            if(Old>9)
            {
            age = Adist(Gen);
            while((j==0)&&(age<18))
            {
            age = Adist(Gen);
            }
            }
            else{
               age = 65+int(Edist(Gen)*35);
            }
        pitr->setFid(fid);
        pitr->setAge(age,&Gen);


        numg=Gdist(Gen);
        for(int k=0; k<numg; k++)
        {
           x = MGdist(Gen);
           pitr->add2mxg(x);
        }
        pitr->mxguniq();
        pitr->display();
        kount++;
        pitr++;
        if(pitr==pop.end()){j=fsize; kount=Num;}
        }
      fid++;
    }
    cout<<daefail<<endl;
    return 0;


}
