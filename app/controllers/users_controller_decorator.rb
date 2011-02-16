UsersController.class_eval do

  create.after do
    create_session
    associate_user
    # if users is associated I'm sure email is valid!
    if params[:newsletter] && params[:user][:email]
      Subscriber.create :email => params[:user][:email]
    end
  end

end