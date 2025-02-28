function output = create_pseudorandom_test_order(array_to_order,n_allowable_repetitions)

    for i = 1:100000
        %rand_array = create_test_order(array_to_order, 2);
        
        rand_array = array_to_order(randperm(size(array_to_order,1)),:);
        repCount1 = 0;
        repCount2 = 0;
        repCount3 = 0;
        repCount4 = 0;
        success = 1;
        
        for j = 2:length(rand_array)
            curr = rand_array(j,:);
            prev = rand_array(j-1,:);
            
            if sum(contains(curr, 'blick')) && sum(contains(prev, 'blick'))
                repCount1 = repCount1 +1;
                
                if repCount1 > n_allowable_repetitions
                    success = 0;
                    break;
                    
                end
                
                if sum(contains(curr, 'moff')) && sum(contains(prev, 'moff'))
                    repCount2 = repCount2 +1;
                    
                    if repCount2 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                        
                elseif sum(contains(curr, 'wug')) && sum(contains(prev, 'wug'))
                        repCount3 = repCount3 +1;
                        
                    if repCount3 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                            
                elseif sum(contains(curr, 'zad')) && sum(contains(prev, 'zad'))
                    repCount4 = repCount4 +1;

                    if repCount4 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                end
                
            elseif sum(contains(curr, 'moff')) && sum(contains(prev, 'moff'))
                repCount2 = repCount2 +1;
                
                if repCount2 > n_allowable_repetitions
                    success = 0;
                    break;
                end
                    
                if sum(contains(curr, 'blick')) && sum(contains(prev, 'blick'))
                    repCount1 = repCount1 +1;
                    
                    if repCount1 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                        
                elseif sum(contains(curr, 'wug')) && sum(contains(prev, 'wug'))
                        repCount3 = repCount3 +1;
                        
                    if repCount3 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                            
                elseif sum(contains(curr, 'zad')) && sum(contains(prev, 'zad'))
                    repCount4 = repCount4 +1;

                    if repCount4 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                end
                
            elseif sum(contains(curr, 'wug')) && sum(contains(prev, 'wug'))
                repCount3 = repCount3 +1;
                
                if repCount3 > n_allowable_repetitions
                    success = 0;
                    break;
                end
                    
                if sum(contains(curr, 'moff')) && sum(contains(prev, 'moff'))
                    repCount2 = repCount2 +1;
                    
                    if repCount2 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                        
                elseif sum(contains(curr, 'blick')) && sum(contains(prev, 'blick'))
                        repCount1 = repCount1 +1;
                        
                    if repCount1 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                            
                elseif sum(contains(curr, 'zad')) && sum(contains(prev, 'zad'))
                    repCount4 = repCount4 +1;

                    if repCount4 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                end
                
            elseif sum(contains(curr, 'zad')) && sum(contains(prev, 'zad'))
                repCount4 = repCount4 +1;
                
                if repCount4 > n_allowable_repetitions
                    success = 0;
                    break;
                end
                    
                if sum(contains(curr, 'moff')) && sum(contains(prev, 'moff'))
                    repCount2 = repCount2 +1;
                    
                    if repCount2 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                        
                elseif sum(contains(curr, 'wug')) && sum(contains(prev, 'wug'))
                        repCount3 = repCount3 +1;
                        
                    if repCount3 > n_allowable_repetitions
                        success = 0;
                        break;
                    end
                
                            
                elseif sum(contains(curr, 'blick')) && sum(contains(prev, 'blick'))
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