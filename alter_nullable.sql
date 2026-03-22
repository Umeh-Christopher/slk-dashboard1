-- Make price fields optional
alter table trades alter column entry drop not null;
alter table trades alter column sl drop not null;
alter table trades alter column tp1 drop not null;
alter table trades alter column tp2 drop not null;
alter table trades alter column tp3 drop not null;
