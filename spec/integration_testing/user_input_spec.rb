describe 'User input - happy path (integration testing)' do
  original_stdout = $stdout

  let(:tic_tac_toe) do
    cli = CLI.new
    TicTacToe.new(cli)
  end

  before(:each) do
    $stdout = StringIO.new
  end

  after(:each) do
    $stdout = original_stdout
  end

  let(:stdout_ouput) do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('1', '2', '3', '4', '5', '6', '7')
    tic_tac_toe.start

    $stdout.string.split("\n")
  end

  it 'should welcome user when they first start the program' do
    expect(stdout_ouput[0]).to eq 'Welcome to a game of Tic-Tac-Toe!'
  end

  it 'should see the board after the welcome message' do
    expect(stdout_ouput[1]).to eq ' 1 | 2 | 3 '
    expect(stdout_ouput[2]).to eq '-----------'
    expect(stdout_ouput[3]).to eq ' 4 | 5 | 6 '
    expect(stdout_ouput[4]).to eq '-----------'
    expect(stdout_ouput[5]).to eq ' 7 | 8 | 9 '
  end

  it 'should ask the user to make a move' do
    expect(stdout_ouput[6]).to eq 'Enter a number to make a move in the corresponding square:'
  end

  it 'should update board with user\'s first move' do
    expect(stdout_ouput[7]).to eq ' X | 2 | 3 '
    expect(stdout_ouput[8]).to eq '-----------'
    expect(stdout_ouput[9]).to eq ' 4 | 5 | 6 '
    expect(stdout_ouput[10]).to eq '-----------'
    expect(stdout_ouput[11]).to eq ' 7 | 8 | 9 '
  end
end
