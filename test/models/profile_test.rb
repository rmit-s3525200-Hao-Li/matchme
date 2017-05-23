require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  
  def setup
    @profile = profiles(:matt_profile)
  end
  
  test "should be valid" do
    assert @profile.valid?
  end
  
  test "user id should be present" do
    @profile.user_id = nil
    assert_not @profile.valid?
  end
  
  test "first_name should be present" do
    @profile.first_name = "     "
    assert_not @profile.valid?
  end
  
  test "first_name shouldn't be more than 25 characters" do
    @profile.first_name = "a" * 26 
    assert_not @profile.valid?
  end
  
  test "last_name should be present" do
    @profile.last_name = "     "
    assert_not @profile.valid?
  end
  
  test "last_name shouldn't be more than 25 characters" do
    @profile.first_name = "a" * 26 
    assert_not @profile.valid?
  end
  
  test "occupation should be present" do
    @profile.occupation = "     "
    assert_not @profile.valid?
  end
  
  test "occupation shouldn't be too long" do
    @profile.occupation = "a" * 56
    assert_not @profile.valid?
  end
  
  test "occupation should be saved in lower-case" do
    mixed_case_occuption = "aCcoUntAnt"
    @profile.occupation = mixed_case_occuption
    @profile.save
    assert_equal mixed_case_occuption.downcase, @profile.reload.occupation
  end
  
  test "name should be a titleized string of first_name and last_name" do
    @profile.first_name = "xieyang"
    @profile.last_name = "wu"
    @profile.save
    assert_equal "Xieyang Wu", @profile.reload.name
  end
  
  test "post code should not be more than 20 characters" do
    @profile.post_code = "a" * 21
    assert_not @profile.valid?
  end
  
  test "self-summary should not be more than 800 characters" do
    @profile.post_code = "a" * 801
    assert_not @profile.valid?
  end
  
  test "preferred_gender should accept valid inputs" do
    valid_genders = Choices["preferred_gender"]
    valid_genders.each do |vg|
      @profile.preferred_gender = vg
      assert @profile.valid?, "#{vg.inspect} should be valid"
    end
  end
  
  test "preferred_gender should not accept invalid inputs" do
    invalid_genders = %w[hmmm nope invalid try again]
    invalid_genders.each do |ig|
      @profile.preferred_gender = ig
      assert_not @profile.valid?, "#{ig.inspect} should not be valid"
    end
  end
  
  test "gender should accept valid inputs" do
    valid_genders = Choices["gender"]
    valid_genders.each do |vg|
      @profile.gender = vg
      assert @profile.valid?, "#{vg.inspect} should be valid"
    end
  end
  
  test "gender should not accept invalid inputs" do
    invalid_genders = %w[hmmm nope invalid try again]
    invalid_genders.each do |ig|
      @profile.gender = ig
      assert_not @profile.valid?, "#{ig.inspect} should not be valid"
    end
  end
  
  test "looking_for should accept valid inputs" do
    valid_looking_fors = Choices["looking_for"]
    valid_looking_fors.each do |vlf|
      @profile.looking_for = vlf
      assert @profile.valid?, "#{vlf.inspect} should be valid"
    end
  end
  
  test "looking_fors should not accept invalid inputs" do
    invalid_looking_fors = %w[hmmm nope invalid try again]
    invalid_looking_fors.each do |ilf|
      @profile.looking_for = ilf
      assert_not @profile.valid?, "#{ilf.inspect} should not be valid"
    end
  end
  
  test "edu_status should accept valid inputs" do
    valid_edu_statuses = Choices["edu_status"]
    valid_edu_statuses.each do |ves|
      @profile.edu_status = ves
      assert @profile.valid?, "#{ves.inspect} should be valid"
    end
  end
  
  test "edu_status should not accept invalid inputs" do
    invalid_edu_statuses = %w[hmmm nope invalid try again]
    invalid_edu_statuses.each do |ies|
      @profile.edu_status = ies
      assert_not @profile.valid?, "#{ies.inspect} should not be valid"
    end
  end
  
  test "edu_type should accept valid inputs" do
    valid_edu_types = Choices["edu_type"]
    valid_edu_types.each do |vet|
      @profile.edu_type = vet
      assert @profile.valid?, "#{vet.inspect} should be valid"
    end
  end
  
  test "edu_type should not accept invalid inputs" do
    invalid_edu_types = %w[hmmm nope invalid try again]
    invalid_edu_types.each do |iet|
      @profile.edu_type = iet
      assert_not @profile.valid?, "#{iet.inspect} should not be valid"
    end
  end
  
  test "smoke should accept valid inputs" do
    valid_smoke = Choices["smoke"]
    valid_smoke.each do |vs|
      @profile.smoke = vs
      assert @profile.valid?, "#{vs.inspect} should be valid"
    end
  end
  
  test "smoke should not accept invalid inputs" do
    invalid_smoke = %w[hmmm nope invalid try again]
    invalid_smoke.each do |is|
      @profile.smoke = is
      assert_not @profile.valid?, "#{is.inspect} should not be valid"
    end
  end
  
  test "drink should accept valid inputs" do
    valid_drinks = Choices["drink"]
    valid_drinks.each do |vd|
      @profile.drink = vd
      assert @profile.valid?, "#{vd.inspect} should be valid"
    end
  end
  
  test "drink should not accept invalid inputs" do
    invalid_drinks = %w[hmmm nope invalid try again]
    invalid_drinks.each do |id|
      @profile.drink = id
      assert_not @profile.valid?, "#{id.inspect} should not be valid"
    end
  end
  
  test "drugs should accept valid inputs" do
    valid_drugs = Choices["drugs"]
    valid_drugs.each do |vd|
      @profile.drugs = vd
      assert @profile.valid?, "#{vd.inspect} should be valid"
    end
  end
  
  test "drugs should not accept invalid inputs" do
    invalid_drugs = %w[hmmm nope invalid try again]
    invalid_drugs.each do |id|
      @profile.drugs = id
      assert_not @profile.valid?, "#{id.inspect} should not be valid"
    end
  end
  
  test "diet should accept valid inputs" do
    valid_diets = Choices["diet"]
    valid_diets.each do |vd|
      @profile.diet = vd
      assert @profile.valid?, "#{vd.inspect} should be valid"
    end
  end
  
  test "diet should not accept invalid inputs" do
    invalid_diets = %w[hmmm nope invalid try again paleo]
    invalid_diets.each do |id|
      @profile.diet = id
      assert_not @profile.valid?, "#{id.inspect} should not be valid"
    end
  end
  
  test "religion should accept valid inputs" do
    valid_religions = Choices["religion"]
    valid_religions.each do |vr|
      @profile.religion = vr
      assert @profile.valid?, "#{vr.inspect} should be valid"
    end
  end
  
  test "religion should not accept invalid inputs" do
    invalid_religions = %w[hmmm nope invalid try again]
    invalid_religions.each do |ir|
      @profile.religion = ir
      assert_not @profile.valid?, "#{ir.inspect} should not be valid"
    end
  end
  
  test "min_age must be greater than or equal to 18" do
    @profile.min_age = 17
    assert_not @profile.valid?
  end
  
  test "max_age must be greater than or equal to min_age" do
    @profile.min_age = 30
    @profile.max_age = 29
    assert_not @profile.valid?
  end
  
  test "users cannot be younger than 18" do
    year = Date.today.year - 17
    @profile.date_of_birth = Date.new(year, 1, 1)
    assert_not @profile.valid?
  end
  
  test "profile should have address" do
    @profile.city = "San Francisco"
    @profile.post_code = "94016"
    @profile.country = "United States"
    assert_equal "San Francisco, 94016, United States", @profile.address
  end
  
  test "profile should have education" do
    @profile.edu_status = "completed"
    @profile.edu_type = "university"
    assert_equal "completed university", @profile.education
  end
  
  test "should have edu_num" do
    assert !@profile.edu_num.nil?
  end
  
  test "should have drink_num" do
    assert !@profile.drink_num.nil?
  end
  
  test "should have drugs_num" do
    assert !@profile.drugs_num.nil?
  end
  
  test "should have smoke_num" do
    assert !@profile.smoke_num.nil?
  end
  
  test "should have interests_array" do
    @profile.movies = "Alien"
    array = [[],["Alien"],["Tame Impala"],["Silicon Valley"],[],[],[]]
    assert_equal array, @profile.interests_array
  end
  
  test "should have count_interests" do
    assert_not @profile.count_interests.nil?
    assert_difference '@profile.count_interests', 1 do
      @profile.hobbies = "Dancing"
    end
  end
  
  test "should have age range" do
    @profile.min_age = 52
    @profile.max_age = 62
    assert_equal (52..62).to_a, @profile.age_range
  end
  
end
