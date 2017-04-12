require 'yaml'
require 'byebug'
require 'rest_client'


# remove below line if MyParentApi already exist
class MyParentApi; end 

# remove below code if we are using rails
class String
  def constantize
    self.split("::").inject(Module) { |acc, val| acc.const_get(val) }
  end
end


# load api configuration yml data for class generation
API_CONFIGURATION = YAML.load_file('api_configuration.yml')

API_CONFIGURATION.each_with_index do |api_fields, index|
  # create daynamic class extended bt it's parent class
  Object.const_set("#{api_fields['api_class']}ConfigIndex", index )
  klass = Class.new(api_fields['parent_class'].to_s.constantize) do
    # Define run method for calling api and       
    def self.run
      # Local Variables
      try_again = true
      response = nil
      data = {} 

      # Get Api Configuration Data
      configuration = API_CONFIGURATION[eval("#{self.to_s}ConfigIndex").to_i]
      map_fields = configuration['parameter_map']
      api_max_retry = configuration['max_retries']
      api_url = configuration['url']
      api_timeout = configuration['max_timeout']      

      # Api Calling emplimation with max retry and timeout  
      while try_again 
        begin
          response = RestClient::Request.execute(method: :get, url: api_url, timeout: api_timeout)
          # Mapping data
          map_fields.each{ |source_key, target_key| data[target_key] = response[source_key] || "Not Found" }
          try_again = false
        rescue RestClient::ExceptionWithResponse => e
          api_max_retry -= 1
          try_again = false if api_max_retry.zero?
          e.response
        end
      end
      data      
    end  
  end

  # set dymamic class name   
  Object.const_set(api_fields['api_class'], klass)
end

# Call api using run method 
API_CONFIGURATION.each do |api_fields| 
  api_data = api_fields['api_class'].to_s.constantize.run
  #InternalClass.create(api_data)
end
