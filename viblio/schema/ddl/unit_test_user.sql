create user 'unit_test' identified by 'unit_test';
grant all on unit_test.* to 'unit_test';
revoke drop on unit_test.* from 'unit_test';
