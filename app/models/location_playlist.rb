class LocationPlaylist < ApplicationRecord
  belongs_to :location
  belongs_to :playlist
  scope :high_energy, -> { where(energy: 'High')}
  scope :low_energy, -> { where(energy: 'Low')}
  scope :at_location_2, -> { where(location_id: 2)}

  # def set_energy_levels(location, params)
  #   count = 0
  #   all.each do |locationplaylist|
  #     if locationplaylist.location_id == location.id
  #       locationplaylist.energy = eval("params[:energy_level#{count}]")
  #       locationplaylist.save
  #       count += 1
  #     end
  #   end
  # end

end
