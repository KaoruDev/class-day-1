class RaceTrack
  def initialize
    @cars = []
    @bets = []
    @hours = 0
    @race_started = false
    @race_ended = true

  end

  def add_car(name, sponsor)
    if !@race_started
      current_car = RaceCar.new(name, sponsor)
      @cars[current_car.name] = current_car 
      print %<
      #{current_car.name} has been added to the race!
      #{current_car.name}'s speed is #{current_car.speed}>
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
    @cars.sort! { |x, y | x.distance + x.speed <=> y.distance + y.speed}
    @cars.each{ |car|
    car.odds = (rank / @cars.length.to_f * (5 - @hours).round(2)) + 1
       
    puts %`
      Bets on {car[:name]}**** have a #{car.odds} return!
      `
    rank -= 1
    }
  end

  def place_bet(amount, better_name, bet_on_car)
    winning_amount = 0

    @cars.each{ |car|
      if car.name == on_car
        winning_amount = car.odds * amount
      end
    }

    if !@race_ended
      current_bet = Bet.new(amount, winning_amount, better_name, bet_on_car, better_name)
      @bets[better_name] = current_bet
      puts %<
      Awesome! #{better_name}, we got your bet of $#{amount} on #{on_car}!
      Your winning amount is: $#{winning_amount}!>
    else
      puts "There are no cars in the current race!"
    end
  end


  def next_hour
    @cars.each { |car|
      car.drive
    }

    @hours += 1
    
    declare_winner if @hours >= 5
    det_odds if @hours < 5
  end

  def declare_winner
    winner = 0
    winner_distance = 0
    @cars.each { |car|
      if car.distance > winner_distance
        winner = car 
        winner_distance = car.distance
      end
    }
    puts %<
    The winner is.....#{winner.name}, sponsored by #{winner.sponsor}!!!!!!!
    #{winner.name} drove an amazing #{winner.distance} miles in 5 hours!
    An average speed of #{winner.distance / 5}mph.

    Add cars to race again!
    >

    bet_winner = []
    @bets.each { |bet|
      if bet.bet_on_car == winner.name
        puts "Congratulations #{bet.better_name}, you have won $#{bet.winning_amount}!!!"
        puts "#{winner.odds}"
      end
    }

    @cars = []
  end

end # End of class

class RaceCar
  attr_reader :name, :sponsor, :speed
  attr_accessor :distance, :odds


  def initialize(name, sponsor)
    @name = name.capitalize
    @sponsor = sponsor
    @speed = rand(21) + 60
    @distance = 0
    @odds = 1.0
  end
end

class Bet
  attr_accessor :amount, :winning_amount, :bet_on_car, :better_name
  
  def initialize(amount, winning_amount, bet_on_car, better_name)
    @amount = amount
    @winning_amount = winning_amount
    @bet_on_car = bet_on_car
    @better_name = better_name
  end

  def drive
    @distance += @speed
    @speed += rand(21)

    print %<
    #{@name} flies through #{@distance} miles!
    The #{@sponsor} car is now going #{@speed} mph!!
    >
  end
end


racet = RaceTrack.new

racet.add_car("A", "Apple")
racet.add_car("B", "Butter")
racet.add_car("W", "Windows")
racet.add_car("C", "Crayon")




