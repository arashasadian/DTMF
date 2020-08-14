clc;close;
table  = {
     '1',[1209 697]
    ;'2',[1336 697] 
    ;'3',[1477 697]
    ;'4',[1209 770]
    ;'5',[1336 770]
    ;'6',[1477 770]
    ;'7',[1209 852]
    ;'8',[1336 852]
    ;'9',[1477 852]
    ;'A',[1633 697]
    ;'B',[1633 770]
    ;'C',[1633 852]
    ;'D',[1633 941]
    ;'*',[1209 941]
    ;'#',[1477 941]
    ;'0',[1336 941]};
% [y,Fs] = audioread('Test_DTMF.wav');
% threshold = 0.0001;
% window = 100;
% N = 410;
% f = [697 770 852 941 1209 1336 1477];
% freq_indices = round(f/Fs*N) + 1;
% result = [];
% index = 1;
% sampled = [];
% energies = [];
% for i = 1 :  (size(y, 1))/(window)
%     sampled = [sampled, y((i-1) * window + 1: i * window)];
% end
% for i = 1 :  size(sampled)
%     energy = sum(sampled(i, :).^2);
%     energies = [energies; energy];
% end
% 
% sampled_x = [];
% energies_x = [];
% size(sampled)
% for i = 1 : size(sampled, 1)
%     if( mod(i, 2) ~= 0)
%         a = sampled(i, :);
%         sampled_x = [sampled_x; a];
%         energies_x = [energies_x; energies(i)];
%     end
% end
% result = [];
% size(sampled_x);
% abs_diff = abs(diff(energies_x));
% index = 1;
% while index ~= size(abs_diff) - 1
%     current = sampled_x(index, :);
%     while ((abs_diff(index) < threshold))
%         current = [current, sampled_x(index, :)];
%         index = index + 1;
%     end
%     index = index + 1;
%     goer_res = goertzel(current, freq_indices);
%     abs_goer = abs(goer_res);
%     maxi1 = 1;
%     maxi2 = 2;
%     if abs_goer(maxi1) < abs_goer(maxi2)
%         maxi1 = 2;
%         maxi2 = 1;
%     end
%     for j = 3:7
%         if (abs_goer(j) > abs_goer(maxi1))
%             maxi2 = maxi1;
%             maxi1 = j;
%         elseif abs_goer(j) > abs_goer(maxi2)
%             maxi2 = j;
%         end
%     end
%     f1 = f(maxi1);
%     f2 = f(maxi2);
%     for i = 1 : size(table)
%         ff = table{i, 2};
%         if ff(1) == f1 && ff(2) == f2
%             res = table{i};
%             if size(result) ~= 0
%                 if result(end) ~= res
%                     result = [result ; res];
%                 end
%             else
%                 result = [result ; res];
%             end
%         end
%     end
% end
% result
%     
% 
% for i = 1: size(sampled_x) - 1
%     
% %     disp(abs(energies_x(i + 1) - energies_x(i)))
%     if abs(energies_x(i + 1) - energies_x(i)) > threshold
%         current = sampled_x(i ,:);
%         goer_res = goertzel(current, freq_indices);
%         abs_goer = abs(goer_res);
%         maxi1 = 1;
%         maxi2 = 2;
%         if abs_goer(maxi1) < abs_goer(maxi2)
%             maxi1 = 2;
%             maxi2 = 1;
%         end
%         for j = 3:7
%             if (abs_goer(j) > abs_goer(maxi1))
%                 maxi2 = maxi1;
%                 maxi1 = j;
%             elseif abs_goer(j) > abs_goer(maxi2)
%                 maxi2 = j;
%             end
%         end
%         f1 = f(maxi1);
%         f2 = f(maxi2);
%         for i = 1 : size(table)
%             ff = table{i, 2};
%             if ff(1) == f1 && ff(2) == f2
%                 res = table{i};
%                 if size(result) ~= 0
%                     if result(end) ~= res
%                         result = [result , res];
%                     end
%                 else
%                     result = [result , res];
%                 end
%             end
%         end
%         index = index + 1;
%     end
% end
% result
% % 
% % while( index < (size(y, 1))/(window))
%     current_space = y((index-1) * window + 1: index * window);
% %     current_space = pulsewidth(current_space, Fs)
%     goer_res = goertzel(current_space, freq_indices);
%     abs_goer = abs(goer_res);
%     maxi1 = 1;
%     maxi2 = 2;
%     if abs_goer(maxi1) < abs_goer(maxi2)
%         maxi1 = 2;
%         maxi2 = 1;
%     end
%     for i = 3:7
%         if (abs_goer(i) > abs_goer(maxi1))
%             maxi2 = maxi1;
%             maxi1 = i;
%         elseif abs_goer(i) > abs_goer(maxi2)
%             maxi2 = i;
%         end
%     end
%     f1 = f(maxi1);
%     f2 = f(maxi2);
%     for i = 1 : size(table)
%         ff = table{i, 2};
%         if ff(1) == f1 && ff(2) == f2
%             res = table{i};
%             if size(result) ~= 0
%                 if result(end) ~= res
%                     result = [result ; res];
%                 end
%             else
%                 result = [result ; res];
%             end
%         end
%     end
%     index = index + 1;
% end
% result

[y, Fs] = audioread('Test_DTMF.wav');
window = Fs / 200;
f = [697 770 852 941 1209 1336 1477 1633];
result = [];
rms_envelope = envelope(y, window, 'rms');
[width, starts, ends] = pulsewidth(rms_envelope, Fs);
starts = [.001; starts];
ends = [starts(2); ends];
starts = round(starts * Fs);
ends = round(ends * Fs);

samples = cell(size(starts));

for i = 1:size(samples)
    samples(i,:) = {y(starts(i):ends(i))};
end


for i = 1 : size(samples)
    N = size(samples{i}, 1);
    freq_indices = round(f./Fs*N) + 1; 
    goertz_res = goertzel(samples{i}, freq_indices);
    [maxs, max_indices] = maxk(abs(goertz_res), 2);
    freq1 = f(max_indices(1));
    freq2 = f(max_indices(2));
    for i = 1 : size(table)
        ff = table{i, 2};
        if ff(1) == freq1 && ff(2) == freq2
            res = table{i};
            result = [result; res];
        end
    end
end
result
       













