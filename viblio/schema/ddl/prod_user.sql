create user 'prod' identified by 'prod';
grant all on prod.* to 'prod';
revoke drop on prod.* from 'prod';

