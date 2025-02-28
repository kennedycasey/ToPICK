function output = create_test_order(array_to_order, n_allowable_repetitions)

    for i = 1:100000
        %n_allowable_repetitions = 6;
        %n_allowable_repetitions = 3;
        test_array = {};
        rand_array = array_to_order;
        repCount1 = 0;
        repCount2 = 0;
        repCount3 = 0;
        repCount4 = 0;
        
        test_sampler = vertcat({'1', '1', '1', '1', '0', '0', '0', '0'})';
        test_sampler_randomized = test_sampler(randperm(size(test_sampler,1)),:);
        
        success = 1;
        
        for j = 1:length(rand_array)
            % Current trial
            curr = rand_array(j,:);
            rand = test_sampler_randomized(j);
            
            if sum(contains(curr, 'blick')) && sum(contains(curr, 'moff'))
                rand = test_sampler_randomized(j);
                
                if contains(rand, '1')
                    test_array = [test_array ; 'blick'];
                    repCount1 = repCount1 + 1;
                    
                    if repCount1 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                elseif contains(rand, '0')
                    test_array = [test_array ; 'moff'];
                    repCount2 = repCount2 + 1;
                    
                    if repCount2 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                end
                
            elseif sum(contains(curr, 'blick')) && sum(contains(curr, 'wug'))
                
                if contains(rand, '1')
                    test_array = [test_array ; 'blick'];
                    repCount1 = repCount1 + 1;
                    
                    if repCount1 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                elseif contains(rand, '0')
                    test_array = [test_array ; 'wug'];
                    repCount3 = repCount3 + 1;
                    
                    if repCount3 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                end
                
            elseif sum(contains(curr, 'blick')) && sum(contains(curr, 'zad'))
                
                if contains(rand, '1')
                    test_array = [test_array ; 'blick'];
                    repCount1 = repCount1 + 1;
                    
                    if repCount1 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                elseif contains(rand, '0')
                    test_array = [test_array ; 'zad'];
                    repCount4 = repCount4 + 1;
                    
                    if repCount4 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                end
                
            elseif sum(contains(curr, 'moff')) && sum(contains(curr, 'wug'))
                                
                if contains(rand, '1')
                    test_array = [test_array ; 'moff'];
                    repCount2 = repCount2 + 1;
                    
                    if repCount2 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                elseif contains(rand, '0')
                    test_array = [test_array ; 'wug'];
                    repCount3 = repCount3 + 1;
                    
                    if repCount3 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                end
                
            elseif sum(contains(curr, 'moff')) && sum(contains(curr, 'zad'))
                                
                if contains(rand, '1')
                    test_array = [test_array ; 'moff'];
                    repCount2 = repCount2 + 1;
                    
                    if repCount2 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                elseif contains(rand, '0')
                    test_array = [test_array ; 'zad'];
                    repCount4 = repCount4 + 1;
                    
                    if repCount4 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                end
                
            elseif sum(contains(curr, 'wug')) && sum(contains(curr, 'zad'))
                                
                if contains(rand, '1')
                    test_array = [test_array ; 'wug'];
                    repCount3 = repCount3 + 1;
                    
                    if repCount3 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                elseif contains(rand, '0')
                    test_array = [test_array ; 'zad'];
                    repCount4 = repCount4 + 1;
                    
                    if repCount4 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                    
                end
            else % If we break out of the loop, reset the counters
                repCount1 = 0;
                repCount2 = 0;
                repCount3 = 0;
                repCount4 = 0;
            end
        end % end for loop
        
        
        
        if success == 1
           output = test_array;
           break
        end
    end
end
    