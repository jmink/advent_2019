require_relative "day2a"

describe Intcode do
  it 'stops on 99' do
    input = [99, 0, 1, 2]
    output = Intcode.process(input) 

    expect(output).to eq input 
  end

  it 'adds two numbers' do
    input = [1, 5, 6, 7, 99, 10, 20, 0]
    expected_output = [1, 5, 6, 7, 99, 10, 20, 30]

    actual_output = Intcode.process(input)
    expect(actual_output).to eq expected_output
  end

  it 'multiplies two numbers' do
    input = [2, 5, 6, 7, 99, 7, 20, 0]
    expected_output = [2, 5, 6, 7, 99, 7, 20, 140]

    actual_output = Intcode.process(input)
    expect(actual_output).to eq expected_output
  end

  it 'does two commands in a row' do
    input = [1,9,10,3,2,3,11,0,99,30,40,50] 
    expected_output = [3500,9,10,70,2,3,11,0,99,30,40,50]

    actual_output = Intcode.process(input)
    expect(actual_output).to eq expected_output
  end
end
