class LibraryController < ApplicationController
  layout false

  def index
  end
  
  
helper_method :getLibOpenArray
helper_method :getFreePCHash
helper_method :getReservedBookResult

require 'net/http'
require 'ostruct'


#get Library api(Details) and return all the Json strings
   def getDetails(address)
    url = URI.parse(address)
    res = Net::HTTP.get(url)
    return res
   end
   
#get Library api(Summary) and return all the Json strings
   def getSummary(address)
    url = URI.parse(address)
    res = Net::HTTP.get(url)
    return res
   end
   
#get Json strings and return parsed hash
    def parse(api)
        obj = JSON.parse(api, object_class: OpenStruct)
        return obj
    end
    
#read parsed hash and return library info as array 
    def getLibOpenArray(key)
        returnArray = []
        obj = parse(getSummary("http://api.lib.sfu.ca/hours/summary"))
          for i in obj
            returnArray.push(i[key])
          end
         return returnArray
    end
    
   
    def getFreePCHash(field, lib_pc)
        obj = parse(getSummary("http://api.lib.sfu.ca/equipment/computers/free_summary"))
        returnArray = []
        returnArray.push(obj[field][lib_pc])
        return returnArray
    end
   
   
    #take user input (search keyword)
    def reserved_book
        keyword_search = params[:keyword]
        return keyword_search
    end

    # concatenate user search keyword to the API url
    def construct_search_URL
        url = "http://api.lib.sfu.ca/reserves/search?department=" + reserved_book
        return url
    end
    
    # with concatenated url, retrieve results
    def getReservedBookResult
        returnArray = []
        obj = parse(getSummary(construct_search_URL))
        returnArray.push(obj["reserves"])
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
