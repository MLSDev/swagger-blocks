module Swagger
  module Blocks
    module Nodes
      # v2.0: https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#tagObject
      # v3.0.0: https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#tagObject
      class TagNode < Node

        # TODO support ^x- Vendor Extensions

        def externalDocs(inline_keys = nil, &block)
          self.data[:externalDocs] = Swagger::Blocks::Nodes::ExternalDocsNode.call(version: version, inline_keys: inline_keys, &block)
        end
      end
    end
  end
end
