use Cro::HTTP::Router;
use Cro::WebApp::Template;

my constant $location = 'templates';
my constant $base = $*PROGRAM.parent.parent.parent.parent.add($location);

#| API for an HTML::Component that uses the Cro::WebApp cro template
#| mechanism, each component has one static cro template file that is
#| registered with the Cro::Template::Repository when it is instantiated.
#|
#| Such a component is typically followed with an exported route block
#| that instantiates it and then publishes its associated routes
role HTML::Component::CroTmp {
    has $.namespace = 'HTML-Component';

    #| get the template Str
    method template {...}

    #| the template name for use in a route block
    method crotmp {...}

    #| each component may have an action that calls a sub
    #| or fragment declared in its template
    method action {...}

    #| write the crotmp files to the repo
    method register {...}

}

class Thing does HTML::Component::CroTmp {
    has $.crotmp;

    has $.action;
    has $.caller;

    has $.data = { :foo<hello>, :bar<world> };

    submethod TWEAK {
        $!crotmp = $!namespace ~ '-' ~ self.^name ~ '.crotmp';

        $!caller = q|<:use '| ~ $!crotmp ~ q|'> <&fn()>|;
        $!action = $!namespace ~ '-' ~ self.^name ~ '-action.crotmp';
    }

    method template {
        q:to/END/;
            <.foo>, <.bar>

            <:sub fn()>Did you call me?</:>
            <a href="/template_register/call_me">Call Me</a>

            <:fragment fn($_)><?.show>Did you frag me?</?></:>
            <a href="/template_register/frag_me">Frag Me</a>
        END
    }

    method register {
        $base.add($!crotmp).IO.spurt: $.template;
        $base.add($!action).IO.spurt: $!caller;
    }
}


sub template_register-routes() is export {

    my $thing = Thing.new;

    route {
        $thing.register;
        template-location $location;

        get -> {
            template $thing.crotmp, $thing.data;
        }

        get -> 'call_me'  {
            template $thing.action;
        }

        get -> 'frag_me'  {
            template $thing.crotmp, :fragment<fn>, {:show};
        }
    }
}




