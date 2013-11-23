create user 'test' identified by 'test';
grant all on test.* to 'test';
revoke drop on test.* from 'test';
