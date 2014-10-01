class StaticPagesController < ApplicationController
  
  respond_to :html

  skip_interceptor :authenticate_user!,
                   only: [:about, :contact, :copyright, :developers,
                          :help, :home, :privacy, :share, :terms]
  fine_print_skip :general_terms_of_use, :privacy_policy,
                  only: [:about, :contact, :copyright, :developers,
                         :help, :home, :privacy, :share, :terms]

end
