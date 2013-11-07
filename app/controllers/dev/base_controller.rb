module Dev
  class BaseController < ApplicationController

    skip_before_filter :authenticate_user!
    skip_before_filter :require_registration!
    fine_print_skip_signatures :general_terms_of_use, 
                               :privacy_policy


    before_filter Proc.new{ 
      raise SecurityTransgression unless !Rails.env.production?
    }
    
  end
end
