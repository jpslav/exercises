module Api::V1
  class ComboChoiceRepresenter < Roar::Decorator

    include Roar::Representer::JSON

    property :correctness,
             type: Float,
             writeable: true,
             readable: true,
             schema_info: {
               type: 'number'
             }

    collection :combo_choice_answers,
               class: ComboChoiceAnswer,
               representer: ComboChoiceAnswerRepresenter,
               writeable: true,
               readable: true,
               parse_strategy: :sync,
               getter: lambda { |*| @correctness.to_f },
               schema_info: {
                 required: true
               }

  end
end
