class BankAccount

  def initialize(first, last, balance = 0, debt = 0)
    @first_name = first.capitalize
    @last_name = last.capitalize
    @balance = balance.to_f
    @cc_debt = debt.to_f
    puts "Hi #{@first_name} #{@last_name}! Welcome to Chase!"
    get_balance
  end



  def get_info
    puts %<
    Hi #{@first_name} #{@last_name}!
    Your current balance is $#{@balance}. 
    Your credit card debt is $#{@cc_debt}.
    >
  end

  def deposit(money)
    @balance += money
    money = money.to_f
    puts "Awesome! We got your deposit of $#{money}. "
    get_balance
  end

  def withdraw(money)
    if money < @balance
      @balance -= money
      money = money.to_f
      puts "Okay. You withdrew $#{money}."
      get_balance
    else
      puts "You don't have enough funds."
      get_balance
    end
  end

  def charge(amount)
    @cc_debt += amount
    puts "We charged $#{amount} to your credit card. Hope you enjoy your purchase!"
  end

  def get_balance
    print "Your current balance is currently $#{@balance}"
  end


  def pay_debt(payment)
    if payment > @balance
      @balance -= 10
      puts %<
      Unfortunately you don't have enough funds.
      You will be charged a $10.00 overdraft fee.
      >
    else
      @balance -= payment
      @cc_debt -= payment
      puts %<
      Thank you! We have received your payment of #{payment}.
      Your current balance is now $#{@balance}.
      Your credit card balance is now $#{@cc_debt}.
      Have a nice day!
      >
    end
  end

  def add_monthly_interest
    cc_interest = (@cc_debt * 0.015).round(2)
    @cc_debt +=  cc_interest

    balance_interest = (@balance * 0.0003).round(2)
    @balance += balance_interest

    puts %<
    You have been charged a fianace fee of $#{cc_interest}.
    Your current credit card balance is $#{@cc_debt}.

    You have earned $#{balance_interest} on your bank account.
    Your current balance is $#{@balance}.
    >
  end
end