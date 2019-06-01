class BusinessSerializer < ActiveModel::Serializer
  attributes :id, :name

  def slug
    "#{id} #{name}".parameterize
  end

end
