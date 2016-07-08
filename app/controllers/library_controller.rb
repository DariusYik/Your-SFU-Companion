class LibraryController < ApplicationController
  layout false

  def index
  end
  
  
helper_method :getArray

require 'net/http'
require 'ostruct'


#get Library api(Details) and return all the Json strings
   def getDetails
    url = URI.parse("http://api.lib.sfu.ca/hours/details")
    res = Net::HTTP.get(url)
    return res
   end
   
#get Library api(Summary) and return all the Json strings
   def getSummary
    url = URI.parse("http://api.lib.sfu.ca/hours/summary")
    res = Net::HTTP.get(url)
    return res
   end
   
#get Json strings and return parsed hash
    def parse(api)
        obj = JSON.parse(api, object_class: OpenStruct)
        return obj
    end
    
#read parsed hash and return library info as array 
    def getArray(key)
        returnArray = []
        obj = parse(getSummary)
          for i in obj
            returnArray.push(i[key])
          end
         return returnArray
    end
    
   
##########################################################################   
###Code below is for Library detail API #####
#location field is in Array but others(hours, ranges) are in hash so we need two different
#methods to retrieve those info
###

# #retrieve info stored in array []
# #field ex:"locations"..
# #key ex: "name"

#     def getArray(field, key)
#         returnArray = []
#         obj = parse(getSummary)
        
#         for i in obj[field]
#              returnArray.push(i[key])       
#         end

#         return returnArray
#     end


# #retrieve info stored in hash{}
# #field ex:"locations"..
# #key ex: "name"
#     def getHash (field, key)
#         obj = parse(getDetails)
#         returnArray = []
#         for i in 1..2
#             returnArray.push(obj[field][i.to_s][key])
#         end
#         return returnArray
#     end
##########################################################################       

  
end
