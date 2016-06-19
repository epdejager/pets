class Owner < ActiveRecord::Base
  attr_accessible :name, :email, :address, :age

  has_many :bank_accounts, 
           inverse_of: :owner,
           dependent: :destroy

  has_many :cheque_accounts, class_name: "BankAccount", 
           conditions:  "account_type = #{AccountType::CHEQUE}"

  has_and_belongs_to_many :cats

  has_one :cell_phone, inverse_of: :owner

  has_many :dogs_owners
  has_many :dogs, through: :dogs_owners

  has_many :bones_in_yards, through: :dogs

  validates_presence_of :name
  validates_uniqueness_of :email

  def pet_animal(animal, dummy = 1)
    multiply(dummy)
    if likes_animal?(animal, dummy)      
      puts "arent you gorgeous *pet-pet*"
      :petted
    else
      puts "*ignoresies*"
      :ignored
    end
  end

  def feed_animal(animal)
    if likes_animal?(animal)
      puts "have some food *feed-feed*"
      :fed
    else
      puts "*ignoresies*"
      :ignored
    end
  end  

  def likes_animal?(animal, dummy = 2)
    animal.is_a? Cat
  end

  def fork_money_for_useless_catbed
    :dorrars
  end

  def adopt_cat(cat)
    self.cats << cat
  end

  def multiply(x)
    x * one
  end

  def one
    1
  end

end
