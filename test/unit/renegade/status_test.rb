require 'renegade/status'
require 'stringio'

describe Renegade::Status do
  subject { Renegade::Status }

  before do
    $stdout = StringIO.new
  end

  after(:all) do
    $stdout = STDOUT
  end

  it 'shows passed status' do
    subject.report('Good Label', true)
    $stdout.string.must_equal('  √ Good Label'.green + "\n")
  end

  it 'shows failed status' do
    subject.report('Bad Label', false)
    $stdout.string.must_equal('  × Bad Label'.red + "\n")
  end

  it 'shows warning status' do
    subject.report('Warning Label', false, true)
    $stdout.string.must_equal('  × Warning Label'.yellow + "\n")
  end

  it 'shows hook starting' do
    subject.hook_start('Hook Name')
    $stdout.string.must_equal("\nRunning Hook Name hooks…\n")
  end
end
