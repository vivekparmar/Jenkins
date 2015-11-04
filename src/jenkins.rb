require "bundler/setup"
require "rubygems"
require "cloudmunch_sdk"
require "date"

class jenkins < AppAbstract

    def initializeApp()
        json_input = getJSONArgs()

        @jobname = json_input['loader_jobname']
        @greeting_param = json_input['greeting_param']
        @log_level = json_input['log_level'] 

        appContext = getAppContext(json_input)
        @domain = appContext.get_data('domain')
        @project = appContext.get_data('project')
        
        logInit(@log_level)
        log("info", "initializeApp is invoked using jenkins")     
    end

    def process()
        jira_SP = getServiceProvider()
        jira_login_url = jira_SP.get_data('jira_login_url')
        jira_username = jira_SP.get_data(‘jira_username')
        jira_password = jira_SP.get_data('jira_password')
        jira_relative_url = jira_SP.get_data('jira_relative_url')
        jira_story_type_names = jira_SP.get_data('story_type_names')
        jira_storypoints_customfield = jira_SP.get_data('customfield_for_storypoints')
        jira_sprint_customfield = jira_SP.get_data('customfield_for_sprint')
    end  

    def saveGreetingMessage(message)
        log("info", "saveGreetingMessage is invoked in jenkns App")
        log("debug", message)
        # the result_array needs to be stored into CMDB
        # updateCustomContext()
        @id = "messageid"
        log("info", "Updating cmdb with exceldata: id:"+@id) 

        data_pack = {
            "domain" => @domain,
            "project" => @project,
            "job" => @jobname,
            "context" => @greeting_param,
            "id" => @id,
            "data" => message
        }
        #pass the filled in hash object to the following method
        updateDataContextToCMDB(data_pack)  
    end 

    def cleanupApp()
        log("info", "cleanupApp is invoked in RubySDK_HelloWorld_plugin App")
        logClose()
    end


end

jenkins = jenkins.new()
jenkins.start()
