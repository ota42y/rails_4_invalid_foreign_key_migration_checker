require "rails_4_invalid_foreign_key_migration_checker/version"
require "rails_4_invalid_foreign_key_migration_checker/active_record/schema_statements"
require "rails_4_invalid_foreign_key_migration_checker/active_record/database_tasks"

if ActiveRecord::VERSION::MAJOR >= 5
  raise 'rails_4_invalid_foreign_key_migration_checker no longer need in rails 5 so please remove it'
end

module Rails4InvalidForeignKeyMigrationChecker
  class InvalidRemoveForeignKeyError < StandardError; end
end
