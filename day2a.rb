class Intcode

  EXIT = 99
  ADD = 1
  MULTIPLY = 2

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
	  raise "unknown function #{opcode}"
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
