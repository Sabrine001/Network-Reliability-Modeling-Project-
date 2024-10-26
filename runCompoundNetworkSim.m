function [all_results, p_values] = runCompoundNetworkSim(K_values, num_iterations)
    % runCompoundNetworkSim - Simulates transmission across compound network for multiple K values
    %
    % Inputs:
    %   K_values - Array of packet numbers to simulate
    %   num_iterations - Number of iterations for each simulation
    %
    % Outputs:
    %   all_results - Matrix of results (rows = K values, columns = p values)
    %   p_values - Array of probability values used
    
    % Define probability range
    p_values = 0.01:0.01:0.99;
    
    % Initialize results matrix
    all_results = zeros(length(K_values), length(p_values));
    
    % Run simulation for each K value
    for k_idx = 1:length(K_values)
        K = K_values(k_idx);
        results = zeros(1, length(p_values));
        
        % Display progress
        fprintf('Simulating for K = %d\n', K);
        
        % Simulate for each p value
        for p_idx = 1:length(p_values)
            p = p_values(p_idx);
            total_transmissions = 0;
            
            % Run multiple iterations
            for iter = 1:num_iterations
                total_transmissions = total_transmissions + simulateNetwork(K, p);
            end
            
            % Calculate average
            results(p_idx) = total_transmissions / num_iterations;
        end
        
        % Store results
        all_results(k_idx, :) = results;
    end
end

function transmissions = simulateNetwork(K, p)
    % simulateNetwork - Helper function to simulate single transmission
    %
    % Inputs:
    %   K - Number of packets
    %   p - Probability of failure
    %
    % Output:
    %   transmissions - Total number of transmissions needed
    
    total_transmissions = 0;
    
    % For each packet
    for packet = 1:K
        packet_transmissions = 0;
        success = false;
        
        while ~success
            packet_transmissions = packet_transmissions + 1;
            
            % Simulate parallel paths in first section
            path1_success = rand() > p && rand() > p;  % Two links in series
            path2_success = rand() > p;  % One link
            first_section_success = path1_success || path2_success;
            
            % Simulate final link
            final_link_success = rand() > p;
            
            % Check if transmission was successful
            success = first_section_success && final_link_success;
        end
        
        total_transmissions = total_transmissions + packet_transmissions;
    end
    
    transmissions = total_transmissions;
end