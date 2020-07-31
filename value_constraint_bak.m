function cim = value_constraint(im, oim, range);

cim = max(min(oim + dim, 255), 0);
dim = max(min(im - oim, range), -range);

return;