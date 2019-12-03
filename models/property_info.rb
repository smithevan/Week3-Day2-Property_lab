require ('pg')

class PropertyInfo

attr_reader :id
attr_accessor :address, :value, :number_of_bedrooms, :year_built

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @year_built = options['year_built'].to_i
  end

  def save()
    db = PG.connect ({dbname: 'property', host: 'localhost'})
    sql =
    "
    INSERT INTO property (
      address,
      value,
      number_of_bedrooms,
      year_built
    ) VALUES ($1, $2, $3, $4) RETURNING id;
    "
    values = [@address, @value, @number_of_bedrooms, @year_built]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close()
  end

  def PropertyInfo.all()
    db = PG.connect({dbname: 'property', host: 'localhost'})
    sql = 'SELECT * FROM property;'
    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close()
    return properties.map{ |property_hash| PropertyInfo.new(property_hash)}
  end

  def update()
    db = PG.connect({dbname: 'property', host: 'localhost'})
    sql =
    "
    UPDATE property SET (
      address,
      value,
      number_of_bedrooms,
      year_built
    ) = (
      $1, $2, $3, $4
    ) WHERE id = $5;
    "
    values = [@address, @value, @number_of_bedrooms, @year_built, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def PropertyInfo.delete_all()
    db = PG.connect({dbname: 'property', host: 'localhost'})
    sql = "DELETE FROM property;"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end


  def delete()
    db = PG.connect({dbname: 'property', host: 'localhost'})
    sql = "DELETE FROM property WHERE id = $1;"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end


end
