function [ans] = CALSCORE(POS_X,POS_Y,z)
    lamda_1=1;
    lamda_2=1;
    lamda_3=1;

    before_X=POS_X-1;
    before_Y=POS_Y-1;
    after_X=POS_X+1;
    after_Y=POS_Y+1;
    %��ǰ��ĸ߶�
    H=z(30*POS_X+POS_Y+1);
    %��before��before�����ĸ߶�
    H_behind=z(30*before_X+before_Y+1);
    %��after��after��ǰ��ĸ߶�
    H_forward=z(30*after_X+after_Y+1);
    %��before��after�����ĸ߶�
    H_left=z(30*before_X+after_Y+1);
    %��after��before���ҵ�ĸ߶�
    H_right=z(30*after_X+before_Y+1); 
%     %��ǰ��ĸ߶�
%     H_left_forward=0.5*(H_left+H_forward);
%     %��ǰ��ĸ߶�
%     H_right_forward=0.5*(H_right+H_forward);
%     %����ĸ߶�
%     H_left_behind=0.5*(H_left+H_behind);
%     %�Һ��ĸ߶�
%     H_right_behind=0.5*(H_right+H_behind);
    %����ǰ-�����¶�
    SLOPE_forward_behind=atan((H_forward-H_behind)/(2*sqrt(2)));
    %������-�ҷ����¶�
    SLOPE_left_right=atan((H_left-H_right)/(2*sqrt(2)));   
    %�¶Ⱦ�ֵ
    SLOPE_average=0.5*(SLOPE_forward_behind+SLOPE_left_right);
    %�߶Ⱦ�ֵ
    H_average=0.25*(H_behind+H_forward+H_left+H_right);    
    %�¶ȱ�׼��
    SLOPE_sigma=sqrt(0.5*((SLOPE_average-SLOPE_forward_behind)^2+(SLOPE_average-SLOPE_left_right)^2));    
    %�¶Ⱦ�ֵƽ��
    SLOPE_square=SLOPE_average^2;    
    %�߶���߶Ⱦ�ֵ֮��
    H_offset=abs(H-H_average);    
    %���յ÷�
    ans=lamda_1*SLOPE_sigma+lamda_2*SLOPE_square+lamda_3*H_offset;
    if H>=0.15
        ans=1;
    end
end
      
%     SCORE(cnt,1)=score;   
%     if(score==0)
%         plot3(cnt,cnt,z(30*cnt+cnt+1),'r.','markersize',60);
%     else
%         plot3(cnt,cnt,z(30*cnt+cnt+1),'g.','markersize',60);
%     end
% end