module Api
  module V1

    class PartsController < ApiController 

      resource_description do
        api_versions "v1"
        short_description 'Exercises have an ordered list of Parts, each of which contains a Question'
        description <<-EOS
          Exercises each have a number of Parts.  Published Exercises always have at least one Part,
          but drafts needn't have any.  The vast majority of Exercises will have only one part.
        EOS
      end

      api :GET, '/parts/:id', 'Gets the specified Part'
      description <<-EOS
        #{json_schema(Api::V1::PartRepresenter, include: :readable)}
      EOS
      def show
        rest_get(Part, params[:id])
      end

      api :PUT, '/parts/:id', 'Updates the specified Part'
      description <<-EOS
        Updates the Part object whose ID matches the provided param.

        #{json_schema(Api::V1::PartRepresenter, include: :writeable)}        
      EOS
      def update
        rest_update(Part, params[:id])
      end

      def create
        exercise = Exercise.find(params[:exercise_id])
        raise SecurityTransgression unless current_user.can_update?(exercise)
        result = CreateBlankPart.call(exercise)

        if result.errors.none?
          respond_with result.outputs[:part]
        else
          render json: result.errors, status: :unprocessable_entity
        end
      end

      api :DELETE, '/parts/:id', 'Deletes the specified Part'
      def destroy
        rest_destroy(Part, params[:id])
      end
      
    end
  end
end