length = 300 * 10^-3;
delay = 150*10^-3;
Fs = 16000;
t = 0 : 1/Fs : length;
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

prompt = 'Enter Characters : \n';
inp = input(prompt, 's');
splited_inp = split(inp, ' ');
for s = 1 : size(splited_inp)
    ff = [0, 0];
    for i = 1 : size(table)
        if splited_inp{s} == table{i}
            ff = table{i, 2};
            found = 1;
            break;
        end
    end
    if found ~= 0
        x1 = sin(2 * pi * t * ff(1));
        x2 = sin(2 * pi * t * ff(2));
        soundsc((x1 + x2), Fs);
        pause(delay);
    else
        x1 = 0;
        soundsc((x1 + x1), Fs);
        pause(delay);
    end
    found = 0;
        
end


    

    
    
    
    