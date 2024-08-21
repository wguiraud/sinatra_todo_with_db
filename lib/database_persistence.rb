require "pg"

class DatabasePersistence 

  def initialize
    @db = PG.connect(dbname: "todos")
  end

  def query(sql_statement, *parameters)
    puts "#{sql_statement}: #{parameters}"
    @db.exec_params(sql_statement, parameters)
  end

  def find_list(id)
    sql = <<~SQL
    SELECT * FROM lists 
    WHERE id = $1; 
    SQL
    result = query(sql, id)

    tuple = result.first
    { id: tuple["id"], name: tuple["name"], todos: [] }
  end

  def all_list
    sql = <<~SQL 
    SELECT * FROM lists; 
    SQL
    result = query(sql)

    result.map do |tuple|
      { id: tuple["id"], name: tuple["name"], todos: [] }
    end
  end

  def create_new_list(list_name)
    sql = <<~SQL
    INSERT INTO lists (name)
    VALUES
    ("#{list_name}");
    SQL
    result = @db.exec(sql)
#    id = next_element_id(@session[:lists])
#    @session[:lists] << { id: id, name: list_name, todos: [] }
  end

  def delete_list(id)
    sql = <<~SQL
    DELETE FROM lists
    WHERE id = #{id};
    SQL
    result = @db.exec(sql)
#    @session[:lists].reject! { |list| list[:id] == id }
  end

  def update_list_name(id, new_name)
    sql = <<~SQL
    UPDATE lists 
    WHERE id = #{id} 
    SET name = #{new_name};
    SQL
    result = @db.exec(sql)
#    list = find_list(id)
#    list[:name] = new_name
  end

  def create_new_todo(list_id, todo_name)
#    list = find_list(list_id)
#    todo_id = next_element_id(list[:todos])
#    list[:todos] << { id: todo_id, name: todo_name, completed: false }
  end

  def delete_todo_from_list(list_id, todo_id)
#    list = find_list(list_id)
#    list[:todos] .reject! { |todo| todo[:id] == todo_id }
  end

  def update_todo_status(list_id, todo_id, new_status)
#    list = find_list(list_id)
#    todo = list[:todos].find { |t| t[:id] == todo_id }
#    todo[:completed] = new_status
  end

  def mark_all_todos_as_completed(list_id)
#    list = find_list(list_id)
#    list[:todos].each { |todo| todo[:completed] = true }
  end

end
