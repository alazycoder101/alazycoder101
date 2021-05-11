-- show type of field
select pg_typeof('[{"type":"phone","value":"+1-202-345-6789"}]');
select pg_typeof('[{"type":"phone","value":"+1-202-345-6789"}]'::jsonb);

-- set jsonb element
select jsonb_set('[{"type":"phone","value":"+1-202-345-6789"},{"type":"email","value":"test@gmail.com"}]', '{1,value}','"test2@gmail.com"',false);

-- array length in jsonb
select jsonb_array_length('[{"value":1}]');
select jsonb_array_length('{"students":[{"name":"a"}]}'->students);
