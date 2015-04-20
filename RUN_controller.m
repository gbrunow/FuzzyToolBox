%clear Command Window and Workspace
clc;
clear all;
%Close all opened figures
delete(findall(0,'Type','figure'));
bdclose('all');

inc = input('Insert the desired lookup table resolution (2-5 is suggested for plotting purposes): ');
while ~(~isempty(inc) ...
            && isnumeric(inc) ...
            && isreal(inc) ...
            && isfinite(inc) ...
            && (inc > 0))
    clc;
    disp('Invalid input!');
    inc = input('Insert the desired lookup table resolution (2-5 is suggested for plotting purposes): ');
end

%create figure in fullscreen
figure('units','normalized','outerposition',[0 0 1 1]);

tic;
progress = 'Working... ';
disp([progress, ' 0%']);

%Position
%figure;
support_p   = 0:0.1:100;
left        = fshape(support_p, [0 0 10 35]);
leftcenter  = fshape(support_p, [30, 40, 50]);
center      = fshape(support_p, [45, 50, 55]);
rightcenter = fshape(support_p, [50, 60, 70]);
right       = fshape(support_p, [65, 90, 100, 100]);
ling_var_p   = [left(1,1:end); leftcenter(1,1:end); center(1,1:end); rightcenter(1,1:end); right(1,1:end)];

subplot(3,4,1);
plot(support_p, ling_var_p);
xlabel('Position');
ylabel('Grade');

%Angle
%figure;
subplot(3,4,5);
support_a   = -100:0.1:300;
rbelow      = fshape(support_a, [-90 -45 9]);
rupper      = fshape(support_a, [-9 23 54]);
rvertical   = fshape(support_a, [36 63 90]);
vertical    = fshape(support_a, [72 90 108]);
lvertical   = fshape(support_a, [90 117 144]);
lupper      = fshape(support_a, [126 157 189]);
lbelow      = fshape(support_a, [171  225 270]);
ling_var_a  = [rbelow(1,1:end); rupper(1,1:end); rvertical(1,1:end); vertical(1,1:end); lvertical(1,1:end); lupper(1,1:end); lbelow(1,1:end)];

plot(support_a, ling_var_a);
xlabel('Angle');
ylabel('Grade');

%Output
%figure;
subplot(3,4,9);
support_o   = -30:0.1:30;
negbig      = fshape(support_o, [-30 -30 -20]);
negmed      = fshape(support_o, [-25 -15 -5]);
negsm       = fshape(support_o, [-12 -6 0]);
zero        = fshape(support_o, [-5 0 5]);
possm       = fshape(support_o, [0 6 12]);
posmed      = fshape(support_o, [5 15 25]);
posbig      = fshape(support_o, [15 30 30]);
ling_var_o  = [negbig(1,1:end); negmed(1,1:end); negsm(1,1:end); zero(1,1:end); possm(1,1:end); posmed(1,1:end); posbig(1,1:end)];

plot(support_o, ling_var_o);
xlabel('Output');
ylabel('Grade');

%Inferences Definition
inference_table = { 
    left        rbelow;
    leftcenter  rbelow;
    center      rbelow;
    rightcenter rbelow;
    right       rbelow;
    left        rupper;
    leftcenter  rupper;
    center      rupper;
    rightcenter rupper;
    right       rupper;
    left        rvertical;
    leftcenter  rvertical;
    center      rvertical;
    rightcenter rvertical;
    right       rvertical;
    left        vertical;
    leftcenter  vertical;
    center      vertical;
    rightcenter vertical;
    right       vertical;
    left        lvertical;
    leftcenter  lvertical;
    center      lvertical;
    rightcenter lvertical;
    right       lvertical;
    left        lupper;
    leftcenter  lupper;
    center      lupper;
    rightcenter lupper;
    right       lupper;
    left        lbelow;
    leftcenter  lbelow;
    center      lbelow;
    rightcenter lbelow;
    right       lbelow;    
    };

output_table = { possm, posmed, posmed, posbig, posbig, negsm, possm, posmed, posbig, posbig, negmed, negsm, possm, posmed, posbig, negmed, negmed, zero, posmed, posmed, negbig, negmed, negsm, possm, posmed, negbig, negbig, negmed, negsm, possm, negbig, negbig, negmed, negmed, negsm };

%Rule Example
hold on;
rule_ex = fmamdani([39 77], inference_table, output_table);
plot(support_o, rule_ex, 'm', 'LineWidth', 2);

%Defuzzification example
df = dfuzzy(support_o,rule_ex);
mf = membership(df, [rule_ex; support_o]);
%plot(linspace(df, df, 10),linspace(0,mf, 10), 'b+');
plot(df,mf, 'bo');
plot(df,mf, 'b+');
hold off;

%Surface Plot
%figure;
subplot(3,4, [2:4 6:8 10:12]);
position = 10:inc:100;
angle = -90:inc:270;
total = (length(position)*length(angle));
atotal = length(angle);
for i=1:length(position);
   for j=1:length(angle)
           outv(j,i) = dfuzzy(support_o, fmamdani([position(i), angle(j)], inference_table, output_table));
   end
   clc;
   percentage = ((i*atotal)/total)*100;
   disp([progress, int2str(percentage), '%']);
   if i>1
       surf(outv);
       view([45 -45]);
       title('Rules Surface');
       xlabel('Position');
       ylabel('Angle');
       zlabel('Output');
       drawnow;
   end
end
surf(position, angle, outv);
view([45 -45]);
title('Rules Surface')
xlabel('Position');
ylabel('Angle');
zlabel('Output');
timeElapsed = toc;
clc;
progress = strcat(progress, ' 100%');
disp(progress);
disp(['Time elapsed: ', int2str(timeElapsed), ' seconds']);
disp(['Inputs computed: [', int2str(length(position)),'x', int2str(length(angle)), '] -> ', int2str(length(position)*length(angle))]);
