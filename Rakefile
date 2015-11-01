require 'rake'

namespace :app do
  task :run do
    pids = [
      spawn("cd rails && foreman start"),
      spawn("cd ember && ember server --port=4200 --proxy-port=5000"),
    ]

    trap "INT" do
      Process.kill "INT", *pids
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
