use strict;

use Test::MockTime qw( :all );

use Test::More;
use Time::Piece;

{
    package t::Teng;

    use parent 'Teng';
    use Any::Moose;
    with 'Teng::Role::TimePiece';
    with 'Teng::Role::TimeStamp';

    no warnings qw(once);
    $Teng::Role::TimePiece::STRPTIME_FORMAT = '%Y-%m-%dT%H:%M:%S';

    package t::Teng::Schema;
    use Teng::Schema::Declare;

    table {
        name 'foo';
        pk 'id';
        columns qw(id created_at updated_at);
    };
}
my $m = new_ok 't::Teng', [ connect_info => [ 'dbi:SQLite:', '', '' ] ];

$_->Teng::do(
    'CREATE TABLE foo ( id INT AUTO_INCREMENT PRIMARY KEY, created_at DATETIME, updated_at DATETIME )')
    for $m;

my $time = localtime;
$m->insert(foo => { id => 1});

my $r = $m->single('foo');

ok $r;
ok $r->created_at eq $r->updated_at;

set_relative_time(2);

$r->update({
    id => 2,
});

$r = $r->refetch;

ok $r->updated_at ne $r->created_at;

done_testing;
