 require ('pry')
 require_relative('models/property_info')

 property1 = PropertyInfo.new ({
   'address' => '99 Balloon St',
   'value' => 200_000,
   'number_of_bedrooms' => 4,
   'year_built' => 2005
 })

 property2 = PropertyInfo.new ({
   'address' => '55 Codeclan Ave',
   'value' => 400_000,
   'number_of_bedrooms' => 8,
   'year_built' => 1890
 })

 property3 = PropertyInfo.new ({
   'address' => '99 Pleasant St',
   'value' => 150_000,
   'number_of_bedrooms' => 3,
   'year_built' => 1997
 })



 binding.pry
 nil
