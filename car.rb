class Car

  def get_info
    "I'm a car. I've driven #{@distance} and have #{@fuel} gallons of gas left."

  end

  def initialize
    puts "the intialize method is running automatically"
    @fuel = 10
    @distance = 10
  end

  def drive(miles)
    if miles/20.0 < @fuel
      @fuel -= miles/20.0
      @distance += miles
    else
      puts "You don't have enough gas! Fill up boy!"
    end
  end

  def fuel_up
    if @fuel >= 10
      puts "You're topped off buddy!"
    else
      puts "You need to add #{(10-@fuel).round(2)} gallons to get a full tank!"
      puts "Gulp, gulp, gulp"
      puts "Pay up pal, you owe $#{((10-@fuel) * 3.5).round(2)} at $3.50 a gallon!"
      @fuel = 10
    end
  end
end