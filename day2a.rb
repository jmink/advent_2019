class Intcode

  EXIT = 99
  ADD = 1
  MULTIPLY = 2

  def self.process(codes)
    index = 0
    while(codes[index] != EXIT) do
      if codes.length < index+3
        raise "Malformed instruction: requires out of bounds index"
      end

      math = case codes[index] 
        when ADD
          lambda { |a,b| a + b }
        when MULTIPLY
          lambda { |a,b| a*b }
        else
	  raise "unknown function #{opcode}"
      end
      codes = apply(math, codes, codes[index+1], codes[index+2], codes[index+3])
      index += 4
    end
    codes
  end

  def self.apply(proc, codes, first_loc, second_loc, result_loc)
    result = proc.call(codes[first_loc], codes[second_loc])
    codes[result_loc] = result
    codes
  end
end
