require 'active_record/connection_adapters/abstract/schema_statements'

module ActiveRecord
  module ConnectionAdapters
    module SchemaStatements
      @alias_remove_foreign_key_errors = []
      def alias_remove_foreign_key(from_table, options_or_to_table = {})
        return original_remove_foreign_key(from_table, options_or_to_table) unless Rails.env.test?

        return unless supports_foreign_keys?

        unless options_or_to_table.is_a?(Hash)
          # options_or_to_table == table_name
          # check rails 5 compatibility
          table = foreign_keys(from_table).detect do |fk|
            fk.to_table == options_or_to_table.to_s
          end

          unless table
            # rails_app/db/migrate/xxxxxxx_xxxxxxxx.rb:3:in `change' we want to this line
            # lib/active_record/migration.rb:608:in `exec_migration' find this line from caller
            cl = caller()
            migration_index = cl.index{ |s| s =~ /:in `exec_migration'$/ } - 1

            ::ActiveRecord::ConnectionAdapters::SchemaStatements.add_foreign_key_errors(cl[migration_index], "remove_foreign_key(#{from_table}, #{options_or_to_table}) is invalid migration in rails 5")
          end
        end

        original_remove_foreign_key(from_table, options_or_to_table)
      end

      def self.add_foreign_key_errors(msg, path)
        @alias_remove_foreign_key_errors << ''
        @alias_remove_foreign_key_errors << msg
        @alias_remove_foreign_key_errors << path
      end

      alias_method :original_remove_foreign_key, :remove_foreign_key
      alias_method :remove_foreign_key, :alias_remove_foreign_key
    end
  end
end