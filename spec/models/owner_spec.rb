require 'rails_helper'

RSpec.describe Owner, :type => :model do
  before(:all) do
    10.times do
      Bird.create()
    end
  end

	describe "mass assignment" do
  	it { is_expected.to allow_mass_assignment_of :name }
    it { is_expected.to allow_mass_assignment_of :address }
    it { is_expected.to allow_mass_assignment_of :email }
    it { is_expected.to allow_mass_assignment_of :age }
	end

  describe "associations" do
    it { is_expected.to have_many :dogs }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :email }
  end

  describe "instance methods" do
    before(:each) do # before(:eam)
      owner.name = "sucker"
      owner.save!
    end

    # let vs. let!
    let!(:dogs) { FactoryGirl.create_list(:dog, 10) }
    let(:dog) { FactoryGirl.create(:dog) }
    let(:cat) { Cat.create(:name => "snuggles", :desc => "furry") }
    let(:owner) { Owner.create(:name => "Bob the builder", :age => 21) }
    let(:owner_1) { FactoryGirl.create(owner, :name => "Bob the builder", :age => 21) }
    let(:owner_with_dogs) { FactoryGirl.create(:owner_with_dogs, :age => 21, :dog_count => 4) }

    describe "matcher examples" do
      it "responding to methods" do
        expect(owner).to respond_to :fork_money_for_useless_catbed
      end

      it "basic matchers" do
        expect(owner.age).to be >= 10
        expect(owner.age).to be < 100
        expect(owner.age).to be_within(10).of(29)

        # arrays
        expect([21, 23, 25]).to include(owner.age)
        expect([21, 23, 25]).to match_array([25, 21, 23])

        # strings
        expect(owner.name).to start_with "s"

        # combining matchers
        expect(owner.name).to start_with("s").and end_with('r')

        # composing matchers
        expect([owner.name]).to contain_exactly(a_string_starting_with("s"))
      end

      it "when its a dog, should ignore it" do
        expect(owner.pet_animal(dog)).to eq :ignored
      end
    end

    describe "mocking (or stubbing) methods" do
      it "using allow - the same but without the checking" do
        allow(owner).to receive(:likes_animal?).and_return true
        expect(owner.pet_animal(dog)).to eq :petted
      end

      it "basic expectation" do
        expect(owner).to receive(:likes_animal?)
        owner.pet_animal(cat)
        # expect(owner.pet_animal(cat)).to eq :petted # this no longer works without and_return
      end

      it "specifying a return value" do
        expect(owner).to receive(:likes_animal?).and_return false
        expect(owner.pet_animal(dog)).to eq :ignored
      end

      # it "mocking can ruin your life - does not actually execute method" do
      #   expect(owner).to receive(:one)
      #   expect(owner.multiply(10)).to eq 10
      # end

      it "using any_instance_of" do
        expect_any_instance_of(Owner).to receive(:likes_animal?).and_return false
        expect(owner.pet_animal(dog)).to eq :ignored
      end

      describe "specifying arguments" do
        it "basic argument" do
          expect(owner).to receive(:likes_animal?).with(dog, 1).and_return false
          expect(owner.pet_animal(dog)).to eq :ignored
        end

        it "using an_instance_of with arguments" do
          expect(owner).to receive(:likes_animal?).with(an_instance_of(Dog), 1).and_return false
          expect(owner.pet_animal(dog)).to eq :ignored
        end

        it "using anything with arguments (composing matchers)" do
          # any_args, no_args, array_including, hash_excluding
          expect(owner).to receive(:likes_animal?).with(anything, 1).and_return false
          expect(owner.pet_animal(dog)).to eq :ignored
        end
      end

      it "checking after the fact" do
        allow(owner).to receive(:likes_animal?) # this is required
        owner.pet_animal(cat)
        expect(owner).to have_received(:likes_animal?).exactly(1).times
      end

      it "ordering expectations" do
        expect(owner).to receive(:multiply).ordered
        expect(owner).to receive(:likes_animal?).ordered
        owner.pet_animal(cat)
      end
    end

    describe "using expect/change with a block" do
      it "change" do
        expect{
          owner.adopt_cat(cat)
        }.to change{ owner.cats.count }.by(1) # .from(0).to(1)
      end

      it "exceptions" do
        expect{
          1 / 0
        }.to raise_error # to_not
      end
    end

    describe "metaprogram to produce lots of specs" do
      [:pet, :feed].each do |action|
        it "when its a dog, should ignore it when asked to #{action}" do
          expect(owner.send("#{action}_animal", dog)).to eq :ignored
        end
      end
    end
  end

  # nb
  after(:all) do
    Bird.destroy_all
  end

end
