function output = create_test_pos_presentation(array_to_order)

    for i = 1:100000

        %n_allowable_repetitions = 6;
        n_allowable_repetitions = 2;

        rand_array = array_to_order;
        
        % Create randomized array for presentation, 1 = Switch, 2 = No
        % switch. Equal chances to switch across the 8 trials.
        %array = vertcat(ones(12, 1), zeros(12, 1));
        array = vertcat(ones(4, 1), zeros(4, 1));
        rand_array_pos = array(randperm(size(array, 1)), :);

        % Initialize counters
        repCount1L = 0;
        repCount1R = 0;
        repCount2L = 0;
        repCount2R = 0;
        repCount3L = 0;
        repCount3R = 0;
        repCount4L = 0;
        repCount4R = 0;
        success = 1;
        
        % Loop through the length of the array
        for j = 1:length(rand_array)
            % Current trial

            if rand_array_pos(j) == 1
                rand_array(j,[1,2]) = rand_array(j,[2,1]);
                curr = rand_array(j,:);

                if sum(contains(curr, 'blick')) 
                    pos_array = contains(curr, 'blick');

                    if pos_array(1) == 1
                        repCount1L = repCount1L +1;

                        if repCount1L > n_allowable_repetitions
                            success = 0;
                            disp('failure L')
                            break;
                        end

                    elseif pos_array(2) == 1
                        repCount1R = repCount1R +1;

                        if repCount1R > n_allowable_repetitions
                            success = 0;
                            disp('failure R')
                            break;
                        end
                    end

                    if sum(contains(curr, 'moff')) 
                        pos_array = contains(curr, 'moff');

                        if pos_array(1) == 1
                            repCount2L = repCount2L +1;

                            if repCount2L > n_allowable_repetitions
                                success = 0;
                                disp('failure 2L')
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount2R = repCount2R +1;

                            if repCount2R > n_allowable_repetitions
                                success = 0;
                                disp('failure 2r')
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'wug')) 
                        pos_array = contains(curr, 'wug');

                        if pos_array(1) == 1
                            repCount3L = repCount3L +1;

                            if repCount3L > n_allowable_repetitions
                                success = 0;
                                disp('failure3L')
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount3R = repCount3R +1;

                            if repCount3R > n_allowable_repetitions
                                success = 0;
                                disp('failure3r')
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'zad')) 
                        pos_array = contains(curr, 'zad');

                        if pos_array(1) == 1
                            repCount4L = repCount4L +1;

                            if repCount4L > n_allowable_repetitions
                                success = 0;
                                disp('failure4L')
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount4R = repCount4R +1;

                            if repCount4R > n_allowable_repetitions
                                success = 0;
                                disp('failure4R')
                                break;
                            end
                        end
                    end % end dependency search for video 1

               elseif sum(contains(curr, 'moff')) 
                    pos_array = contains(curr, 'moff');

                    if pos_array(1) == 1
                        repCount2L = repCount2L +1;

                        if repCount2L > n_allowable_repetitions
                            success = 0;
                            disp('failure 2L')
                            break;
                        end

                    elseif pos_array(2) == 1
                        repCount2R = repCount2R +1;

                        if repCount2R > n_allowable_repetitions
                            success = 0;
                            disp('failure 2r')
                            break;
                        end
                    end

                    if sum(contains(curr, 'blick')) 
                        pos_array = contains(curr, 'blick');

                        if pos_array(1) == 1
                            repCount1L = repCount1L +1;

                            if repCount1L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount1R = repCount1R +1;

                            if repCount1R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'wug')) 
                        pos_array = contains(curr, 'wug');

                        if pos_array(1) == 1
                            repCount3L = repCount3L +1;

                            if repCount3L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount3R = repCount3R +1;

                            if repCount3R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                   elseif sum(contains(curr, 'zad')) 
                        pos_array = contains(curr, 'zad');

                        if pos_array(1) == 1
                            repCount4L = repCount4L +1;

                            if repCount4L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount4R = repCount4R +1;

                            if repCount4R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end
                    end

                elseif sum(contains(curr, 'wug')) 
                    pos_array = contains(curr, 'wug');

                    if pos_array(1) == 1
                        repCount3L = repCount3L +1;

                        if repCount3L > n_allowable_repetitions
                            success = 0;
                            break;
                        end

                    elseif pos_array(2) == 1
                        repCount3R = repCount3R +1;

                        if repCount3R > n_allowable_repetitions
                            success = 0;
                            break;
                        end
                    end

                    if sum(contains(curr, 'blick')) 
                        pos_array = contains(curr, 'blick');

                        if pos_array(1) == 1
                            repCount1L = repCount1L +1;

                            if repCount1L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount1R = repCount1R +1;

                            if repCount1R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'moff')) 
                        pos_array = contains(curr, 'moff');

                        if pos_array(1) == 1
                            repCount2L = repCount2L +1;

                            if repCount2L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount2R = repCount2R +1;

                            if repCount2R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'zad')) 
                        pos_array = contains(curr, 'zad');

                        if pos_array(1) == 1
                            repCount4L = repCount4L +1;

                            if repCount4L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount4R = repCount4R +1;

                            if repCount4R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end
                    end

                elseif sum(contains(curr, 'zad')) 
                    pos_array = contains(curr, 'zad');

                    if pos_array(1) == 1
                        repCount4L = repCount4L +1;

                        if repCount4L > n_allowable_repetitions
                            success = 0;
                            break;
                        end

                    elseif pos_array(2) == 1
                        repCount4R = repCount4R +1;

                        if repCount4R > n_allowable_repetitions
                            success = 0;
                            break;
                        end
                    end

                    if sum(contains(curr, 'blick')) 
                        pos_array = contains(curr, 'blick');

                        if pos_array(1) == 1
                            repCount1L = repCount1L +1;

                            if repCount1L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount1R = repCount1R +1;

                            if repCount1R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'moff')) 
                        pos_array = contains(curr, 'moff');

                        if pos_array(1) == 1
                            repCount2L = repCount2L +1;

                            if repCount2L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount2R = repCount2R +1;

                            if repCount2R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                   elseif sum(contains(curr, 'wug')) 
                        pos_array = contains(curr, 'wug');

                        if pos_array(1) == 1
                            repCount3L = repCount3L +1;

                            if repCount3L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount3R = repCount3R +1;

                            if repCount3R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end
                    end
                end
                    
            elseif rand_array_pos(j) == 0
                
                curr = rand_array(j,:);
                                
                if sum(contains(curr, 'blick')) 
                    pos_array = contains(curr, 'blick');

                    if pos_array(1) == 1
                        repCount1L = repCount1L +1;

                        if repCount1L > n_allowable_repetitions
                            success = 0;
                            disp('failure L')
                            break;
                        end

                    elseif pos_array(2) == 1
                        repCount1R = repCount1R +1;

                        if repCount1R > n_allowable_repetitions
                            success = 0;
                            disp('failure R')
                            break;
                        end
                    end

                    if sum(contains(curr, 'moff')) 
                        pos_array = contains(curr, 'moff');

                        if pos_array(1) == 1
                            repCount2L = repCount2L +1;

                            if repCount2L > n_allowable_repetitions
                                success = 0;
                                disp('failure 2L')
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount2R = repCount2R +1;

                            if repCount2R > n_allowable_repetitions
                                success = 0;
                                disp('failure 2r')
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'wug')) 
                        pos_array = contains(curr, 'wug');

                        if pos_array(1) == 1
                            repCount3L = repCount3L +1;

                            if repCount3L > n_allowable_repetitions
                                success = 0;
                                disp('failure3L')
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount3R = repCount3R +1;

                            if repCount3R > n_allowable_repetitions
                                success = 0;
                                disp('failure3r')
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'zad')) 
                        pos_array = contains(curr, 'zad');

                        if pos_array(1) == 1
                            repCount4L = repCount4L +1;

                            if repCount4L > n_allowable_repetitions
                                success = 0;
                                disp('failure4L')
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount4R = repCount4R +1;

                            if repCount4R > n_allowable_repetitions
                                success = 0;
                                disp('failure4R')
                                break;
                            end
                        end
                    end % end dependency search for video 1

               elseif sum(contains(curr, 'moff')) 
                    pos_array = contains(curr, 'moff');

                    if pos_array(1) == 1
                        repCount2L = repCount2L +1;

                        if repCount2L > n_allowable_repetitions
                            success = 0;
                            disp('failure 2L')
                            break;
                        end

                    elseif pos_array(2) == 1
                        repCount2R = repCount2R +1;

                        if repCount2R > n_allowable_repetitions
                            success = 0;
                            disp('failure 2r')
                            break;
                        end
                    end

                    if sum(contains(curr, 'blick')) 
                        pos_array = contains(curr, 'blick');

                        if pos_array(1) == 1
                            repCount1L = repCount1L +1;

                            if repCount1L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount1R = repCount1R +1;

                            if repCount1R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'wug')) 
                        pos_array = contains(curr, 'wug');

                        if pos_array(1) == 1
                            repCount3L = repCount3L +1;

                            if repCount3L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount3R = repCount3R +1;

                            if repCount3R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                   elseif sum(contains(curr, 'zad')) 
                        pos_array = contains(curr, 'zad');

                        if pos_array(1) == 1
                            repCount4L = repCount4L +1;

                            if repCount4L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount4R = repCount4R +1;

                            if repCount4R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end
                    end

                elseif sum(contains(curr, 'wug')) 
                    pos_array = contains(curr, 'wug');

                    if pos_array(1) == 1
                        repCount3L = repCount3L +1;

                        if repCount3L > n_allowable_repetitions
                            success = 0;
                            break;
                        end

                    elseif pos_array(2) == 1
                        repCount3R = repCount3R +1;

                        if repCount3R > n_allowable_repetitions
                            success = 0;
                            break;
                        end
                    end

                    if sum(contains(curr, 'blick')) 
                        pos_array = contains(curr, 'blick');

                        if pos_array(1) == 1
                            repCount1L = repCount1L +1;

                            if repCount1L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount1R = repCount1R +1;

                            if repCount1R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'moff')) 
                        pos_array = contains(curr, 'moff');

                        if pos_array(1) == 1
                            repCount2L = repCount2L +1;

                            if repCount2L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount2R = repCount2R +1;

                            if repCount2R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'zad')) 
                        pos_array = contains(curr, 'zad');

                        if pos_array(1) == 1
                            repCount4L = repCount4L +1;

                            if repCount4L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount4R = repCount4R +1;

                            if repCount4R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end
                    end

                elseif sum(contains(curr, 'zad')) 
                    pos_array = contains(curr, 'zad');

                    if pos_array(1) == 1
                        repCount4L = repCount4L +1;

                        if repCount4L > n_allowable_repetitions
                            success = 0;
                            break;
                        end

                    elseif pos_array(2) == 1
                        repCount4R = repCount4R +1;

                        if repCount4R > n_allowable_repetitions
                            success = 0;
                            break;
                        end
                    end

                    if sum(contains(curr, 'blick')) 
                        pos_array = contains(curr, 'blick');

                        if pos_array(1) == 1
                            repCount1L = repCount1L +1;

                            if repCount1L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount1R = repCount1R +1;

                            if repCount1R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                    elseif sum(contains(curr, 'moff')) 
                        pos_array = contains(curr, 'moff');

                        if pos_array(1) == 1
                            repCount2L = repCount2L +1;

                            if repCount2L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount2R = repCount2R +1;

                            if repCount2R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end

                   elseif sum(contains(curr, 'wug')) 
                        pos_array = contains(curr, 'wug');

                        if pos_array(1) == 1
                            repCount3L = repCount3L +1;

                            if repCount3L > n_allowable_repetitions
                                success = 0;
                                break;
                            end

                        elseif pos_array(2) == 1
                            repCount3R = repCount3R +1;

                            if repCount3R > n_allowable_repetitions
                                success = 0;
                                break;
                            end
                        end
                    end

            else % If we break out of the loop, reset the counters
                repCount1L = 0;
                repCount1R = 0;
                repCount2L = 0;
                repCount2R = 0;
                repCount3L = 0;
                repCount3R = 0;
                repCount4L = 0;
                repCount4R = 0;

            	end % end video search
            end
        end % end for loop

        if success == 1
           rand_array_pos = num2cell(rand_array_pos);
           test_array = horzcat(rand_array, rand_array_pos);
           output = test_array;
           break
        end
    end
end

