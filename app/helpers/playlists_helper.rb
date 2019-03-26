module PlaylistsHelper

  def playlist_times
    ["6am-9am", "9am-12pm", "12pm-3pm", "3pm-6pm", "6pm-9pm"]
  end

  def playlist_schedule(location)
    location.playlists.each_with_index do |playlist, index|
      concat(content_tag :h4, "#{playlist_times[index]}").concat(link_to(playlist.name, location_playlist_path(location, playlist))).concat(content_tag(:br))
    end.join("\n").html_safe
  end

end
