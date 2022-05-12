%%
close all;
clear all;
clc;

%%
%��ȡ����
x=xlsread('Data.xlsx','Sheet1','A1:A900');
y=xlsread('Data.xlsx','Sheet1','B1:B900');
z=xlsread('Data.xlsx','Sheet1','C1:C900');

SCORE=zeros(28,1);
xmax=max(x);
xmin=min(x);
ymax=max(y);
ymin=min(y);
[X,Y]=meshgrid(xmin:1:xmax,ymin:1:ymax);
Z=griddata(x,y,z,X,Y,'v4');

%%
%�������
STEP_RANGE=4*sqrt(2);%ÿһ����ǰ����������
STEP_RANGE_XY=STEP_RANGE/sqrt(2);%ÿһ����ǰ������������x��y�����ϵķ���
FLG_ARRIVE_END=0;%�����˵����յ�ı�־λ������ʱ��1
FLG_AT_START=1;%�����˴������ı�־λ���뿪���ʱ��0
VISION_RANGE=8*sqrt(2);%��֪����̽�⵽����Զ����
VISION_RANGE_XY=VISION_RANGE/sqrt(2);%��֪����̽�⵽����Զ������x��y�����ϵķ���
FOOTHOLD_NOW_X=3;%��ǰ����ŵص��X����
FOOTHOLD_NOW_Y=3;%��ǰ����ŵص��Y����
SCORE_TEMP=zeros(41,3);%�洢��ǰһ����ǰ���������������е�ĵ÷�ֵ�Լ�����

%%
%���Ƶ�ͼ
figure(1)
mesh(X,Y,Z);
%surf(X,Y,Z);
axis([0 29 0 29 0 1]);
shading interp ;
%colormap(gray);
colorbar;
hold on;
%�������
plot3(FOOTHOLD_NOW_X,FOOTHOLD_NOW_Y,z(30*FOOTHOLD_NOW_X+FOOTHOLD_NOW_Y+1),'k.','markersize',50);


%%
%�����Ȳ���ڷ�Χ
for i=0:24
    plot3([i,i+1],[i+4,i+5],[z(30*i+i+4+1),z(30*(i+1)+i+5+1)],'r','LineWidth',2);
    plot3([i+4,i+5],[i,i+1],[z(30*(i+4)+i+1),z(30*(i+5)+i+1+1)],'r','LineWidth',2);
end
hold on;

%%
%��������
while FLG_ARRIVE_END <= 5
        %�����Ȳ��ɵ��ﷶΧ
        plot3([FOOTHOLD_NOW_X+2,FOOTHOLD_NOW_X+3,FOOTHOLD_NOW_X+4,FOOTHOLD_NOW_X+5,FOOTHOLD_NOW_X+6, ...
               FOOTHOLD_NOW_X+5,FOOTHOLD_NOW_X+4,FOOTHOLD_NOW_X+3,FOOTHOLD_NOW_X+2,FOOTHOLD_NOW_X+1, ...
               FOOTHOLD_NOW_X , FOOTHOLD_NOW_X-1,FOOTHOLD_NOW_X-2,FOOTHOLD_NOW_X-1,FOOTHOLD_NOW_X, ...
               FOOTHOLD_NOW_X+1,FOOTHOLD_NOW_X+2], ...
              [FOOTHOLD_NOW_Y-2,FOOTHOLD_NOW_Y-1,FOOTHOLD_NOW_Y,FOOTHOLD_NOW_Y+1,FOOTHOLD_NOW_Y+2, ...
               FOOTHOLD_NOW_Y+3,FOOTHOLD_NOW_Y+4,FOOTHOLD_NOW_Y+5,FOOTHOLD_NOW_Y+6,FOOTHOLD_NOW_Y+5, ...
               FOOTHOLD_NOW_Y+4,FOOTHOLD_NOW_Y+3,FOOTHOLD_NOW_Y+2,FOOTHOLD_NOW_Y+1,FOOTHOLD_NOW_Y, ...
               FOOTHOLD_NOW_Y-1,FOOTHOLD_NOW_Y-2], ...
              [z(30*(FOOTHOLD_NOW_X+2)+FOOTHOLD_NOW_Y-2+1),z(30*(FOOTHOLD_NOW_X+3)+FOOTHOLD_NOW_Y-1+1),z(30*(FOOTHOLD_NOW_X+4)+FOOTHOLD_NOW_Y+1),z(30*(FOOTHOLD_NOW_X+5)+FOOTHOLD_NOW_Y+1+1),z(30*(FOOTHOLD_NOW_X+6)+FOOTHOLD_NOW_Y+2+1), ...
               z(30*(FOOTHOLD_NOW_X+5)+FOOTHOLD_NOW_Y+3+1),z(30*(FOOTHOLD_NOW_X+4)+FOOTHOLD_NOW_Y+4+1),z(30*(FOOTHOLD_NOW_X+3)+FOOTHOLD_NOW_Y+5+1),z(30*(FOOTHOLD_NOW_X+2)+FOOTHOLD_NOW_Y+6+1),z(30*(FOOTHOLD_NOW_X+1)+FOOTHOLD_NOW_Y+5+1), ...
               z(30*(FOOTHOLD_NOW_X)+FOOTHOLD_NOW_Y+4+1)  ,z(30*(FOOTHOLD_NOW_X-1)+FOOTHOLD_NOW_Y+3+1),z(30*(FOOTHOLD_NOW_X-2)+FOOTHOLD_NOW_Y+2+1),z(30*(FOOTHOLD_NOW_X-1)+FOOTHOLD_NOW_Y+1+1),z(30*(FOOTHOLD_NOW_X)+FOOTHOLD_NOW_Y+1), ...
               z(30*(FOOTHOLD_NOW_X+1)+FOOTHOLD_NOW_Y-1+1),z(30*(FOOTHOLD_NOW_X+2)+FOOTHOLD_NOW_Y-2+1)],'g','LineWidth',2);
        hold on;
        pause(2);
            %���㵱ǰ����ĵ��λ������͵÷�
            for c=0:4
                for b=1:5
                    x_temp=FOOTHOLD_NOW_X-3+b+c;
                    y_temp=FOOTHOLD_NOW_Y+3-b+c;
                    score=CALSCORE(x_temp,y_temp,z);
                    SCORE_TEMP(5*c+b,1)=score;
                    SCORE_TEMP(5*c+b,2)=x_temp;
                    SCORE_TEMP(5*c+b,3)=y_temp;
                end
            end         
            for c=0:3
                for b=1:4
                    x_temp=FOOTHOLD_NOW_X-2+b+c;
                    y_temp=FOOTHOLD_NOW_Y+3-b+c;
                    score=CALSCORE(x_temp,y_temp,z);
                    SCORE_TEMP(25+4*c+b,1)=score;
                    SCORE_TEMP(25+4*c+b,2)=x_temp;
                    SCORE_TEMP(25+4*c+b,3)=y_temp;
                end
            end
            %���Ƶ�
            for a=1:41
                if(SCORE_TEMP(a,1)==0)
                    plot3(SCORE_TEMP(a,2),SCORE_TEMP(a,3),z(30*SCORE_TEMP(a,2)+SCORE_TEMP(a,3)+1),'r.','markersize',30);
                else
                    plot3(SCORE_TEMP(a,2),SCORE_TEMP(a,3),z(30*SCORE_TEMP(a,2)+SCORE_TEMP(a,3)+1),'g.','markersize',30);
                end
            end
            
            %��ǰһ����ǰ�����������ڿ��е����Ŀ
            num=length(find(SCORE_TEMP(:,1)==0));
            feasible_point=zeros(num,4);
            feasible_point_index=1;
            for a=1:41
                if(SCORE_TEMP(a,1)==0)
                    feasible_point(feasible_point_index,1:3)=SCORE_TEMP(a,:);
                    feasible_point(feasible_point_index,4)=feasible_point(feasible_point_index,2)+feasible_point(feasible_point_index,3);
                    feasible_point_index=feasible_point_index+1;
                end
            end
            feasible_poin_sorted=sortrows(feasible_point,-4);
            %Ѱ�����Ž�(�Ż�ָ�꣺������Զ)
            maxrange=feasible_poin_sorted(1,4);
            num2=length(find(feasible_poin_sorted(:,4)==maxrange));
            optclass=zeros(num2,5);
            optclass(:,1:4)=feasible_poin_sorted(1:num2,:);
            for a=1:num2
                optclass(a,5)=abs(optclass(a,2)-optclass(a,3));
            end
            optclass_sorted=sortrows(optclass,5);           
            RESULT_X=optclass_sorted(1,2);
            RESULT_Y=optclass_sorted(1,3);
            pause(2);
            %�������Ž�
            plot3(RESULT_X,RESULT_Y,z(30*RESULT_X+RESULT_Y+1),'k.','markersize',50);
            %��˸���
            FOOTHOLD_NOW_X=0.5*(RESULT_X+RESULT_Y);
            FOOTHOLD_NOW_Y=0.5*(RESULT_X+RESULT_Y);
            FLG_ARRIVE_END=FLG_ARRIVE_END+1;
    %FLG_ARRIVE_END=1;
end

grid on;