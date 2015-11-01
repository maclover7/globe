require 'rake'

namespace :app do
  task :run do
    pids = [
      spawn("cd rails && foreman start"),
      #spawn("cd frontend && ./node_modules/.bin/ember server --port=4900 --proxy-port=3900"),
    ]

    trap "INT" do
      Process.kill "INT", *pids
      exit 0
    end

    loop do
      sleep 1
    end
  end
end
