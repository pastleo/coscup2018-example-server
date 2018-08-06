require 'csv'

# Loading Fixtures
FIXTURES_DIR = Rails.root.join('db', 'fixtures')
REPO_URI = 'git@git.frost.tw:BasalticStudio/Hime/fixtures.git'

if FIXTURES_DIR.exist?
  Dir.chdir FIXTURES_DIR do
    system 'git pull origin master'
  end
else
  system "git clone #{REPO_URI} #{FIXTURES_DIR}"
end

# Helper
def path_to_class(path)
  path[/\/([^\/]+).csv$/, 1].singularize.constantize
end

# Duplicate Options
options = {
  Gacha: {
    on_duplicate_key_update: {
      conflict_target: [:id],
      columns: [:name]
    }
  },
  Dialog: {
    on_duplicate_key_update: {
      conflict_target: [:id],
      columns: [:name]
    }
  }
}

# Seeding
fixtures = Dir[FIXTURES_DIR.join('*.csv')]
models = fixtures.map { |path| path_to_class(path) }
imports =models.zip(fixtures).to_h

imports.each do |klass, csv|
  puts "=== Importing #{klass.name} ==="
  data = CSV.table(csv).to_a
  columns = data.shift

  klass.import columns, data, on_duplicate_key_update: { conflict_target: [:id] }
end
