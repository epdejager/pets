require 'rails_helper'

RSpec.describe Owner, :type => :model do
  before(:all) do
    10.times do 
      BonesInYard.create()
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
    before do
      owner.name = "sucker"
      owner.save!
    end

    let!(:dogs) { FactoryGirl.create_list(:dog, 10) }
    let(:dog) { FactoryGirl.create(:dog) }
    let(:cat) { Cat.create(:name => "snuggles", :desc => "furry") }
    let(:owner) { Owner.create(:name => "Bob the builder", :age => 21) }

    it "should be able to fork money for nothing" do
      expect(owner).to respond_to :fork_money_for_useless_catbed
    end

    it "check his age" do
      expect(owner.age).to be >= 10
      expect(owner.age).to be < 100
      expect(owner.age).to be_within(10).of(29)
      
      expect([21, 23, 25]).to include(owner.age)
      expect([21, 23, 25]).to match_array([25, 21, 23])

      expect(owner.name).to start_with "s"
      expect(owner.name).to start_with("s").and end_with('r')
      expect([owner.name]).to contain_exactly(a_string_starting_with("s"))
    end

    describe "should be able to pet and animal" do
      it "when its a dog, should ignore it" do
        expect(owner.pet_animal(dog)).to eq :ignored
      end

      it "when its a dog 1, ignore it" do
        expect(owner).to receive(:likes_animal?).with(dog).and_return false
        expect(owner.pet_animal(dog)).to eq :ignored
      end

      it "when its a dog 2, ignore it" do
        # any_args, no_args, array_including, hash_excluding
        expect(owner).to receive(:likes_animal?).with(an_instance_of(Dog)).and_return false
        expect(owner.pet_animal(dog)).to eq :ignored
      end

      it "when its a dog 2, ignore it" do
        allow(owner).to receive(:likes_animal?).and_return false
        expect(owner.pet_animal(dog)).to eq :ignored
      end

      it "when its a cat, should pet it" do
        expect_any_instance_of(Owner).to receive(:likes_animal?).once #at_least(1).times # exactly(1).times
        owner.pet_animal(cat)
        # expect(owner.pet_animal(cat)).to eq :petted # this no longer works with and_return
      end

      it "when its a cat, should pet it" do
        allow(owner).to receive(:likes_animal?) # this is required        
        owner.pet_animal(cat)
        expect(owner).to have_received(:likes_animal?).exactly(1).times
      end

      describe "should be to pet and feed an animal" do
        [:pet, :feed].each do |action|        
          it "when its a dog, should ignore it when asked to #{action}" do
            expect(owner.send("#{action}_animal", dog)).to eq :ignored
          end
        end
      end

      it "should be able to adopt a pet" do
        expect{
          owner.adopt_cat(cat)
        }.to change{ owner.cats.count }.by(1)
      end
    end    
  end

  # nb
  after(:all) do
    BonesInYard.destroy_all
  end


end
