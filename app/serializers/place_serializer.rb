class PlaceSerializer < ApplicationSerializer
  attributes :id, :name, :address, :town, :image_link, :slug, :department_slug, :participations_with_users

  def slug
    object.slug
  end

  def department_slug
    object.department.slug
  end

  def participations_with_users
    object.participations.todays.map do |participation|
      ParticipationSerializer.new(participation, except: :user_id, root: false)
    end
  end

end
