use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub routes() is export {
    route {
        template-location 'templates';

        get -> {
            template 'index.crotmp';
        }

        get -> *@path {
            static 'static', @path;
        }

        use Routes::Examples::Click-To-Edit;
        include click_to_edit => click_to_edit-routes;

        use Routes::Examples::Template-Inline;
        include template_inline => template_inline-routes;

        use Routes::Examples::Template-Register;
        include template_register => template_register-routes;

        use Routes::Examples::Template-Node1;
        include template_node1 => template_node1-routes;
    }
}
