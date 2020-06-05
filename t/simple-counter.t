use v6;

use Test;

use Prometheus::Client :metrics;
use Prometheus::Client::Exposition :render;

my $counter;
my $m = BEGIN METRICS {
    $counter = counter(
        name => 'm1',
        documentation => 'doc',
        :simple
    );
}


for 1..5 {
    $counter.inc;

    is render-metrics($m), qq:to/END_OF_EXPECTED/;
        # HELP m1 doc
        # TYPE m1 counter
        m1 $_
        END_OF_EXPECTED
}

done-testing;
