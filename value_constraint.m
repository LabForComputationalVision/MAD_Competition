function cim = value_constraint(im, oim, range);

cim = max(min(im, 255), 0);
dim = max(min(cim - oim, range), -range);
cim = oim + dim;

return;