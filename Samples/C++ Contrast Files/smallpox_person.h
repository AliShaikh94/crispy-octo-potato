class person
{
public:
    person(){id = 0; age = 0; state[0] = 0; state[1]=0;
             for(int i=0; i<8; i++)groups[i]=0;}

    void init(int i)
        {
         id = i;
         age = rand()%80+1;
         if(age<5){groups[2]=1; /*preschool*/}
         else if(age<13){groups[2]=1; /*elementary*/}
         else if(age<15){groups[2]=2; /*middle school*/}
         else if(age<19){groups[2]=3; /*high school*/}
         else           { groups[1]=rand()%100;}
        }
    void display(){
                    cout<<"person id:"<<setw(5)<<id<<" age:"<<setw(5)<<age<<endl;
                    cout<<"    State: ";
                        switch(state[0]){
                        case 0: {cout<<"not exposed :"<<state[1]<<" day(s)"<<endl;}break;
                        case 1: {cout<<"exposed     :"<<state[1]<<" day(s)"<<endl;}break;
                        case 2: {cout<<"infected    :"<<state[1]<<" day(s)"<<endl;}break;
                        case 3: {cout<<"infectious  :"<<state[1]<<" day(s)"<<endl;}break;
                        case 4: {cout<<"diagnosed   :"<<state[1]<<" day(s)"<<endl;}break;
                        }
                    cout<<"member groups"<<endl;
                    cout<<"family group: "<<groups[0]<<endl;

                    if(groups[1]!=0){cout<<"work group:   "<<groups[1]<<endl;}
                    if(groups[2]!=0){cout<<"school group: "<<groups[2]<<endl;}
                                    cout<<"neighborhood: "<<groups[3]<<endl;
                    for(int i=4; i<8; i++){if(groups[i]!=0)
                                                {cout<<"social group: "<<groups[i]<<endl;}
                                          }
                    cout<<"--------------------------"<<endl;
                    }
    void setneighborhood(int i){groups[3]=i;}
    int getwork(){return groups[1];}
    void exposed(){state[0]=1; state[1]=0;
    }
    int getstate(){return state[0];}
private:
    int id;
    int age;
    int state[2];  /*state[0] = state,
                state[1] = days in state*/
    int groups[8];
        /* group [0] = family num
            group [1] = work
             group [2] = school
              group [3] = neighborhood
               group [4] = social 1
                group [5] = social 2
                groups [6] = social 3 only for non workers
                 groups [7] = social 4 only for non workers*/
};
