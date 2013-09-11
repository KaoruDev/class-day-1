class Track
  def initialize
    @cars = []
    @bets = []
    @hours = 0
    @race_started = false
  end

  class Active_car
    attr_reader :carName
    attr_reader :sponsor

    attr_accessor :speed
    attr_accessor :distance
    attr_accessor :odds


    def initialize(name, sponsor)
      @carName = name.capitalize
      @sponsor = sponsor.capitalize
      @speed = @speed = rand(21) + 60
      @distance = 0
    end
  end

  class Better
    attr_reader :name
    attr_reader :carName

    attr_reader :amount
    attr_reader :winnings

    def initialize(name, carName, amount, winnings)
      @name = name
      @carName = carName
      @amount = amount
      @winnings = winnings
    end

    def add_bet(add_amount, add_winnings)
      @amount += add_amount
      @winnings += add_winnings
    end

  end

  def add_car(name, sponsor)
    if !@race_started
      name = Active_car.new(name, sponsor)
      @cars.push(name)
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
    @cars.sort! { |x, y| x.distance + x.speed <=> y.distance + y.speed}
    @cars.each{ |car|
    car.odds = (rank / @cars.length.to_f * (5 - @hours).round(2)) + 1
       
    puts %`
      Bets on **** #{car.carName} **** have a #{car.odds} return!
      `
    rank -= 1
    }
  end

  def bet(amount, bet_name, on_car)
    correct_name = false
    prev_better = false
    winning_amount = 0

    @cars.each{ |car|
      if car.carName == on_car.capitalize
        winning_amount = car.odds * amount
        correct_name = true
      end     
    }

    @bets.each{ |bet|
      if bet.name == bet_name
        prev_better = true
        current_better = bet
      end
    }

    puts "There are no cars with the name #{on_car} in the current race!" if correct_name

    if @race_started && correct_name && prev_better
      current_better.add_bet(amount, winning_amount)
    elsif @race_started && correct_name
      bet_name = Better.new(bet_name, on_car, amount, winning_amount)
      @bets.push(bet_name)
      puts %<
      Awesome! #{bet_name.name}, we got your bet of $#{amount} on #{on_car}>
    else
      puts "\n\tThere are no cars with the name #{on_car} in the current race!"
    end
  end


  def next_hour
    @cars.each { |car|
      car.distance += car.speed
      car.speed += rand(21)
      print %<
      #{car.carName} flies through #{car.distance} miles!
      The #{car.sponsor} car is now going #{car.speed} mph!!
      >
    }
    @hours += 1
    
    declare_winner if @hours >= 5
    det_odds
  end

  def declare_winner
    winner = @cars[0]
    @cars.each { |car|
      winner = car if car.distance > winner.distance
    }
    puts %<
    The winner is.....#{winner.carName}, sponsored by #{winner.sponsor}!!!!!!!
    #{winner.carName} drove an amazing #{winner.distance} miles in 5 hours!
    An average speed of #{winner.distance / 5}mph.

    Add cars to race again!
    >

    bet_winner = []
    @bets.each { |bet|
      if bet.carName == winner.carName
        puts "Congratulations #{bet.name}, you have won $#{bet.winnings}!!!"
      end
    }

    @cars = []
  end

end # End of class
