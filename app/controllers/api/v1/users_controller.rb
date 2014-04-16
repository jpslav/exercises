class Api::V1::UsersController < OpenStax::Api::V1::ApiController

  resource_description do
    api_versions "v1"
    short_description 'TBD'
    description <<-EOS
      TBD
    EOS
  end

  ###############################################################
  # search
  ###############################################################

  api :GET, '/users/search', 'Return a set of Users matching query terms'
  description <<-EOS
    Accepts a query string along with options and returns a JSON representation
    of the matching Users.  Some User data may be filtered out depending on the
    caller's status and priviledges in the system.  The schema for the returned
    JSON result is shown below. 

    <p>Currently, access to this API is limited to trusted applications where the 
    application is making the API call on its own behalf, not on the behalf of
    a user.</p>

    #{json_schema(Api::V1::UserSearchRepresenter, include: :readable)}            
  EOS
  # Using route helpers doesn't work in test or production, probably has to do with initialization order
  example "#{api_example(url_base: 'https://exercises.openstax.org/api/users/search', url_end: '?q=username:bob%20name=Jones')}"
  param :q, String, required: true, desc: <<-EOS
    The search query string, built up as a space-separated collection of
    search conditions on different fields.  Each condition is formatted as
    "field_name:comma-separated-values".  The resulting list of users will
    match all of the conditions (boolean 'and').  Each condition will produce
    a list of users where those users must match any of the comma-separated-values
    (boolean 'or').  The fields_names and their characteristics are given below.
    When a field is listed as using wildcard matching, it means that any fields
    that start with a comma-separated-value will be matched.

    * `username` &ndash; Matches users' usernames.  Any characters matching 
                 `#{ERB::Util.html_escape (User::USERNAME_DISCARDED_CHAR_REGEX.inspect)}`
                 will be discarded. (uses wildcard matching)
    * `first_name` &ndash; Matches users' first names, case insensitive. (uses wildcard matching)
    * `last_name` &ndash; Matches users' last names, case insensitive. (uses wildcard matching)
    * `name` &ndash; Matches users' first, last, or full names, case insenstive. (uses wildcard matching)
    * `id` &ndash; Matches users' IDs exactly.
    * `email` &ndash; Matches users' emails exactly.

    You can also add search terms without prefixes, separated by spaces.  These terms 
    will be searched for in all of the prefix categories.  Any matching users will be 
    returned.  When combined with prefixed search terms, the final results will contain
    users matching any of the non-prefixed terms and all of the prefixed terms.

    Examples:

    `username:ric` &ndash; returns 'richb' and 'ricardo' users.

    `username:ric name:"Van Buren"` &ndash; returns the 'Ricardo Van Buren' user.

    `ric` &ndash; returns 'richb', 'ricardo', and 'Jimmy Rich' users.
  EOS
  param :page, Integer, desc: <<-EOS
    Specifies the page of results to retrieve, zero-indexed. (default: 0)
  EOS
  param :per_page, Integer, desc: <<-EOS
    The number of users to retrieve on the chosen page. (default: 20)
  EOS
  param :order_by, String, desc: <<-EOS
    A string that indicates how to sort the results of the query.  The string
    is a comma-separated list of fields with an optional sort direction.  The
    sort will be performed in the order the fields are given.  
    The fields can be one of #{Api::V1::SearchUsers::SORTABLE_FIELDS.collect{|sf| "`"+sf+"`"}.join(', ')}.
    Sort directions can either be `ASC` for 
    an ascending sort, or `DESC` for a
    descending sort.  If not provided an ascending sort is assumed. Sort directions
    should be separated from the fields by a space. (default: `username ASC`)

    Example:

    `last_name, username DESC` &ndash; sorts by last name ascending, then by username descending 
  EOS
  def search
    OSU::AccessPolicy.require_action_allowed!(:search, current_user, User)
    outputs = SearchUsers.call(params[:q], params.slice(:page, :per_page, :order_by)).outputs
    respond_with outputs, represent_with: Api::V1::UserSearchRepresenter
  end

end