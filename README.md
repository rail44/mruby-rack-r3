# mruby-r3
R3 router binding

## install by mrbgems

- add conf.gem line to `build_config.rb`

```ruby
MRuby::Build.new do |conf|
    conf.gem :github => 'rail44/mruby-rack-r3'
end
```

## example

```ruby
class App
  include Rack::R3
  get "/hoge/{id}" do |id|
    [200,
     {'content-type' => 'text/plain; charset=utf-8'},
     ["your id is #{id}"]
    ];
  end

  post "/hoge/{id}/{message}" do |id, message|
    [200,
     {'content-type' => 'text/plain; charset=utf-8'},
     ["post message '#{message}' for #{id}"]
    ];
  end

  get "/fuga" do
    [200,
     {'content-type' => 'text/plain; charset=utf-8'},
     ["Fuga World!"]
    ];
  end
end

app = App.new
p app.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/hoge/123'})
# => [200, {"content-type"=>"text/plain; charset=utf-8"}, ["your id is 123"]]
p app.call({'REQUEST_METHOD' => 'POST', 'PATH_INFO' => '/hoge/123/wiwi'})
# => [200, {"content-type"=>"text/plain; charset=utf-8"}, ["post message 'wiwi' for 123"]]
p app.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/fuga'})
# => [200, {"content-type"=>"text/plain; charset=utf-8"}, ["Fuga World!"]]
p app.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/notfound'})
# => [404, {"content-type"=>"text/plain; charset=utf-8"}, ["Not Found"]]
```

## License
under the MIT License:
- see LICENSE file
