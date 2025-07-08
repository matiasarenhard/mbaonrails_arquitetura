require 'active_record/fixtures'

ActiveRecord::FixtureSet.create_fixtures('test/fixtures', 'coins')

ActiveRecord::FixtureSet.create_fixtures('test/fixtures', 'coin_logs')
