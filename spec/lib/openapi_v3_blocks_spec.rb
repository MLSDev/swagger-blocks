require 'json'
require 'swagger/blocks'

# TODO Test data originally based on the Swagger UI example data

RESOURCE_LISTING_JSON_V3 = open(File.expand_path('../openapi_v3_api_declaration.json', __FILE__)).read

class PetControllerV3
  include Swagger::Blocks

  swagger_root do
    key :openapi, '3.0.0'
    info version: '1.0.0' do
      key :title, 'OpenAPI Petstore'
      key :description, 'A sample API that uses a petstore as an example to ' \
                        'demonstrate features in the openapi-3.0.0 specification'
      key :termsOfService, 'http://helloreverb.com/terms/'
      contact do
        key :name, 'Wordnik API Team'
      end
      license do
        key :name, 'MIT'
      end
    end
    server do
      key :url, 'http://petstore.swagger.wordnik.com/api'
    end
    externalDocs description: 'Find more info here' do
      key :url, 'https://swagger.io'
    end
    tag name: 'pet' do
      key :description, 'Pets operations'
      externalDocs description: 'Find more info here' do
        key :url, 'https://swagger.io'
      end
    end
  end
end

describe 'Swagger::Blocks v3' do
  describe 'build_json' do
    it 'outputs the correct data' do
      swaggered_classes = [
          PetControllerV3,
          # PetV2,
          # ErrorModelV2
      ]
      actual = Swagger::Blocks.build_root_json(swaggered_classes)
      actual = JSON.parse(actual.to_json) # For access consistency.
      data = JSON.parse(RESOURCE_LISTING_JSON_V3)

      # Multiple expectations for better test diff output.
      expect(actual['info']).to eq(data['info'])
      expect(actual['paths']).to be
      expect(actual['paths']['/pets']).to be
      expect(actual['paths']['/pets']).to eq(data['paths']['/pets'])
      expect(actual['paths']['/pets/{id}']).to be
      expect(actual['paths']['/pets/{id}']['get']).to be
      expect(actual['paths']['/pets/{id}']['get']).to eq(data['paths']['/pets/{id}']['get'])
      expect(actual['paths']).to eq(data['paths'])
      expect(actual['definitions']).to eq(data['definitions'])
      expect(actual).to eq(data)
    end
    it 'is idempotent' do
      # swaggered_classes = [PetControllerV2, PetV2, ErrorModelV2]
      swaggered_classes = [PetControllerV3]
      actual = JSON.parse(Swagger::Blocks.build_root_json(swaggered_classes).to_json)
      data = JSON.parse(RESOURCE_LISTING_JSON_V3)
      expect(actual).to eq(data)
    end

    it 'errors if no swagger_root is declared' do
      expect {
        Swagger::Blocks.build_root_json([])
      }.to raise_error(Swagger::Blocks::DeclarationError)
    end

    it 'errors if multiple swagger_roots are declared' do
      expect {
        Swagger::Blocks.build_root_json([PetControllerV3, PetControllerV3])
      }.to raise_error(Swagger::Blocks::DeclarationError)
    end
  end
end
