module ApplicationsHelper
  [:bonus_points, :cs_students, :remote_teams, :in_teams, :duplicates].each do |flag|
    define_method(:"display_#{flag}?") { not session[:"hide_#{flag}"] }
    define_method(:"hide_#{flag}?")    { session[:"hide_#{flag}"] }
  end

  def rating_classes_for(rating)
    "pick" if rating.pick?
  end

  def application_classes_for(application)
    classes = [cycle(:even, :odd)]
    classes << 'volunteering_team' if application.volunteering_team?
    classes.join(' ')
  end
end