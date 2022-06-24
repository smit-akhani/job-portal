require 'uri'
require 'net/http'
require 'socket'

task :email_verification  => :environment do
p Socket.gethostname
    
    # uri = URI('https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY')
    # res = Net::HTTP.get_response(uri)


end