package Teng::Role::TimeStamp;
use strict;
use warnings;
our $VERSION = '0.01';

use Any::Moose '::Role';

use Time::Piece;

before _update => sub {
    my ($self, $table_name, $args, $where) = @_;

    my $table = $self->schema->get_table($table_name);

    my $localtime = localtime;
    if ($table->row_class->can('updated_at')) {
        $args->{updated_at} = $localtime->datetime;
    }
};

before _insert => sub {
    my ($self, $table_name, $args, $where) = @_;

    my $table = $self->schema->get_table($table_name);

    my $localtime = localtime;
    if ($table->row_class->can('created_at')) {
        $args->{created_at} = $localtime->datetime;
    }

    if ($table->row_class->can('updated_at')) {
        $args->{updated_at} = $localtime->datetime;
    }
};


1;
__END__

=head1 NAME

Teng::Role::TimeStamp - current time is set to a "created_at" or "updated_at"

=head1 SYNOPSIS

  use parent 'Teng';
  use Any::Moose;
  with 'Teng::Role::TimePiece';
  with 'Teng::Role::TImeStamp';

=head1 DESCRIPTION

=head1 AUTHOR

Shinichiro Sei E<lt>shin1rosei@kayac.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (c) 2012 KAYAC Inc. All rights reserved.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
