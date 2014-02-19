module UsersHelper
  def member_of_club(confirmation)
    clubs="<ul>"
    @user.memberships.each do |m|
      if m.confirmed==confirmation
        clubs << "<li>"
        clubs << link_to(m.beer_club.to_s, url_for(m.beer_club))
        clubs << " "
        clubs << link_to('Leave', url_for(m), method: :delete, data:
            { confirm: "Really leave "+m.beer_club.name+"?" }, class:'btn btn-primary')
        clubs << "</li>"
      end
    end
    clubs << "</ul>"
    raw("#{clubs}")
  end

end
