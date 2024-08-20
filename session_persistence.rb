class SessionPersistence 
  
  def initialize(session)
    @session = session
    @session[:lists] ||= []
  end

  def find_list(id)
    @session[:lists].find { |list| list[:id] == id }
  end

  def list_name_already_taken?(name)
    @session[:lists].any? { |list| list[:name] == name }
  end

end
