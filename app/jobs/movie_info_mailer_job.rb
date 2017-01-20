class MovieInfoMailerJob
  include SuckerPunch::Job

  def perform(user, movie)
    MovieInfoMailer.send_info(user, movie).deliver_now
  end
end
