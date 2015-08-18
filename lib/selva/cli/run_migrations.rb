# CLI command to run the database migrations. Currently this is not used, 
# because we didn't even implement the database connection yet.

Selva::CLI.class_eval do
  desc "run_migrations", "Run the RethinkDB migrations"
  def run_migrations
    
  end
end