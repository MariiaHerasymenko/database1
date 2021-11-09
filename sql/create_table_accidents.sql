create table accidents(
  accident_id int primary key auto_increment,   
  alien_id int,
  witness_id int,
  location_id int,
  constraint fk_aliens foreign_key(alien_id) references aliens(alien_id),
  constraint fk_witnesses foreign_key(witness_id) references witnesses(witness_id),
  constraint fk_locations foreign_key(location) references locations(location_id)
);

