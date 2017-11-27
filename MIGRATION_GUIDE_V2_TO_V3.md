Howto migrate Swagger V2 to V3:

* Change `swagger: '2.0'` to `openapi: '3.0.0'`:

Before:

```ruby
class PetController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
  end
end
```

After:

```ruby
class PetController
  include Swagger::Blocks

  swagger_root do
    key :openapi, '3.0.0'
  end
end
```

* Options `host`, `basePath` and `schemes` moves to `server` object.

Before:

```ruby
class PetController
  include Swagger::Blocks

  swagger_root host: 'petstore.swagger.wordnik.com' do
    key :basePath, '/api'
    key :schemes, ['http']
  end
end
```

After:

```ruby
class PetController
  include Swagger::Blocks

  swagger_root do
    server do
      key :url, 'http://petstore.swagger.wordnik.com/api'
    end
  end
end
```

* `consumes` and `produces` moves down in components.

