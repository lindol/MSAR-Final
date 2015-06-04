ifPlot=1;
% ���pv�MPnsdf
waveDir='D:\LAB\wave';
waveDir=strrep(waveDir, '\', '/');
allWaves=recursiveFileList(waveDir, 'wav');
waveNum=length(allWaves);
%waveNum=10;
fprintf('�q "%s" Ū���F %d �� wav �ɮ�\n', waveDir, waveNum);
totalTime=0;
allscore=[];
Rdata=zeros(1,22); % �O�����T�I��  index�������t�bi�ӥb���H�� ����0~10 and inf
%Wdata=zeros(1,11); % �O�����~�I��  index�������t�bi�ӥb����
%waveNum=1;
for i=1:waveNum
	tic;
    fprintf('%d/%d: Check the pitch of %s...\n', i, waveNum, allWaves(i).path);
	pvFile = [allWaves(i).path(1:end-3) 'pv'];
    nsdfFile = [allWaves(i).path(1:end-3) 'Pnsdf'];	
    % Ū���H�u�Э� pitch
    fp1 = fopen(pvFile,'r');
    pVector = fscanf(fp1,'%g');
    fclose(fp1);
    % Ū��nsdf�Э� pitch
    fp2 = fopen(nsdfFile,'r');
    nVector = fscanf(fp2,'%g');
    fclose(fp2);
    % ��ܵupitch������
    NumP = length(pVector);
    NumN = length(nVector);
    CNum = min(NumP,NumN);
    % �ؼ�index�A�u�p���̨Ǥ��O0�������I
    targetI = find(pVector(1:CNum)>0 & nVector(1:CNum)>0);
    result = ceil(abs(pVector(targetI)-nVector(targetI))); % �۴���G�A�åHceil����
    for j=1:length(result)
        if result(j) > 20
            index=21;
        else
            index=result(j);
        end
        for k=1:22
            if k-1 >= index
                Rdata(k) = Rdata(k) + 1;
            end
        end
    end
	t=toc;
	fprintf('used time=%g\n',t);
	totalTime=totalTime+toc;
end
fprintf('all points=%d\n',Rdata(22));
fprintf('totalTime=%g   averageTime=%g\n',totalTime,totalTime/waveNum);
if ifPlot
    x=0:21;
    plot(x,Rdata*100/Rdata(22),'-o');
    title('NSDF�p��pitch�P�H�u�Х�pitch���Ѳv');
    xlabel('�ۮt����(�b��)');
    ylabel('���Ѳv(%)');
    axis([0,21,floor(Rdata(1)*100/Rdata(22)),inf]);
    grid on;
end

    