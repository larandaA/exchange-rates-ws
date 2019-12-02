require "kemal"

before_all do |env|
  env.response.content_type = "application/json"
end

error 404 do |env|
  path = env.request.path
  {"error": "This path does not exist: #{path}"}.to_json
end

get "/hello/:word" do |env|
  word = env.params.url["word"]
  {"hello": word}.to_json
end

Kemal.run
