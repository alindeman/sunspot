module Sunspot
  module DSL
    class FieldGroup
      def initialize(query, setup, group)
        @query, @setup, @group = query, setup, group
      end

      #
      # Sets the number of results (documents) to return for each group.
      # Defaults to 1.
      #
      def limit(num)
        @group.limit = num
      end

      #
      # group.truncate
      # true/false
      # If true, facet counts are based on the most relevant document of each 
      # group matching the query. Same applies for StatsComponent. Default is 
      # false.  Solr3.4 Supported from Solr 3.4 and up.
      #
      def truncate(trunc = false)
        @group.truncate = trunc
      end
      
      #
      # group.format
      # grouped/simple
      # if simple, the grouped documents are presented in a single flat list.
      # The start and rows parameters refer to numbers of documents instead
      # of numbers of groups.
      #
      def gformat(gformat)
        #formats = %w(grouped simple)
        @group.gformat = gformat
      end
      
      # 
      # group.main
      # true/false
      # If true, the result of the first field grouping command is used as 
      # the main result list in the response, using group.format=simple
      #
      def main(gmain = false)
        @group.main = gmain
      end

      #
      # group.ngroups
      # true/false
      # If true, includes the number of groups that have matched the query.
      # Default is false.
      #
      def ngroups(ngroups = false)
        @group.ngroups = ngroups
      end

      # Specify the order that results should be returned in. This method can
      # be called multiple times; precedence will be in the order given.
      #
      # ==== Parameters
      #
      # field_name<Symbol>:: the field to use for ordering
      # direction<Symbol>:: :asc or :desc (default :asc)
      #
      def order_by(field_name, direction = nil)
        sort =
          if special = Sunspot::Query::Sort.special(field_name)
            special.new(direction)
          else
            Sunspot::Query::Sort::FieldSort.new(
              @setup.field(field_name), direction
            )
          end
        @group.add_sort(sort)
      end
    end
  end
end
