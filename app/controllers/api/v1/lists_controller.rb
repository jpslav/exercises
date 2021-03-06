module Api::V1
  class ListsController < OpenStax::Api::V1::ApiController

    resource_description do
      api_versions "v1"
      short_description 'A list of Exercises.'
      description <<-EOS
        Lists represent collections of Exercises.
        The collection itself is owned by a group of users.
      EOS
    end

    #########
    # index #
    #########

    api :GET, '/lists', 'Returns a set of Lists of Exercises matching query terms'
    description <<-EOS
      Accepts a query string along with options and returns a JSON representation
      of the matching Lists. Only Lists visible to the caller will be
      returned. The schema for the returned JSON result is shown below.

      #{json_schema(Api::V1::ListSearchRepresenter, include: :readable)}            
    EOS
    # Using route helpers doesn't work in test or production, probably has to do with initialization order
    example "#{api_example(url_base: 'https://exercises.openstax.org/api/lists',
                           url_end: '?name=L%20visibility=public')}"
    param :name, String, desc: <<-EOS
      String that filters lists by name, using wildcards to match
      all names that contain the given string.
    EOS
    param :visibility, String, desc: <<-EOS
      String that filters lists by visibility.
      Valid values are either `public` or `private`.
    EOS
    param :order_by, String, desc: <<-EOS
      String that indicates how to sort the results of the query. The string
      is a comma-separated list of fields with an optional sort direction. The
      sort will be performed in the order the fields are given.
      The fields can be one of #{
        SearchLists::SORTABLE_FIELDS.collect{|sf| "`"+sf+"`"}.join(', ')
      }.
      Sort directions can either be `ASC` for an ascending sort, or `DESC` for
      a descending sort. If not provided, an ascending sort is assumed. Sort
      directions should be separated from the fields by a space.
      (default: `created_at ASC`)

      Example:

      `name, created_at DESC` &ndash; sorts by name ascending, then by created_at descending
    EOS
    def index
      OSU::AccessPolicy.require_action_allowed!(:index, current_user, List)
      outputs = OpenStax::Exercises::SearchLists.call(
        params.slice(:name, :visibility, :order_by)
      ).outputs
      respond_with outputs, represent_with: Api::V1::ListSearchRepresenter
    end

    ########
    # show #
    ########

    api :GET, '/lists/:id', 'Gets the specified List'
    description <<-EOS
      Gets the List that matches the provided ID.

      #{json_schema(Api::V1::ListRepresenter, include: :readable)}        
    EOS
    def show
      standard_read(List, params[:id])
    end

    ##########
    # create #
    ##########

    api :POST, '/lists', 'Creates a List'
    description <<-EOS
      Creates a List with the given attributes.

      #{json_schema(Api::V1::ListRepresenter, include: :writeable)}        
    EOS
    def create
      standard_create(List)
    end

    ##########
    # update #
    ##########

    api :PUT, '/lists/:id', 'Updates the specified List'
    description <<-EOS
      Updates the List that matches the provided ID with the given attributes.

      #{json_schema(Api::V1::ListRepresenter, include: :writeable)}        
    EOS
    def update
      standard_update(List, params[:id])
    end

    ###########
    # destroy #
    ###########

    api :DELETE, '/lists/:id', 'Deletes the specified List'
    description <<-EOS
      Deletes the List that matches the provided ID.
    EOS
    def destroy
      standard_destroy(List, params[:id])
    end

  end
end
