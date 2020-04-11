RSpec.describe Twofold do
  it "has a version number" do
    expect(Twofold::VERSION).not_to be nil
  end

  it "runs readme example" do
    source = <<~'TWOFOLD'
      def self.greet_method(name, greet)
                          |def greet_#{name}(name)
                          |  puts("#{greet} \#{name}")
                          |end
        return # be careful what you return.
      end
                          |class Greeters
      methods.each do |method|
                          =  greet_method(method[:name], method[:greet])
      end
                          |end
    TWOFOLD
    tpl = Twofold::Template.new('readme.twofold') { source }
    locals = {
        methods: [
            { name: "world", greet: "Hello World of" },
            { name: "tag", greet: "Guten Tag" },
        ]
    }
    expect(tpl.render(Object.new, locals)).to eq(<<~'CODE')
      class Greeters
        def greet_world(name)
          puts("Hello World of #{name}")
        end
        def greet_tag(name)
          puts("Guten Tag #{name}")
        end
      end
    CODE
  end

  it "runs complex example" do
    source = <<~'TWOFOLD'
      def self.method_args(args)
        args.each_with_index do |arg, i|
          if 0!=i
                                      \#{', '}
          end
                                      \#{arg}
        end
        return
      end
      def self.show_method(method)
                                      |function #{method[:name]}(#{method_args(method[:args])}) {
                                      |  #{method[:body]}
                                      |}
        return
      end
                                      |function #{name}(#{method_args(args)}) {
      methods.each do |method|
                                      =  show_method(method)
      end
                                      |
                                      |  return {
      methods.each_with_index do |method, i|
                                      |    "#{method[:name]}": #{method[:name]}#{(i + 1 < methods.length) ? ',' : ''}
      end
                                      |  };
                                      |}
    TWOFOLD
    tpl = Twofold::Template.new('test.twofold') { source }
    locals = {
        name: "TwofoldGenerated",
        args: [],
        methods: [
            {
                name: "hello",
                args: %w(greeted post),
                body: "console.log('Hello ' + greeted);"
            }
        ]
    }
    expect(tpl.render(Object.new, locals)).to eq(<<~'CODE')
      function TwofoldGenerated() {
        function hello(greeted, post) {
          console.log('Hello ' + greeted);
        }
      
        return {
          "hello": hello
        };
      }
    CODE
  end

end
