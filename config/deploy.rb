# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'silviasellescom'
set :repo_url, 'git@github.com:purbon/silviasellescom.git'
set :branch, 'master'
set :scm, :git
set :linked_files, [ 'config/env.yml', '.ruby-version', '.ruby-gemset' ]

set :user, "silviacom"

set :stages, ["production", "staging"]
set :default_stage, "production"
set :use_sudo, false

set :bundle_dir, ''
set :bundle_flags, '--system --quiet'

set :rvm_type, :system
set :rvm_path, '/usr/local/rvm/'
set :rvm_ruby_string,    'ruby-2.1.3@silviacom'

set :copy_cache, true

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
