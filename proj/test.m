    sendReceive = 'recieve';
    url = 'mms://192.168.42.1:8090';
    filename = 'vipmen.avi';


if strcmpi(sendReceive, 'send')
    % Create objects
    hSrc = vision.VideoFileReader(filename);
    hSnk = vision.VideoFileWriter;

    % Set parameters
    hSnk.FileFormat = 'WMV';
    hSnk.AudioInputPort = false;
    hSnk.Filename = url;

    % Run loop. Ctrl-C to exit
    while true
        data = step(hSrc);
        step(hSnk, data);
    end

else
    % Create objects
    hSrc = vision.VideoFileReader;
    hSnk = vision.VideoPlayer;

    % Set parameters
    hSrc.Filename = url;

    % Run loop. Ctrl-C to exit
    while true
        data = step(hSrc);
        step(hSnk, data);
    end
end