class SessionsController < Users::SessionsController

  def create 
    super
    #binding.pry
    @histroy = History.new(name: request.remote_ip)
    @histroy.save
  end 

  def destroy
    @histroy = History.find_by(name: request.remote_ip)
    @histroy.updated_at = DateTime.now()
    #binding.pry
    @histroy.save 
    super
  end 
end


