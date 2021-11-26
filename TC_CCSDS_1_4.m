function [ BER ] = TC_CCSDS_1_4( blockLen,numTxBlocks,indInter,ax )

    switch blockLen
        case 1784
            vectEbNo = 0.2:0.1:0.6;
            load('r1_4err1784_17mbits.mat');
            ccsds = errVect;
        case 3568
            vectEbNo = 0:0.1:0.4;
            load('r1_4err3568_28mbits.mat');
            ccsds = errVect;
        case 7136
            vectEbNo = -0.1:0.1:0.2;
            load('r1_4err7136_17mbits.mat');
            ccsds = errVect;
        case 8920
            vectEbNo = -0.2:0.1:0.2;
            load('r1_4err8920_31mbits.mat');
            ccsds = errVect;
    end

    errVect = zeros(1,length(vectEbNo));
    numIter = 10;
    trellis = poly2trellis(5 , [ 23 33 25 37 ], 23);
    r = 1/4; %code rate 
    assignin('base','numIter',numIter)
    assignin('base','trellis',trellis)
    assignin('base','blockLen',blockLen)
    assignin('base','indInter',indInter)
    assignin('base','punct',punct')
    tic
    for i = 1:length(vectEbNo)
        i
        EbNo = vectEbNo(i);
        assignin('base','EbNo',EbNo)
        variance = 1/(2*r*10^(vectEbNo(i)/10));
        assignin('base','variance',variance)
        sim('simTurboLibMat1_4','StartTime','0','StopTime',num2str(numTxBlocks));
        load('ErrorVecSim.mat');
        errVect(i) = ErrorVecSim(2,end);
    end
    toc
    numBits = ErrorVecSim(4,end);

    semilogy(ax,vectEbNo,ccsds,vectEbNo,errVect)
    title(['Turbo Code simulated for ',num2str(numBits), ' bits.'])
    legend('CCSDS TC','User TC')
    xlabel('Eb/No (dB)')
    ylabel('BER')
    grid on
    BER = [vectEbNo; errVect];
end

