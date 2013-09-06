class RaceTrack
  def initialize
    @cars = []
    @bets = []
    @hours = 0
    @race_started = false
    @race_ended = true

  end

  def add_car(car)
    if !@race_started
      @cars.push(
      {
        :name => car.name,
        :sponsor => car.sponsor,
        :speed => rand(21) + 60,
        :distance => 0,
        :odds => 1.0
      })
      print %<
      #{car.name} has been added to the race!
      #{car.name}'s speed is #{@cars.last[:speed]}>
      puts %<
      Place your bets!!!> if @cars.length >= 2
      @race_ended = false
    else
      puts "Sorry bro, race started, maybe next one!"
    end
  end

  def start_race
    puts "No cars! No race! Simple as that skipper!" if @cars.length == 0
    puts "There is only one car! Make it a challenge!!!" if @cars.length == 1

    if @cars.length > 1 && !@race_started
      puts %<
      Gentle people, start your engines!
      VROOM VROOM!>
     
      det_odds
      @race_started = true
    else
      puts "The race already started!!!!"
    end
  end

  def det_odds
    rank = @cars.length
    @cars.sort { |x, y| x[:distance] <=> y[:distance]}
    @cars.each{ |car|
    car[:odds] = (rank / @cars.length.to_f * (5 - @hours).round(2)) + 1
       
    puts %<
      Bets on #{car[:name]} has a #{car[:odds]} return!>
    rank -= 1
    }
  end

  def place_bet(amount, bet_name, on_car)
    @winning_amount = 0

    @cars.each{ |car|
      if car[:name] == on_car
        @winning_amount = car[:odds] * amount
      end
    }

    if !@race_ended
      @current_better = {
        :bet_name => bet_name,
        :bet_amount => amount,
        :winning_amount => @winning_amount, 
        :on_car => on_car,
      }
      @bets.push(@current_better)
      puts %<
      Awesome! #{bet_name}, we got your bet of $#{amount} on #{on_car}>
    else
      puts "There are no cars in the current race!"
    end
  end


  def next_hour
    @cars.each { |car|
      car[:distance] += car[:speed]
      car[:speed] += rand(21)
      print %<
      #{car[:name]} flies through #{car[:distance]} miles!
      The #{car[:sponsor]} car is going #{car[:speed]} mph!!
      >
    }
    @hours += 1
    
    declare_winner if @hours >= 5
    det_odds
  end

  def declare_winner
    winner = @cars[0]
    winner[:distance]
    @cars.each { |car|
      winner = car if car[:distance] > winner[:distance]
    }
    puts %<
    The winner is.....#{winner[:name]}, sponsored by #{winner[:sponsor]}!!!!!!!
    puts #{winner[:name]} drove an amazing #{winner[:distance]} miles in 5 hours!
    An average speed of #{winner[:distance] / 5}.

    Add cars to race again!
    >

    bet_winner = []
    @bets.each { |bet|
      if bet[:on_car] == winner[:name]
        puts "Congratulations #{bet[:bet_name]}, you have won $#{bet[:winning_amount]}!!!"
        puts "#{winner[:odds]}"
      end
    }

    @cars = []
  end

end # End of class

class RaceCar
  def initialize(name, sponsor)
    @name = name
    @sponsor = sponsor
    @speed = rand(21) + 60
  end

  def name
    @name
  end

  def sponsor
    @sponsor
  end

  def speed
    @speed
  end
end

n = RaceTrack.new

a = RaceCar.new("a", "sdfad");
b = RaceCar.new("adfasf", "adfasdf");
c = RaceCar.new("bob", "Marley");
d = RaceCar.new("hello", "dude")


load "raceCar.rb";
a = RaceCar.new("a", "sdfad");
b = RaceCar.new("adfasf", "adfasdf");
c = RaceCar.new("bob", "Marley");
d = RaceCar.new("hello", "dude");
n = RaceTrack.new;
n.add_car(a);
n.add_car(b);
n.add_car(c);
n.add_car(d);
n.start_race


