use inc::Module::Install;
name 'Teng-Role-TimeStamp';
all_from 'lib/Teng/Role/TimeStamp.pm';

requires 'Any::Moose';
requires 'Teng';
requires 'Teng::Role::TimePiece';
test_requires 'Test::MockTime';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
