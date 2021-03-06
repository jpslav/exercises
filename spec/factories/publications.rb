FactoryGirl.define do
  factory :publication do
    association :publishable, factory: :exercise
    license
    number { (Publication.where(publishable_type: publishable_type)
                         .maximum(:number) || 0) + 1 }
    version { (Publication.where(publishable_type: publishable_type,
                                 number: number)
                          .maximum(:version) || 0) + 1 }
    published_at nil
    yanked_at nil
    embargoed_until nil
    embargo_children_only false
    major_change false

    trait :published do
      published_at { Time.now }
    end
  end
end
