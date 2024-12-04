use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub template_register-routes() is export {

    route {
        get -> {
            template-inline '<.foo>, <.bar>', { foo => 'hello', bar => 'world'};
        }
    }
}
