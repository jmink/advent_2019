class Intcode

  EXIT = 99
  ADD = 1
  MULTIPLY = 2

  def self.find_solution(file_name, goal = 19690720)
    codes = File.readlines(file_name)[0].split(',')
    codes = codes.map { |e| e.to_i }

    (0..99).each do |noun|
      (0..99).each do |verb|
        if attempt(codes.dup, noun, verb, goal)
          print "Noun #{noun}, verb #{verb} produce #{goal}"
          return [noun, verb]
        end
       end
     end
     print "No solution found"
  end

  def self.attempt(codes, noun, verb, goal)
    codes[1] = noun
    codes[2] = verb
    result = process(codes)
    return (result[0] == goal)
  rescue Exception => e
    print "Caught exception #{e} attempting to process #{codes}\n"
    return false 
  end


  def self.process(codes)
    address = 0
    while(codes[address] != EXIT) do
      if codes.length < address+3
        raise "Malformed instruction: requires out of bounds address"
      end

      instruction = case codes[address] 
        when ADD
          lambda { |a,b| a + b }
        when MULTIPLY
          lambda { |a,b| a*b }
        else
	  raise "unknown function #{address}"
      end
      codes = apply(instruction, codes, codes[address+1], codes[address+2], codes[address+3])
      address += 4
    end
    codes
  end

  def self.apply(proc, codes, first_loc, second_loc, result_loc)
    result = proc.call(codes[first_loc], codes[second_loc])
    codes[result_loc] = result
    codes
  end
end
