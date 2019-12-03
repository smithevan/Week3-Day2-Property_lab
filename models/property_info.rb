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


end
