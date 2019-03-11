class ApplicationController < ActionController::Base
    def flash_class(level)
        case level
            when 'notice' then "alert alert-success alert-dismissible"
            when 'success' then "alert alert-success alert-dismissible"
            when 'error' then "alert alert-error alert-dismissible"
            when 'alert' then "alert alert-error alert-dismissible"
            when 'danger' then "alert alert-danger alert-dismissible"
        end
    end
    helper_method :flash_class
end
