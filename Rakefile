require 'rake'

namespace :app do
  task :run do
    RAILS_PID = Process.spawn("cd rails && foreman start")
    EMBER_PID = Process.spawn("cd ember && ./node_modules/.bin/ember serve --port=4200 --proxy=http://localhost:5000")

    trap "INT" do
      puts 'Terminating Rails process...'
      Process.kill('SIGINT', RAILS_PID)
      puts 'Terminating Ember process...'
      Process.kill('SIGINT', EMBER_PID)
      puts 'All processes terminated!'
      exit 0
    end

    loop do
      sleep 1
    end
  end

  task :test do
    system "cd ember && npm test"
    system "cd rails && bundle exec rake"
  end
end
