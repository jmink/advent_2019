#!/usr/local/bin/ruby -w

##
# Simple program to determine the fuel needed for a given mass.
# This is an extremely rough program with no tests, which could
# certainly benefit from cleanup.
##

def fuel_calc(mass)
  # When dividing ints ruby automatically rounds down
  fuel = (mass.to_i/3) - 2
  return 0 if fuel < 0

  return fuel + fuel_calc(fuel)
end

def total_mass(file_name)
  # This could be re-written as a fold
  sum = 0
  File.open(file_name).each { |mass|
    fuel = fuel_calc(mass)
    sum += fuel
    print "Mass #{mass} will require fuel #{fuel}.  Running total: #{sum}"
  }
  sum
end

total_mass("day1_input.txt")
