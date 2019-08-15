clear
close all

cd samples
mylist=dir;

WindowSize=250;
reg=10;

cd ..

C = [];
for i=4:length(mylist)
    
    cd samples
    mysample=mylist(i).name;
    data=importdata(mysample);
    
    mysample=mysample(1:end-4);
    
    cd ..
    
    
    B =[];
    finalxclassvector=[];
    for variable=1:6
       A=[];
        x=data.data(:,variable+1);
        %index=find(x>65400);
        %x=x(index);
        
        mytime=data.data(:,1);
        %mytime=mytime(index);
        xclassvector=[];
        x_length=length(x);
        for i=1:x_length-WindowSize-reg-1
            xsmall=x(i:i+WindowSize);
            xclass = data.data(i+WindowSize+1,8);
            xclassvector = [xclassvector; xclass];
            [xt,yt]=buildreg(xsmall,reg,1);
            xt=xt(:,1:10:end);
            xt=[xt ones(length(xt),1)];
            As=xt\yt;
            As=As';
            A = [A;As]; %cmd_win A
        end
        B=[B A];
        variable;
        finalxclassvector = xclassvector;
    end
    B= [B finalxclassvector];
    
    C = [C; B];
    
    
end
csvwrite('all_DR_WS10000_Reg150.csv',C);
