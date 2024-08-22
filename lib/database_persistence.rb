require "pg"

class DatabasePersistence 

  def initialize(logger)
    @db = PG.connect(dbname: "todos")
    @logger = logger
  end

  def query(sql_statement, *parameters)
    @logger.info("#{sql_statement}: #{parameters}")
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

  def all_lists
    sql = <<~SQL 
    SELECT * FROM lists; 
    SQL
    result = query(sql)

    result.map do |tuple|

      list_id = tuple["id"]

      todos_sql = <<~SQL
      SELECT * FROM todos WHERE list_id = $1;
      SQL
      todos_result = query(todos_sql,list_id) 
      
      todos = todos_result.map do |todo_tuple| 
        { id: todo_tuple["id"], 
          name: todo_tuple["name"], 
          completed: todo_tuple["completed"] }
      end

      { id: list_id, 
        name: tuple["name"], 
        todos: todos }
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
