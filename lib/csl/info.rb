module CSL
  
  class Info < Node

    attr_children :title, :'title-short', :id, :issn, :eissn, :issnl,
      :link, :author, :contributor, :category, :published, :summary,
      :updated, :rights, :'link-dependent-style'
    
    alias_child :contributors, :contributor
    alias_child :authors, :contributor
    alias_child :links, :link
    
    def initialize(attributes = {})
      super(attributes, &nil)
      children[:link], children[:author], children[:contributor] = [], [], []

      yield self if block_given?
    end
    
    # @!method self_link
    # @return [String,nil] the style's URI

    # @!method template_link
    # @return [String,nil] URI of the style from which the current style is derived
    
    # @!method documentation_link
    # @return [String,nil] URI of style documentation
    [:self, :template, :documentation].each do |type|
      method_id = "#{type}_link"
      
      define_method method_id do
        link = links.detect { |l| l.match? :rel => type.to_s }
        link.nil? ? nil : link[:href]
      end
      
      alias_method "has_#{method_id}?", method_id
    end
    
    class Contributor < Node
      attr_children :name, :email, :uri
    end
    
    class Author < Node
      attr_children :name, :email, :uri
    end
    
    class Translator < Node
      attr_children :name, :email, :uri
    end
    
    class Link < Node
      attr_struct :href, :rel
    end

    class DependentStyle < TextNode
      attr_struct :href, :rel
    end


    class Category < Node
      attr_struct :field, :'citation-format'
    end    

    class Id < TextNode
    end
    
    class Name < TextNode
    end
    
    class Email < TextNode
    end

    class Title < TextNode
    end

    class ShortTitle < TextNode
    end

    class Summary < TextNode
    end
    
    class Rights < TextNode
    end

    class Uri < TextNode
    end

    class Updated < TextNode
    end

  end
    
  
end