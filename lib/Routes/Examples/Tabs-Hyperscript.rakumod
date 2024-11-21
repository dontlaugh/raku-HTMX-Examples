use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub tabs_hyperscript-routes() is export {

    route {
        template-location 'templates/tabs_hyperscript';

        get -> {
            template 'index.crotmp', {:tab<tab1>};
        }

        get -> 'tab1' {
            template 'index.crotmp', :fragment<tabs>, {:tab<tab1>};
        }

        get -> 'tab2' {
            template 'index.crotmp', :fragment<tabs>, {:tab<tab2>};
        }

        get -> 'tab3' {
            template 'index.crotmp', :fragment<tabs>, {:tab<tab3>};
        }
    }
}
