require_relative 'api_configuration'

require 'active_record'
require 'sqlite3'
require 'logger'

ActiveRecord::Base.logger = Logger.new('debug.log')
DB_CONFIGURATION = YAML::load(IO.read('database.yml'))
ActiveRecord::Base.establish_connection(DB_CONFIGURATION['development'])

API_CONFIGURATION.each do |api_fields|
  klass_name = "#{api_fields['api_class']}Info"
  Object.const_set(klass_name, Class.new(ActiveRecord::Base))
  api_data = api_fields['api_class'].to_s.constantize.run
  api_class = klass_name.constantize
  api_class.delete_all
  variables = api_class.instance_variables
  api_class.create(api_data)
  puts api_class.to_s 
  api_class.all.each do |obj| 
    puts obj.inspect
    #puts variables.collect{|f| "  #{f.to_s}:  #{obj.send(f)}" }   
  end  
end
