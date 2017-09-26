require 'active_record/tasks/database_tasks'

module ActiveRecord
  module Tasks
    module DatabaseTasks
      def alias_migrate
        return original_migrate unless Rails.env.test?

        original_migrate
        errors = ::ActiveRecord::ConnectionAdapters::SchemaStatements.instance_variable_get(:@alias_remove_foreign_key_errors)
        raise ::Rails4InvalidForeignKeyMigrationChecker::InvalidRemoveForeignKeyError.new(errors.join("\n")) unless errors.empty?
      end

      alias_method :original_migrate, :migrate
      alias_method :migrate, :alias_migrate
    end
  end
end