class CoursesController < ApplicationController
  
  layout false
  
  def index
  end
  

helper_method :getCourseSearchResult
helper_method :getCourseDetails
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
    def courseSearch
        course_year = params[:course_year]
        course_term = params[:course_term]
        course_name = params[:course_name]
        course_number = params[:course_number]
        return course_year, course_term, course_name, course_number
    end

    # concatenate course name and number to the API url
    def construct_search_URL
        year, term, name, number = courseSearch
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
  
  
    def courseSearchwithSection(section)
        course_year = params[:course_year]
        course_term = params[:course_term]
        course_name = params[:course_name]
        course_number = params[:course_number]
        course_section = section
        return course_year, course_term, course_name, course_number, course_section
    end

    # concatenate course name and number to the API url
    def construct_search_URL_withSection(section)
        year, term, name, number, section = courseSearchwithSection(section)
        url = "http://www.sfu.ca/bin/wcm/course-outlines?" + year + "/" + term + "/" + name + "/" + number + "/" + section
        return url
    end
    
    # with concatenated url, retrieve results
    # return array of Hashes
    def getCourseDetails(section)
        obj = parse(getSummary(construct_search_URL_withSection(section)))
        returnHash = Hash.new
        returnHash["Desciption"] = obj["info"]["courseDetails"]
        returnHash["Note"] = obj["info"]["notes"]
        
        
        return returnHash
    end  
  
  
   
end
