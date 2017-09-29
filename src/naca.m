%% NACA Airfoil Generator
% This function generates a set of points containing the coordinates of a
% NACA airfoil from the 4 Digit Series, 5 Digit Series and 6 Series given
% its number and, as additional features, the chordt, the number of points
% to be calculated, spacing type (between linear and cosine spacing),
% opened or closed trailing edge and the angle of attack of the airfoil.
% It also plots the airfoil for further comprovation if it is the required
% one by the user.
%
% INPUT DATA
%   n --> NACA number (4, 5 or 6 digits)
%
% OPTIONAL INPUT DATA
%   alpha --> Angle of attack (º) (0º default)
%   c --> Chord of airfoil (m) (1 m default)
%   s --> Number of points of airfoil (1000 default)
%   cs --> Linear or cosine spacing (0 or 1 respectively) (1 default)
%   cte --> Opened or closed trailing edge (0 or 1 respectively) (0 default)
%
% OUTPUT DATA
%   x_e --> Extrados x coordinate of airfoil vector (m)
%   x_i --> Intrados x coordinate of airfoil vector (m)
%   y_e --> Extrados y coordinate of airfoil vector (m)
%   y_i --> Intrados y coordinate of airfoil vector (m)
%
function[x_e,x_i,y_e,y_i]=NACA(n,alpha,c,s,cs,cte)
%----------------------- COMPROVATION OF AIRFOIL SERIES -------------------
if floor(n/1e7)==0
    if floor(n/1e6)==0
        if floor(n/1e5)==0
            if floor(n/1e4)==0
                nc=4;   % NACA 4 digit series
            else
                nc=5;   % NACA 5 digit series
            end
        else
            nc=6;   % NACA 6 digit series
        end
    else
        nc=7;   % NACA 7 digit series
    end
else
    nc=8;   % NACA 8 digit series
end
%----------------------- PREVIOUS CALCULATIONS ----------------------------
if ~exist('c','var')
    c=1;    % Default chord value (m)
end
if ~exist('s','var')
    s=1000; % Default number of points value
end
if exist('cs','var')
    if cs==0
        x=linspace(0,1,s);  % X coordinate of airfoil (linear spacing)
    else
        beta=linspace(0,pi,s);  % Angle for cosine spacing
        x=(1-cos(beta))/2;  % X coordinate of airfoil (cosine spacing)
    end
else
    beta=linspace(0,pi,s);  % Angle for cosine spacing
    x=(1-cos(beta))/2;  % X coordinate of airfoil (cosine spacing)
end
if ~exist('alpha','var')
    alpha=0;    % Default angle of attack
end
t=rem(n,100)/100;   % Maximum thickness as fraction of chord (two last digits)
sym=0;  % Symetric airfoil variable
alpha=alpha/180*pi; % Conversion of angle of attack from degrees to radians
%----------------------- VARIABLE PRELOCATION -----------------------------
y_c=zeros(1,s); % Mean camber vector prelocation
dyc_dx=zeros(1,s);  % Mean camber fisrt derivative vector prelocation
%----------------------- THICKNESS CALCULATION ----------------------------
if exist('cte','var')
    if cte==1
        y_t=t/0.2*(0.2969*sqrt(x)-0.126*x-0.3516*x.^2+0.2843*x.^3-0.1036*x.^4); % Thickness y coordinate with closed trailing edge
    else
        y_t=t/0.2*(0.2969*sqrt(x)-0.126*x-0.3516*x.^2+0.2843*x.^3-0.1015*x.^4); % Thickness y coordinate with opened trailing edge
    end
else
    y_t=t/0.2*(0.2969*sqrt(x)-0.126*x-0.3516*x.^2+0.2843*x.^3-0.1015*x.^4); % Thickness y coordinate with opened trailing edge
end
if nc==4
%----------------------- MEAN CAMBER 4 DIGIT SERIES CALCULATION -----------
    %----------------------- CONSTANTS ------------------------------------
    m=floor(n/1000)/100;    % Maximum camber (1st digit)
    p=rem(floor(n/100),10)/10;  % Location of maximum camber (2nd digit)
    if m==0
        if p==0
            sym=1;  % Comprovation of symetric airfoil with two 0
        else
            sym=2;  % Comprovation of symetric airfoil with one 0
        end
    end
    %----------------------- CAMBER ---------------------------------------
    for i=1:1:s
        if x(i)<p
            y_c(i)=m*x(i)/p^2*(2*p-x(i))+(1/2-x(i))*sin(alpha);	% Mean camber y coordinate
            dyc_dx(i)=2*m/p^2*(p-x(i))/cos(alpha)-tan(alpha);	% Mean camber first derivative
        else
            y_c(i)=m*(1-x(i))/(1-p)^2*(1+x(i)-2*p)+(1/2-x(i))*sin(alpha);	% Mean camber y coordinate
            dyc_dx(i)=2*m/(1-p)^2*(p-x(i))/cos(alpha)-tan(alpha);	% Mean camber first derivative
        end
    end
elseif nc==5
%----------------------- MEAN CAMBER 5 DIGIT SERIES CALCULATION -----------
    %----------------------- CONSTANTS ------------------------------------
    p=rem(floor(n/1000),10)/20;  % Location of maximum camber (2nd digit)
    rn=rem(floor(n/100),10);    % Type of camber (3rd digit)
    if rn==0
    %----------------------- STANDARD CAMBER ------------------------------
        %----------------------- CONSTANTS --------------------------------
        r=3.33333333333212*p^3+0.700000000000909*p^2+1.19666666666638*p-0.00399999999996247;    % R constant calculation by interpolation
        k1=1514933.33335235*p^4-1087744.00001147*p^3+286455.266669048*p^2-32968.4700001967*p+1420.18500000524;  % K1 constant calculation by interpolation
        %----------------------- CAMBER -----------------------------------
        for i=1:1:s
            if x(i)<r
                y_c(i)=k1/6*(x(i)^3-3*r*x(i)^2+r^2*(3-r)*x(i))+(1/2-x(i))*sin(alpha); % Mean camber y coordinate
                dyc_dx(i)=k1/6*(3*x(i)^2-6*r*x(i)+r^2*(3-r))/cos(alpha)-tan(alpha); % Mean camber first derivative
            else
                y_c(i)=k1*r^3/6*(1-x(i))+(1/2-x(i))*sin(alpha);   % Mean camber y coordinate
                dyc_dx(i)=-k1*r^3/(6*cos(alpha))-tan(alpha);    % Mean camber first derivative
            end
        end
    elseif rn==1
    %----------------------- REFLEXED CAMBER ------------------------------
        %----------------------- CONSTANTS --------------------------------
        r=10.6666666666861*p^3-2.00000000001601*p^2+1.73333333333684*p-0.0340000000002413;  % R constant calculation by interponation
        k1=-27973.3333333385*p^3+17972.8000000027*p^2-3888.40666666711*p+289.076000000022;  % K1 constant calculation by interpolation
        k2_k1=85.5279999999984*p^3-34.9828000000004*p^2+4.80324000000028*p-0.21526000000003;    % K1/K2 constant calculation by interpolation
        %----------------------- CAMBER -----------------------------------
        for i=1:1:s
            if x(i)<r
                y_c(i)=k1/6*((x(i)-r)^3-k2_k1*(1-r)^3*x(i)-r^3*x(i)+r^3)+(1/2-x(i))*sin(alpha);   % Mean camber y coordinate
                dyc_dx(i)=k1/6*(3*(x(i)-r)^2-k2_k1*(1-r)^3-r^3)/cos(alpha)-tan(alpha);    % Mean camber first derivative
            else
                y_c(i)=k1/6*(k2_k1*(x(i)-r)^3-k2_k1*(1-r)^3*x(i)-r^3*x(i)+r^3)+(1/2-x(i))*sin(alpha); % Mean camber y coordinate
                dyc_dx(i)=k1/6*(3*k2_k1*(x(i)-r)^2-k2_k1*(1-r)^3-r^3)/cos(alpha)-tan(alpha);  % Mean camber first derivative
            end
        end
    else
        error('Incorrect NACA number. Third digit must be either 0 or 1');  % Error in standard/reflexed camber digit
    end
elseif nc==6
%----------------------- MEAN CAMBER 6 DIGIT SERIES CALCULATION -----------
    %----------------------- CONSTANTS ------------------------------------
    ser=floor(n/100000);    % Number of series (1st digit)
    a=rem(floor(n/10000),10)/10;  % Chordwise position of minimum pressure (2nd digit)
    c_li=rem(floor(n/100),10)/10;  % Design lift coefficient (4th digit)
    g=-1/(1-a)*(a^2*(1/2*log(a)-1/4)+1/4);  % G constant calculation
    h=1/(1-a)*(1/2*(1-a)^2*log(1-a)-1/4*(1-a)^2)+g; % H constant calculation
    if ser==6
    %----------------------- CAMBER ---------------------------------------
        y_c=c_li/(2*pi*(a+1))*(1/(1-a)*(1/2*(a-x).^2.*log(abs(a-x))-1/2*(1-x).^2.*log(1-x)+1/4*(1-x).^2-1/4*(a-x).^2)-x.*log(x)+g-h*x)+(1/2-x)*sin(alpha); % Mean camber y coordinate
        dyc_dx=-(c_li*(h+log(x)-(x/2-a/2+(log(1-x).*(2*x-2))/2+(log(abs(a-x)).*(2*a-2*x))/2+(sign(a-x).*(a-x).^2)./(2*abs(a-x)))/(a-1)+1))/(2*pi*(a+1)*cos(alpha))-tan(alpha);    % Mean camber first derivative
    else
        error('NACA 6 Series must begin with 6');   % Error in 1st digit NACA 6 Series
    end
else
    error(['NACA ' num2str(nc) ' Series has not been yet implemented']);    % Error of non-implemented NACA Series
end
%----------------------- FINAL CALCULATIONS -------------------------------
theta=atan(dyc_dx); % Angle for modifying x coordinate
x=1/2-(1/2-x)*cos(alpha);   % X coordinate rotation
%----------------------- COORDINATE ASSIGNATION ---------------------------
x_e=(x-y_t.*sin(theta))*c;  % X extrados coordinate
x_i=(x+y_t.*sin(theta))*c;  % X intrados coordinate
y_e=(y_c+y_t.*cos(theta))*c;    % Y extrados coordinate
y_i=(y_c-y_t.*cos(theta))*c;    % Y intrados coordinate
%----------------------- NACA PLOT ----------------------------------------
ep=plot(x_e,y_e,'b');  % Extrados plot
hold;   % Hold current plot without erasing it
plot(x_i,y_i,'b');  % Intrados plot
mclp=plot(x,y_c,'r');    % Mean camber line plot
clp=plot([c/2*(1-cos(alpha)),c/2*(1+cos(alpha))],[c/2*sin(alpha),-c/2*sin(alpha)],'g');  % Chord line plot
grid;   % Grid visualization
axis('equal');  % Equal axis for improved NACA airfoil visualization
if sym==1
    title(['NACA 00' num2str(n) ' Airfoil Plot (' num2str(alpha/pi*180) 'º)']); % Plot title for two 0 symetric airfoil
    legend([ep,mclp,clp],['NACA 00' num2str(n) ' Airfoil'],'Mean camber line','Chord line');   % Legend for two 0 symetric airfoil
elseif sym==2
    title(['NACA 0' num2str(n) ' Airfoil Plot (' num2str(alpha/pi*180) 'º)']); % Plot title for one 0 symetric airfoil
    legend([ep,mclp,clp],['NACA 0' num2str(n) ' Airfoil'],'Mean camber line','Chord line');   % Legend for one 0 symetric airfoil
else
    title(['NACA ' num2str(n) ' Airfoil Plot (' num2str(alpha/pi*180) 'º)']); % Plot title for asymetric airfoil
    legend([ep,mclp,clp],['NACA ' num2str(n) ' Airfoil'],'Mean camber line','Chord line');   % Legend for asymetric airfoil
end
xlabel('X (m)');    % Label of x axis
ylabel('Y (m)');    % Label of y axis
end