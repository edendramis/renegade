require 'renegade/branch_name'
require 'stringio'

describe Renegade::BranchName do
  subject { Renegade::BranchName }

  before do
    $stdout = StringIO.new
  end

  after(:all) do
    $stdout = STDOUT
  end

  it 'should not be a valid branch name' do
    branch_check = subject.new('Branch Name')
    branch_check.check_branch_name('zzzzzz').must_equal(false)
    branch_check.check_branch_name('bug').must_equal(false)
    branch_check.check_branch_name('bug-').must_equal(false)
    branch_check.check_branch_name('story').must_equal(false)
    branch_check.check_branch_name('story-').must_equal(false)
  end

  it 'should be a valid branch name' do
    branch_check = subject.new('Branch Name')
    branch_check.check_branch_name('bug-1234').must_equal(true)
    branch_check.check_branch_name('bug-1234-description').must_equal(true)
    branch_check.check_branch_name('bug-1234 description').must_equal(true)
    branch_check.check_branch_name('story-1234').must_equal(true)
    branch_check.check_branch_name('story-1234-description').must_equal(true)
    branch_check.check_branch_name('story-1234 description').must_equal(true)
  end
end
