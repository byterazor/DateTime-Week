#===============================================================================
#
#  FILE:        Week.pm
#
#  DESCRIPTION: Creates DateTime Objects according to a given week,year and weekday combination
#
#  AUTHOR:      Dominik Meyer <dmeyer@federationhq.de>
#  VERSION:     0.0.1
#  CREATED:     24.10.2011 19:33:57 CET
#===============================================================================
package DateTime::Week;
use Moose;
use DateTime;

# class attributes
has 'year' => (is => 'rw', isa => 'Int',required => 1);
has 'week' => (is => 'rw', isa => 'Int',required => 1);
has 'weekday' => (is => 'rw', isa => 'Int',required => 1);

# return datetime object 
sub get_date {
    my $self=shift;
    
    # first get us the 4th january of the required year because it is always
    # in the first week of the year
    # http://www.salesianer.de/util/kalwoch.html    
    my $dt = DateTime->new(
             year       => $self->year,
             month      => 1,
             day        => 4,
         ); 
         
    # lets look which weekday we got
    my $dow    = $dt->day_of_week;    # 1-7 (Monday is 1)     
    
    #adjust day
    if ($dow > $self->weekday) {
      $dt->subtract(days=>$dow-$self->weekday);  
    } elsif ($dow < $self->weekday) {
      $dt->add(days=>$self->weekday-$dow);  
    }
    
    #now adjust weeks
    $dt->add(days => ($self->week-1)*7);
    
    return $dt;
}

1;
__END__

=head1 NAME

DateTime::Week - Creates DateTime Objects according to a given week,year and weekday combination

=head1 VERSION

This documentation refers to DateTime::Week version 0.0.1.

=head1 SYNOPSIS

   use DateTime::Week;

   my $dt_week = DateTime::Week->new( 'year'    => 2011,
                                      'week'    => 6,
                                      'weekday' => 1
    );
    
    print $dt_week->get_date()->dmy();  # generate the dt object and output it in dmy format

=head1 DESCRIPTION

This Class just calculates a date from a given year, week and weekday set.

=head1 SUBROUTINES/METHODS

=head2 get_date
    
just returns the DateTime Object

=head1 DEPENDENCIES

    Moose
    DateTime

=head1 INCOMPATIBILITIES

none known yet

=head1 BUGS AND LIMITATIONS

none known yet

=head1 AUTHOR

Dominik Meyer  (dmeyer@federationhq.de)

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2011 Dominik Meyer (dmeyer@federationhq.de).
All rights reserved.

This is free software, licensed under: GPLv2







