%w(uri cgi net/http yaml rubygems hpricot active_support).each { |f| require f }

$:.unshift(File.join(File.dirname(__FILE__)))
require 'twitter/version'
require 'twitter/easy_class_maker'
require 'twitter/base'
require 'twitter/user'
require 'twitter/search'
require 'twitter/status'
require 'twitter/direct_message'
require 'twitter/rate_limit_status'

module Twitter
  class Unavailable < StandardError; end
  class CantConnect < StandardError; end
  class BadResponse < StandardError; end
  class UnknownTimeline < ArgumentError; end
  class RateExceeded < StandardError; end

  SourceName = 'twittergem'
end

require 'xml/libxml'

module LibXML
  module XML
    class Document
      def search(expr)
        find("/descendant::#{expr}")
      end
      alias_method :/, :search
      
      def at(expr)
        find_first(expr)
      end
    end
    
    class Node
      def at(expr)
        find_first(expr)
      end
      
      def get_elements_by_tag_name(expr)
        find_first("/descendant::#{expr}")
      end
      
      def innerHTML
        content
      end
      alias_method :inner_html, :innerHTML
      alias_method :text, :innerHTML
    end
    
    module XPath
      class Object
        def search(expr)
          first ? first.at(expr.to_s) : self
        end
        alias_method :/, :search
        
        def text
          ''
        end
      end
    end
  end
end