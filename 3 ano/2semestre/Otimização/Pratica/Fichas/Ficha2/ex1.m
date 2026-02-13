[w1,w2]=meshgrid(-5:0.01:5,-5:0.1:5);

f=w1.^3+2*w1.*w2.^2-w2.^3-20*w1;

figure;hold on; box on;

contour(w1,w2,f,100,'LineWidth',1.2);

plot([-5 5],[0 0],'k--','LineWidth',1);%eixo x
plot([0 0],[-5 5],'k--','LineWidth',1);%eixo y  

plot(2.580,0,'ko','MarkerFaceColor','k','MarkerSize',5);
plot(-2.580,0,'ko','MarkerFaceColor','k','MarkerSize',5);