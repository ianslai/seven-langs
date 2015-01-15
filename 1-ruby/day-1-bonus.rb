number = rand(10)
puts 'Guess a number from 0 to 9'
while true
  guess = gets.to_i
  break if number == guess
  puts 'Your number is too ' + (guess < number ? 'low' : 'high')
end
puts 'You guessed right!'
