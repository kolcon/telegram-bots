use 5.010;
use strict;

use Data::Dumper;
use JSON;

return main_app();

sub main_app {
    my $app = sub {
        my $env = shift;

        my $status = 200;
        my $headers = [
            'Content-Type' => 'text/plain',
        ];
        my $body = '';

        my $path = $env->{PATH_INFO};
        say "GET $path";
        say Dumper($env);

        my $input = $env->{'psgi.input'};
        my $json = join '', <$input>;
        say $json;

        my $data = from_json($json);
        say Dumper($data);

        return [$status, $headers, [$body]];
    };

    return $app;
}
