clear
clc
ex = Grid();
ex.add_node('1');
ex.add_node('2');
ex.add_node('3');
ex.add_node('4');
ex.add_node('5');
ex.add_line('1','1','2');
ex.add_line('2','1','3');
ex.add_line('3','3','4');
ex.add_line('4','3','5');
ex.plot_grid()
%%
clear
clc
disp(char({'Starting tests:'}))
counter = 0;
display = 1;

try
    ex = Grid();
    ex.add_node('1');
    ex.add_node('2');
    ex.add_line('1','1','2');
    if display
    disp('simple line: success')
    end
    counter = counter + 1;
catch msg
    if display
    warning(sprintf('simple line: fault; \n message: %s', msg.message));
    end
end

try
    ex = Grid();
    ex.add_node('1');
    ex.add_node('2');
    ex.add_node('3');
    ex.add_line('1','1','2');
    ex.add_line('2','1','3');
    if display
    disp('multiple child lines: success')
    end
    counter = counter + 1;
catch msg
    if display
        warning(sprintf...
            ('multiple child lines: fault \n message: %s', msg.message))
    end
end

try
    ex = Grid();
    ex.add_node('1');
    ex.add_line('1','source','1');
    if display
    disp('line to source: success')
    end
    counter = counter + 1;
catch msg
    if display
    warning(sprintf('line to source: fault \n message: %s', msg.message))
    end
end

try
    ex = Grid();
    ex.add_node('1');
    ex.add_line('1','1','source');
    if display
    warning(sprintf...
        ('source as a child: fault \n source allowed as a child'))
    end
catch msg
    if strcmp(msg.message, 'Source can not be chosen as a child')
        if display
            disp('source as a child: success')
        end
            counter = counter + 1;
        else
            if display
                warning(sprintf...
                    ('source as a child: fault \n message: %s', ...
                    msg.message))
            end
    end
end

try
    ex = Grid();
    ex.add_node(1);
    if display
    warning(sprint('non-char node id: fault \n char id was allowed'))
    end
catch msg
    if strcmp(msg.message, 'Node ID is not of "char" class')
        if display
            disp('non-char node id: success')
        end
        counter = counter + 1;
    else
        if display
            warning(sprintf('non-char node id: fault \n message: %s',...
                msg.message))
        end
    end
end

try
    ex = Grid();
    ex.add_node('1');
    ex.add_node('2');
    ex.add_line(1,'1','2');
    if display
        disp(char({'non-char line id: fault' 'char id was allowed'}))
    end
catch msg
    if strcmp(msg.message, 'Line ID is not of "char" class')
        if display
            disp('non-char line id: success')
        end
        counter = counter + 1;
    else
        if display
            warning(sprintf('non-char line id: fault \n message: %s',...
                msg.message))
        end
    end
end

try
    ex = Grid();
    ex.add_node('1');
    ex.add_node('1');
    ex.add_line('1','1','2');
    if display
        disp(char({'duplicate node: fault' '    multiple id allowed'}))
    end
catch msg
    if strcmp(msg.message, 'Node ID has a duplicate')
        if display
            disp('duplicate node: success')
        end
        counter = counter + 1;
    else
        if display
        warning(sprintf...
            ('duplicate node: fault \n message: %s', msg.message))
        end
    end
    
end

try
    ex = Grid();
    ex.add_node('1');
    ex.add_node('2');
    ex.add_node('3');
    ex.add_node('4');
    ex.add_line('1','1','2');
    ex.add_line('1','3','4');
    if display
        warning(char({'duplicate line: fault' '    multiple id allowed'}))
    end
catch msg
    if strcmp(msg.message, 'Line ID has a duplicate')
        if display
            disp('duplicate line: success')
        end
        counter = counter + 1;
    else
        if display
            warning(sprintf...
                ('duplicate line: fault \n message: %s', msg.message))
        end
    end
end

try
    ex = Grid();
    ex.add_node('1');
    ex.add_node('2');
    ex.add_line('1','1','2');
    ex.add_line('2','1','2');
catch msg
    if strcmp(msg.message(1:25),...
            'A parent line is assigned')
        if display
            disp('multiple parent lines: success')
        end
        counter = counter + 1;
    else
        if display
            warning(sprintf...
                ('multiple parent lines: fault \n message: %s',...
                msg.message))
        end
    end
    
end

try
    ex = Grid();
    ex.add_node('1');
    ex.add_node('2');
    ex.add_line('1','1','2', pi * 1i, pi);
    if ex.lines{1}.len == pi * 1i && ex.lines{1}.w == pi
        disp('line parameters assignment: sucess')
        counter = counter + 1;
    end 
catch msg
    if display
        warning(sprintf...
            ('line parameters assignment: fault \n message: %s',...
            msg.message))
    end
end

try
    ex = Grid();
    ex.add_node('1', pi);
    ex.add_node('2', pi);
    ex.add_line('1','1','2');
    if ex.nodes{2}.load == pi && ex.nodes{3}.load == pi
        disp('node parameters assignment: sucess')
        counter = counter + 1;
    end 
catch msg
    if display
        warning(sprintf...
            ('node parameters assignment: fault \n message: %s',...
            msg.message))
    end
end

try
    ex = Grid();
    ex.add_node('1');
    ex.add_node('2');
    ex.add_node('3');
    ex.add_line('1','1','2');
    ex.add_line('2','2','3');
    ex.add_line('3','3','1');
    warning(char({'loops in graph: fault', '    loops allowed'}))
catch msg
    if strcmp(msg.message, 'Line creates a loop')
        disp('loops in graph: success')
        counter = counter + 1;
    else
        warning(sprintf...
            ('loops in graph: fault \n message: %s', msg.message))
    end
end

if counter == 12
    disp(char({ 'Build successful', '', 'Running test'}))
    run('testScript.m')
else
    disp(char({ 'Build failed'}))
end
