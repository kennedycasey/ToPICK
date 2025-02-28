function output = create_pseudorandom_order(array_to_order,n_allowable_repetitions)

    for i = 1:100000
        rand_array = array_to_order(randperm(size(array_to_order,1)),:);
        repCount1 = 0;
        repCount2 = 0;
        repCount3 = 0;
        repCount4 = 0;
        success = 1;
        
        for j = 2:length(rand_array)
            curr = rand_array(j,:);
            prev = rand_array(j-1,:);
            
            if sum(contains(curr, '1')) && sum(contains(prev, '1'))
                repCount1 = repCount1 +1;
                
                if repCount1 > n_allowable_repetitions
                    success = 0;
                    break;
                    
                end
                
                if sum(contains(curr, '2')) && sum(contains(prev, '2'))
                    repCount2 = repCount2 +1;
                    
                    if repCount2 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                        
                elseif sum(contains(curr, '3')) && sum(contains(prev, '3'))
                        repCount3 = repCount3 +1;
                        
                    if repCount3 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                            
                elseif sum(contains(curr, '4')) && sum(contains(prev, '4'))
                    repCount4 = repCount4 +1;

                    if repCount4 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                end
                
            elseif sum(contains(curr, '2')) && sum(contains(prev, '2'))
                repCount2 = repCount2 +1;
                
                if repCount2 > n_allowable_repetitions
                    success = 0;
                    break;
                end
                    
                if sum(contains(curr, '1')) && sum(contains(prev, '1'))
                    repCount1 = repCount1 +1;
                    
                    if repCount1 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                        
                elseif sum(contains(curr, '3')) && sum(contains(prev, '3'))
                        repCount3 = repCount3 +1;
                        
                    if repCount3 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                            
                elseif sum(contains(curr, '4')) && sum(contains(prev, '4'))
                    repCount4 = repCount4 +1;

                    if repCount4 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                end
                
            elseif sum(contains(curr, '3')) && sum(contains(prev, '3'))
                repCount3 = repCount3 +1;
                
                if repCount3 > n_allowable_repetitions
                    success = 0;
                    break;
                end
                    
                if sum(contains(curr, '2')) && sum(contains(prev, '2'))
                    repCount2 = repCount2 +1;
                    
                    if repCount2 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                        
                elseif sum(contains(curr, '1')) && sum(contains(prev, '1'))
                        repCount1 = repCount1 +1;
                        
                    if repCount1 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                            
                elseif sum(contains(curr, '4')) && sum(contains(prev, '4'))
                    repCount4 = repCount4 +1;

                    if repCount4 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                end
                
            elseif sum(contains(curr, '4')) && sum(contains(prev, '4'))
                repCount4 = repCount4 +1;
                
                if repCount4 > n_allowable_repetitions
                    success = 0;
                    break;
                end
                    
                if sum(contains(curr, '2')) && sum(contains(prev, '2'))
                    repCount2 = repCount2 +1;
                    
                    if repCount2 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                        
                elseif sum(contains(curr, '3')) && sum(contains(prev, '3'))
                        repCount3 = repCount3 +1;
                        
                    if repCount3 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                            
                elseif sum(contains(curr, '1')) && sum(contains(prev, '1'))
                    repCount1 = repCount1 +1;

                    if repCount1 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                end
                              
            else
                repCount1 = 0;
                repCount2 = 0;
                repCount3 = 0;
                repCount4 = 0;
            end
        end

        if success == 1
           output = rand_array;
           break
        end
    end

end