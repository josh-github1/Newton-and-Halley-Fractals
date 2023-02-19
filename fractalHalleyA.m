% Joshua Ramayrat
% Nicholas
% Zachary

function fractalHalleyA(stepcount,xyrange)    
                                                           %Stepcount: resolution of grid size. 
                                                           %Xyrange:[xmin xmax ymin ymax] 
                                                           %for axis limits

iterationcount = 1000;                                     %Setting max # of 
                                                           %iterations to
                                                           %find zero.
complexroots = roots([1 -1 1 1 1]);                        %finds roots
polyDegree = length([1 -1 1 1 1])-1;
if polyDegree>6                                            %Prompts user to
    disp('Enter a 6 or less degree polynomial')            %enter lower degree 
    return;
end                                                        

if (nargin < 3)
    margin = 0.5;
    xlow =  min(real(complexroots));                       %It was asked to 
    xhigh = max(real(complexroots));                       %set the axis as 4 times
    ylow =  min(imag(complexroots));                       %as large as the largest zero
    yhigh = max(imag(complexroots));                       %of the polynomial.

    xmin = xlow*2;
    xmax = xhigh*2;
    ymin = ylow*2;
    ymax = yhigh*2;
else
    xmin = xyrange(1);
	xmax = xyrange(2);
	ymin = xyrange(3);
    ymax = xyrange(4);
end



x = linspace(xmin,xmax,stepcount);                           %Creating a grid of 
y = linspace(ymin,ymax,stepcount);                           %x and y values.

colours = 'rgbcmy';
colourcount = zeros(1,polyDegree);
colourrecord = zeros(polyDegree,stepcount^2);

for u = x
    for v = y
        Zk = u+v*i;
        z0 = Zk;
        err = 1;                                             %Initialize values.
        iterate = 0;                        
        while ((err > 10^(-6)) & (iterate<iterationcount))   %Comparing distances between
                                                             %iterations and zeros of polynomial.
    
            Zknew = Halley(p1(Zk), dp1(Zk), ddp1(Zk), Zk)
            err = abs(Zk-Zknew);                             %Newton's method and error calculation 
            iterate = iterate+1;                             %Repeat method until iterate = 1000.  
            Zk = Zknew;                                      %Setting value for next iterate.

        end
        if err <= 10^(-6)                                    %Repeat iterations until distance < 10^(-6)
            root = Zk;
        else
            root = NaN;
        end
        [dist,rootIterations]=min(abs(root-complexroots));   %Matlab protocals to plot different colors for 
        colourcount(rootIterations)=colourcount(rootIterations)+1;
        colourrecord(rootIterations,colourcount(rootIterations))=z0;
    end
end


hold on

for k = 1:polyDegree
    plotarg = strcat(colours(k),'.');
    thiscolour = colourrecord(k,1:colourcount(k));
    plot(thiscolour,plotarg,'MarkerSize',1)
end

axis([xmin xmax ymin ymax])                                 %Setting axis limits
plot(complexroots,'k.','MarkerSize',3)                      %Plot fractals.

hold off