5.send(:*, 5)
"omg".send(:upcase)
["a", "b", "c"].send(:at, 1)
["a", "b", "c"].send(:insert, 2, "o", "h", "n", "o")
{}.size()
{character: "Mario"}.send(:has_key?, :character)

6-32
{html: true, json: false}.keys
"MakerSquare".*(6)
"MakerSquare".split("a")
["alpha", "beta"].[](3) #deletes 3 indexies. => nil 

class Car
  @pos = 0
  @gas = 10

  def drive(miles)
    @gas -= miles
    @pos += miles
  end

  def fill_up(gallons)
    @gas += gallons
  end
end