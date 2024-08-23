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
    
    list_id = tuple["id"].to_i
    todos = find_todos_for_list(id)
    { id: list_id, 
      name: tuple["name"], 
      todos: todos }
  end

  def all_lists
    sql = <<~SQL 
    SELECT * FROM lists; 
    SQL
    result = query(sql)

    result.map do |tuple|
      list_id = tuple["id"].to_i

      todos = find_todos_for_list(list_id)

      { id: list_id.to_i, 
        name: tuple["name"], 
        todos: todos }
    end
  end

 

  def create_new_list(list_name)
    sql = <<~SQL
    INSERT INTO lists (name)
    VALUES
    ($1);
    SQL
    query(sql, list_name) 
  end

  def delete_list(id)
   sql1 = <<~SQL
   DELETE FROM todos 
   WHERE list_id = $1
   SQL

   sql2 = <<~SQL
   DELETE FROM lists
   WHERE id = $1
   SQL

   query(sql1, id)
   query(sql2, id)
  end

  def update_list_name(id, new_name)
    sql = <<~SQL
    UPDATE lists 
    SET name = $1
    WHERE id = $2
    SQL
    query(sql, new_name, id) 
  end

  def create_new_todo(list_id, todo_name)
    sql = <<~SQL
    INSERT INTO todos (name, list_id)
    VALUES 
    ($1, $2)
    SQL
    query(sql, todo_name, list_id)
  end

  def delete_todo_from_list(list_id, todo_id)
    sql = <<~SQL
    DELETE FROM todos
    WHERE id = $1 AND list_id = $2
    SQL
    query(sql, todo_id, list_id)
  end

  def update_todo_status(list_id, todo_id, new_status)
    sql = <<~SQL
    UPDATE todos
    SET completed = $1
    WHERE id = $2 AND list_id = $3
    SQL
    query(sql, new_status, todo_id, list_id)
  end

  def mark_all_todos_as_completed(list_id)
    sql = <<~SQL
    UPDATE todos
    SET completed = true
    WHERE list_id = $1
    SQL
    query(sql, list_id) 
  end

  private

  def find_todos_for_list(list_id)
    todos_sql = <<~SQL
    SELECT * FROM todos WHERE list_id = $1;
    SQL

    todos_result = query(todos_sql, list_id) 
      
    todos_result.map do |todo_tuple| 
      { id: todo_tuple["id"], 
        name: todo_tuple["name"], 
        completed: todo_tuple["completed"] == "t" }
    end
  end

end
