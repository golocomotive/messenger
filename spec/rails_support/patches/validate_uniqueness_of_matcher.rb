module Shoulda
  module Matchers
    module ActiveModel
      class ValidateUniquenessOfMatcher < ValidationMatcher
        def validate_after_scope_change?
          if @options[:scopes].blank?
            true
          else
            all_records = @subject.class.all
            @options[:scopes].all? do |scope|
              previous_value = all_records.map(&scope).max

              # Assume the scope is a foreign key if the field is nil
              previous_value ||= correct_type_for_column(@subject.class.columns_hash[scope.to_s])

              next_value =
                if @subject.class.respond_to?(:defined_enums) && @subject.defined_enums[scope.to_s]
                  available_values = @subject.defined_enums[scope.to_s].reject do |key, _|
                    key == previous_value
                  end
                  available_values.keys.last
                elsif (scope.to_s =~ /_type$/) && (klass = previous_value.safe_constantize) && klass.ancestors.include?(::ActiveRecord::Base)
                  ::ActiveRecord::Base.descendants.find { |model| model.to_s != previous_value }.to_s
                elsif previous_value.respond_to?(:next)
                  previous_value.next
                elsif previous_value.respond_to?(:to_datetime)
                  previous_value.to_datetime.next
                else
                  previous_value.to_s.next
                end

              @subject.__send__("#{scope}=", next_value)

              if allows_value_of(existing_value, @expected_message)
                @subject.__send__("#{scope}=", previous_value)

                @failure_message_when_negated <<
                  " (with different value of #{scope})"
                true
              else
                @failure_message << " (with different value of #{scope})"
                false
              end
            end
          end
        end
      end
    end
  end
end
