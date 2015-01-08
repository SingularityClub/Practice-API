require 'pathname'
require 'bundler'
require 'yaml'
Bundler.require(:default, ENV['RACK_ENV'] || :development)

ROOT = Pathname.new(File.expand_path('../..', __FILE__))
#配置文件
$config = YAML::load(File.read(ROOT.join('config', 'config.yml')))

Dir.glob(ROOT.join('app', 'models', '*.rb')).each { |file| require file }
Dir.glob(ROOT.join('app', 'helpers', '*.rb')).each { |file| require file }
require ROOT.join('app', 'api', 'practice_api.rb')

# Dir.glob(ROOT.join('app', 'api', '**', '*.rb')).each { |file| require file }

Grape::ActiveRecord.database_file = ROOT.join('config', 'database.yml')