function output = create_all_pseudorandom_orders()

%array_1 = {'1', '1', '1', '2', '2', '2', '3', '3', '3', '4', '4', '4', '1', '1', '1', '2', '2', '2', '3', '3', '3', '4', '4', '4'};
%array_2 = {'2', '3', '4', '1', '3', '4', '1', '2', '4' ,'2' ,'3' ,'1', '2', '3', '4', '1', '3', '4', '1', '2', '4' ,'2' ,'3' ,'1'};

array_1 = {'1', '1', '1', '2', '2', '2', '3', '3', '3', '4', '4', '4'};
array_2 = {'2', '3', '4', '1', '3', '4', '1', '2', '4' ,'2' ,'3' ,'1'};

n_allowable_repetitions = 1;

master_array_vids = vertcat(array_1, array_2)';
master_array_combos = create_pseudorandom_order(master_array_vids,n_allowable_repetitions);

output = master_array_combos;

end