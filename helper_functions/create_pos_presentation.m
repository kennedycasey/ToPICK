function output = create_pos_presentation(array_to_order, n_allowable_repetitions, pos_number)

for i = 1:100000

    %n_allowable_repetitions = 6;
    %n_allowable_repetitions = 3;

    rand_array = array_to_order;

    %Create random array
    %rand_array_pos = horzcat(randi(2,1,24)', randi(2,1,24)');
    rand_array_pos = horzcat(randi(2,1,pos_number)', randi(2,1,pos_number)');

        for i = 1:length(rand_array_pos)
            if rand_array_pos(i,1) == 1
                rand_array_pos(i, 2) = 2;
            else
                rand_array_pos(i, 2) = 1;
            end
        end

        rand_array_pos = cellfun(@num2str, num2cell(rand_array_pos), 'UniformOutput',false);

         % Switch position of random arrays to reflect actual video
        % presentation
        for j = 1:length(rand_array_pos)
            if contains(rand_array_pos(j,1), '2')
                rand_array(j,[1,2]) = rand_array(j,[2,1]);
            end
        end

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
            curr = rand_array(j,:);

            if sum(contains(curr, '1')) 
                pos_array = contains(curr, '1');

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

                if sum(contains(curr, '2')) 
                    pos_array = contains(curr, '2');

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

                elseif sum(contains(curr, '3')) 
                    pos_array = contains(curr, '3');

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

                elseif sum(contains(curr, '4')) 
                    pos_array = contains(curr, '4');

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

           elseif sum(contains(curr, '2')) 
                pos_array = contains(curr, '2');

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

                if sum(contains(curr, '1')) 
                    pos_array = contains(curr, '1');

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

                elseif sum(contains(curr, '3')) 
                    pos_array = contains(curr, '3');

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

               elseif sum(contains(curr, '4')) 
                    pos_array = contains(curr, '4');

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

            elseif sum(contains(curr, '3')) 
                pos_array = contains(curr, '3');

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

                if sum(contains(curr, '1')) 
                    pos_array = contains(curr, '1');

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

                elseif sum(contains(curr, '2')) 
                    pos_array = contains(curr, '2');

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

                elseif sum(contains(curr, '4')) 
                    pos_array = contains(curr, '4');

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

            elseif sum(contains(curr, '4')) 
                pos_array = contains(curr, '4');

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

                if sum(contains(curr, '1')) 
                    pos_array = contains(curr, '1');

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

                elseif sum(contains(curr, '2')) 
                    pos_array = contains(curr, '2');

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

               elseif sum(contains(curr, '3')) 
                    pos_array = contains(curr, '3');

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
        end % end for loop

        if success == 1
           output = rand_array;
           break
        end
    end
end

