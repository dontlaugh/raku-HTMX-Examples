use Cro::HTTP::Router;
use Cro::WebApp::Template;

#some exploratory code to do node behaviour
role Node {
    has Str  $.id       is rw;    # Unique ID for the node
    has Node $.parent   is rw;
    has Node @.children is rw;

method add-child(Node $child) {
    $child.parent = self;
    $child.id = self.child-id($child);
    @!children.push($child);
}

method remove-child(Node $child) {
    @!children .= grep({ $_ !=:= $child });
    $child.parent = Nil;
    $child.id = Nil;
    self.update-child-ids;    # Ensure remaining children have correct IDs
}

# Update IDs for all children based on their position
method update-child-ids {
    for @!children.kv -> $index, $child {
        $child.id = self.id ~ '/' ~ ($index + 1);
        $child.update-child-ids; # Recursively update grandchildren
    }
}

# Generate a path-based unique ID for a child
method child-id(Node $child --> Str) {
    return self.id ~ '/' ~ (@!children.elems);
}

method call-on-children(Str $method, *@args) {
    @!children.map: {
        $_."$method"(|@args) if $_.can($method);
    }
}

method call-deepmap(Str $method, Int :$indent = 4 --> Str) {
    my $content = self."$method"();
    my $child-content = @!children.map({
        $_.call-deepmap($method, :$indent)
    }).join("\n");
    return $content ~ ($child-content ?? "\n" ~ $child-content.indent($indent) !! '');
}

# Find a node by path
method find(Str $path --> Node) {
    return self if $path eq self.id;
    for @!children -> $child {
        my $result = $child.find($path);
        return $result if $result;
    }
    Nil;
}

method Str {
    self.id ~ ':' ~ self.name;
}
}

class TreeNode does Node {
    has Str $.name;

    method body {
        q|<div class="grid-item">1</div>|
    }
}

# Root node
my $root = TreeNode.new(name => 'root', id => '0');

# Add children
my $child0 = TreeNode.new(name => 'child0');
my $child1 = TreeNode.new(name => 'child1');
my $child2 = TreeNode.new(name => 'child2');
my $child3 = TreeNode.new(name => 'child3');
my $child4 = TreeNode.new(name => 'child4');
my $child5 = TreeNode.new(name => 'child5');

$root.add-child($child0);
$root.add-child($child1);
$root.add-child($child2);
$root.add-child($child3);
$root.add-child($child4);
$root.add-child($child5);

# Add a grandchild
#my $grandchild = TreeNode.new(name => 'grandchild');
#$child1.add-child($grandchild);

# Call a method on all children of the root
#say $root.call-on-children('body');

# Find a node by path
my $found = $root.find('0/1');
if $found {
    say "Found node: ", $found.name; # Outputs: Found node: child1
}

say $root.call-deepmap('body');

# Remove a child
#$root.remove-child($child1);
#say "Children of root: ", $root.children.elems; # Outputs: Children of root: 1


sub template_node1-routes() is export {

    route {
        get -> {
            template-inline '<.foo>, <.bar>', { foo => 'hello', bar => 'world'};
        }
    }
}
