class CoursesController < ApplicationController
  
  layout false
  
  def index
  end
  

helper_method :getCourseSearchResult

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
        course_name = params[:course_name]
        course_number = params[:course_number]
        course_section = params[:course_section]
        return course_name, course_number, course_section
    end

    # concatenate course name and number to the API url
    def construct_search_URL
        name, number, section = reserved_book
        url = "http://www.sfu.ca/bin/wcm/course-outlines?2016/summer/" + name + "/" + number + "/" + section
        return url
    end
    
    # with concatenated url, retrieve results
    # return array of Hashes
    def getCourseSearchResult
        returnArray = []
        obj = parse(getSummary(construct_search_URL))
        returnArray.push(obj)
        return returnArray
    end
  
end
