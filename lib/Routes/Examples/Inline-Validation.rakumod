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

            sub check($_) {
                when * eq 'test@test.com' { 'valid'   }
                when /\S+ \@ \S+ \. \S+/  { 'taken'   }
                default                   { 'invalid' }
            }

            my $data;

            request-body -> %fields {
                $data<email> = %fields<email>
            }

            $data<status> = check $data<email>;

            template 'index.crotmp', :fragment<partial>, $data;
        }
    }
}
