use Cro::HTTP::Router;
use Cro::WebApp::Template;

my constant $location = 'templates';
my constant $base = $*PROGRAM.parent.parent.parent.parent.add($location);

class Component {
    has $.template = q:to/END/;
        <.foo>, <.bar>
        <:sub fn()>Did you call me?</:>
        <a href="/template_register/call_me">Call Me</a>
        <:fragment fn($_)><?.show>Did you frag me?</?></:>
        <a href="/template_register/frag_me">Frag Me</a>
        END

    has $.caller = q|<:use 'registerme.crotmp'><&fn()>|;

    has $.data = { foo => 'hello', bar => 'world' };

    has $.filename = 'registerme.crotmp';


    method register {
        $base.add($!filename).IO.spurt: $!template;
        $base.add('caller.crotmp').IO.spurt: $!caller;
    }
}


sub template_register-routes() is export {

    my $c = Component.new;

    route {
        $c.register;
        template-location $location;

        get -> {
            template 'registerme.crotmp', $c.data;
#                template-inline '<.foo>, <.bar>', { foo => 'hello', bar => 'world'};
        }

        get -> 'call_me'  {
            template 'caller.crotmp';
        }

        get -> 'frag_me'  {
            template 'registerme.crotmp', :fragment<fn>, {:show};
            template-inline $c.template, :fragment<fn>, {:show};
        }
    }
}




