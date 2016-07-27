class CoursesController < ApplicationController
  
  layout false
  
  def index
  end
  

helper_method :getCourseSearchResult
helper_method :testing
require 'net/http'
require 'ostruct'


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
    

    #take user input (search keyword)
    def reserved_book
        course_year = params[:course_year]
        course_term = params[:course_term]
        course_name = params[:course_name]
        course_number = params[:course_number]
        return course_year, course_term, course_name, course_number
    end

    # concatenate course name and number to the API url
    def construct_search_URL
        year, term, name, number = reserved_book
        url = "http://www.sfu.ca/bin/wcm/course-outlines?" + year + "/" + term + "/" + name + "/" + number
        return url
    end
    
    # with concatenated url, retrieve results
    # return array of Hashes
    def getCourseSearchResult
        returnArray = []
        obj = parse(getSummary(construct_search_URL))
        for i in obj
            returnHash = Hash.new
            returnArray.push(returnHash)
            returnHash["Title"] = i["title"]
            returnHash["Section"] = i["text"]
        end
        
        return returnArray
    end
  
   def testing (title, section)
     return title, section
   end
   
end
