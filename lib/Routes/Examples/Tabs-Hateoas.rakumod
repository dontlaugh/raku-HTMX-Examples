use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub tabs_hateoas-routes() is export {

    route {
        template-location 'templates/tabs_hateoas';

        get -> {
            template 'index.crotmp', {:tab<tab1>};
        }

        get -> $tab where /^ tab\d $/ {
            template 'index.crotmp', :fragment<tabs>, {:$tab};
        }
    }
}
