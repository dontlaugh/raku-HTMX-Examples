use Cro::HTTP::Router;
use Cro::WebApp::Template;

my constant $base = $*PROGRAM.parent.add('templates');

class Component {
    my $template = q:to/END/;
        <.foo>, <.bar>
        <:sub fn()>Did you call me?</:>
        <a href="/template_register/call_me">Call Me</a>
        END

    my $data = { foo => 'hello', bar => 'world' };

    my $filename = 'registerme.crotmp';


    submethod TWEAK {
        $template.spurt: $base.add($filename);
        render-template($base.add($filename), {});
    }


    sub template_register-routes() is export {
        route {
            get -> {
                template-inline $template, $data;
            }

            get -> 'call_me'  {
                template-inline '<&fn()>', { };
            }
        }
    }

}




