use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub inline_validation-routes() is export {

    route {
        template-location 'templates/inline_validation';

        get -> {
            template 'index.crotmp';
        }

        post -> 'contact' {
            template 'index.crotmp';
        }

        post -> 'contact', 'email'  {
            my $data;

            request-body -> %fields {
                $data<email> = %fields<email>,
            }

            given $data<email> {
                when * eq 'test@test.com' {
                    template 'index.crotmp', :fragment<partial>, $data;
                }
                when /\S+ \@ \S+ \. \S+/ {
                    $data<taken> = True;
                    template 'index.crotmp', :fragment<partial>, $data;
                }
                default {
                    $data<invalid> = True;
                    template 'index.crotmp', :fragment<partial>, $data;
                }
            }
        }
    }
}
