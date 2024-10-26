function result = runTwoParallelLinkSim(K, p, N)
    simResults = zeros(1, N);
    for i = 1:N
        txAttemptCount = 0;
        pktSuccessCount = 0;
        while pktSuccessCount < K
            txAttemptCount = txAttemptCount + 1;
            if rand > p || rand > p  % Success if either link succeeds
                pktSuccessCount = pktSuccessCount + 1;
            end
        end
        simResults(i) = txAttemptCount;
    end
    result = mean(simResults);
end