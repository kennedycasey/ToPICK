function output = create_ext_order()

%array_1 = {'1', '1', '1', '2', '2', '2', '3', '3', '3', '4', '4', '4', '1', '1', '1', '2', '2', '2', '3', '3', '3', '4', '4', '4'};
%array_2 = {'2', '3', '4', '1', '3', '4', '1', '2', '4' ,'2' ,'3' ,'1', '2', '3', '4', '1', '3', '4', '1', '2', '4' ,'2' ,'3' ,'1'};

array_1 = {'1', '3', '4', '2', '1', '3', '4', '2'};
array_2 = {'2', '4', '1', '3', '2', '4', '1', '3'};

master_array_ext_vids = vertcat(array_1, array_2)';
master_array_ext_combos = create_pseudorandom_order(master_array_ext_vids, 1);

output = master_array_ext_combos;

end