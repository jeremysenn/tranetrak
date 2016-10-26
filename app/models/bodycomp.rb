class Bodycomp < ActiveRecord::Base
  validates :height,  :presence => {:message => "Height cannot be blank"}
  validates :weight, :presence => {:message => "Weight cannot be blank"}
  validates :pec, :presence => {:message => "Chest skinfold cannot be blank"}, :if => :male?
  validates :umbilical, :presence => {:message => "Abdominal skinfold cannot be blank"}, :if => :male?
  validates :tri, :presence => {:message => "Triceps skinfold cannot be blank"}, :if => :female?
  validates :suprailiac, :presence => {:message => "Suprailiac skinfold cannot be blank"}, :if => :female?
  validates :quad, :presence => {:message => "Thigh skinfold cannot be blank"}

  attr_accessor :skinfold_sites

  belongs_to :client
  has_many :pictures, :as => :imageable,  :dependent => :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true, :reject_if => lambda { |a| a[:image].blank? }

  def bodycomp_summary_email
    UserMailer.new_bodycomp_completed(self).deliver
  end

  def male?
    sex == 'Male'
  end

  def female?
    sex == 'Female'
  end

  def sum_of_3_male
    unless pec.blank? or umbilical.blank? or quad.blank?
      pec + umbilical + quad
    else
      nil
    end
  end

  def sum_of_3_female
    unless tri.blank? or suprailiac.blank? or quad.blank?
      tri + suprailiac + quad
    else
      nil
    end
  end

  def sum_of_7
    unless pec.blank? or tri.blank? or subscap.blank? or suprailiac.blank? or midaxil.blank? or umbilical.blank? or quad.blank?
      pec + tri + subscap + suprailiac + midaxil + umbilical + quad
    else
      nil
    end
  end

  # MEN SEVEN SITE JACKSON POLLOCK ===> X = sum of 7 | BD = 1.11200000 - 0.00043499(X) + 0.00000055(X)(X) - 0.00028826 (Age)
  # WOMEN SEVEN SITE JACKSON POLLOCK ===> X = sum of 7 | BD = 1.097 - 0.00046971(X) + 0.00000056(X)(X) - 0.00012828(Age)
  # MEN THREE SITE JACKSON POLLOCK ==> Body Density = 1.10938 - (0.0008267 x sum of chest, abdomen and thigh skinfolds in mm ) + (0.0000016 x square of the sum of chest, abdomen and thigh) - (0.0002574 x age)
  # WOMEN THREE SITE JACKSON POLLOCK ==> Body Density = 1.0994921 - (0.0009929 x sum of triceps, thigh and suprailiac skinfolds) + (0.0000023 x square of the sum of triceps, thigh and suprailiac skinfolds)
  def bodydensity
    if not sum_of_7.nil?
      if sex == 'Male'
        1.11200000 - 0.00043499 * sum_of_7 + (0.00000055 * sum_of_7**2) - (0.00028826 * age)
      elsif sex == 'Female'
        1.097 - 0.00046971 * sum_of_7 + (0.00000056 * sum_of_7**2) - (0.00012828 * age)
      end
    elsif (not (sex == 'Male' and sum_of_3_male.nil?) or not (sex == 'Female' and sum_of_3_female.nil?))
      if sex == 'Male'
        1.10938 -  0.0008267 * sum_of_3_male + (0.0000016 * sum_of_3_male**2) - (0.0002574 * age)
      elsif sex == 'Female'
        1.0994921 - 0.0009929 * sum_of_3_female + (0.0000023 * sum_of_3_female**2)
      end
    else
      nil
    end
  end


  def bodyfat_percent
    (4.95/bodydensity - 4.5) * 100
  end

  def defense_bodyfat_percent
    if sex == 'Male'
      86.010 * Math.log10(waist - neck) - (70.041 * Math.log10(height_in_inches)) + 36.76
    elsif sex == 'Female'
      163.205 * Math.log10(waist + hip - neck) - (97.684 * Math.log10(height_in_inches)) - 78.387
    end
  end

  def lean_mass
    weight - fat_mass
  end

  def defense_lean_mass
    weight - defense_fat_mass
  end

  def fat_mass
    bodyfat_percent/100 * weight
  end

  def defense_fat_mass
    defense_bodyfat_percent/100 * weight
  end

  def waist_hip_ratio
    unless waist.blank? or hip.blank?
      (waist/hip).round(2)
    else
      nil
    end
  end
  
  def abdominal_obesity?
    (sex == "Male" and circumference_units == "inches" and waist > 40) or (sex == "Male" and circumference_units == "centimeters" and waist > 102) or (sex == "Female" and circumference_units == "inches" and waist > 35) or (sex == "Female" and circumference_units == "centimeters" and waist > 88)
  end
  
  def whr_low_risk?
    (sex == "Male" and waist_hip_ratio <= 0.95) or (sex == "Female" and waist_hip_ratio <= 0.80)
  end
  
  def whr_moderate_risk?
    (sex == "Male" and waist_hip_ratio > 0.95 and waist_hip_ratio <= 1) or (sex == "Female" and waist_hip_ratio > 0.80 and waist_hip_ratio <= 0.85)
  end
  
  def whr_high_risk?
    (sex == "Male" and waist_hip_ratio > 1) or (sex == "Female" and waist_hip_ratio > 0.85)
  end
  
  def goal_waist_circumference
    unless whr_low_risk?
      if whr_high_risk?
        if male?
          w = hip * 1
        elsif female?
          w = hip * 0.85
        end
      elsif whr_moderate_risk?
        if male?
          w = hip * 0.95
        elsif female?
          w = hip * 0.80
        end
      end
      return w
    else
      "N/A"
    end
  end
  
  def long_term_goal_waist_circumference
    unless whr_low_risk? or whr_moderate_risk?
      if male?
          w = hip * 0.95
      elsif female?
        w = hip * 0.80
      end
      return w
    else
      nil
    end
  end
  
  def goal_waist_reduction
    unless goal_waist_circumference == "N/A"
      waist - goal_waist_circumference
    else
      0
    end
  end
  
  def long_term_goal_waist_reduction
    unless long_term_goal_waist_circumference.blank?
      waist - long_term_goal_waist_circumference
    else
      0
    end
  end

  ### Katch-McArdle Formula (Basil Metabolic Rate) ###
  def bmr
    if weight_units == "pounds"
      370 + (9.79759519 * lean_mass)
    else
      370 + (21.6 * lean_mass)
    end
  end

  def height_in_inches
    if height_units == "inches"
      return height
    else
      return height/2.54
    end
  end

  def weight_in_pounds
    if weight_units == "pounds"
      return weight
    else
      return weight*2.2
    end
  end
  
  ### BMI Calculations ###
  
  def height_in_meters
    if height_units == "inches"
      return height * 0.0254
    elsif height_units == "centimeters"
      return height * 0.01
    end
  end
  
  def weight_in_kilograms
    if weight_units == "pounds"
      weight * 0.45359237
    elsif weight_units == "kilograms"
      weight
    end
  end
  
  def bmi
    h = height_in_meters
    w = weight_in_kilograms
    return (w/(h * h)).round(1)
  end
  
  def underweight_bmi?
    bmi < 18.5
  end
  
  def normal_bmi?
    bmi >= 18.5 and bmi <= 24.9
  end
  
  def overweight_bmi?
    bmi >= 25 and bmi <= 29.9
  end
  
  def obese_bmi?
    bmi >= 30
  end
  
  def bmi_goal_status
    if underweight_bmi?
      "N/A"
    elsif  normal_bmi?
      "Normal - Low End"
    elsif overweight_bmi?
      "Normal"
    elsif obese_bmi?
      "Overweight"
    else
      "N/A"
    end
  end
  
  def bmi_goal
    if underweight_bmi?
      "N/A"
    elsif  normal_bmi?
      18.5
    elsif overweight_bmi?
      24.9
    elsif obese_bmi?
      29.9
    else
      "N/A"
    end
  end
  
  def bmi_goal_weight_loss
    unless underweight_bmi?
      if obese_bmi?
        w = 29.9 * (height_in_meters * height_in_meters)
      elsif overweight_bmi?
        w = 24.9 * (height_in_meters * height_in_meters)
      elsif normal_bmi?
        w = 18.5 * (height_in_meters * height_in_meters)
      end
      if weight_units == "pounds"
        return weight - (w * 2.20462) # Convert to pounds
      elsif weight_units == "kilograms"
        return weight - w # Keep in kilograms
      end
    else
      return 0
    end
  end
  
  def long_term_bmi_goal_weight_loss
    if obese_bmi?
      w = 24.9 * (height_in_meters * height_in_meters)
      if weight_units == "pounds"
        return weight - (w * 2.20462) # Convert to pounds
      elsif weight_units == "kilograms"
        return weight - w # Keep in kilograms
      end
    elsif overweight_bmi?
      w = 18.5 * (height_in_meters * height_in_meters)
      if weight_units == "pounds"
        return weight - (w * 2.20462) # Convert to pounds
      elsif weight_units == "kilograms"
        return weight - w # Keep in kilograms
      end
    else
      return 0
    end
  end
  
  ### End BMI Calculations ###
  
  ### Bodycomp Calculations ###
  
  def essential_fat_bodycomp?
    (sex == "Male" and bodyfat_percent <= 4) or (sex == "Female" and bodyfat_percent <= 12)
  end
  
  def athlete_bodycomp?
    (sex == "Male" and bodyfat_percent <= 13 and bodyfat_percent > 4) or (sex == "Female" and bodyfat_percent <= 20 and bodyfat_percent > 12)
  end
  
  def fitness_bodycomp?
    (sex == "Male" and bodyfat_percent <= 17 and bodyfat_percent > 13) or (sex == "Female" and bodyfat_percent <= 24 and bodyfat_percent > 20)
  end
  
  def acceptable_bodycomp?
    (sex == "Male" and bodyfat_percent <= 25 and bodyfat_percent > 17) or (sex == "Female" and bodyfat_percent <= 31 and bodyfat_percent > 24)
  end
  
  def obese_bodycomp?
    (sex == "Male" and bodyfat_percent >= 25) or (sex == "Female" and bodyfat_percent > 31)
  end
  
  def bodycomp_goal_classification
    if essential_fat_bodycomp?
      "N/A"
    elsif athlete_bodycomp?
      "Athletes - Low End"
    elsif fitness_bodycomp?
      "Athletes"
    elsif acceptable_bodycomp?
      "Fitness"
    elsif obese_bodycomp?
      "Acceptable"
    else
      "N/A"
    end
  end
  
  def long_term_bodycomp_goal_classification
    if essential_fat_bodycomp? or athlete_bodycomp?
      nil
    elsif fitness_bodycomp?
      "Athletes - Low End"
    elsif acceptable_bodycomp?
      "Athletes"
    elsif obese_bodycomp?
      "Fitness"
    else
      nil
    end
  end
  
  def bodycomp_goal_percentage
    if athlete_bodycomp? or fitness_bodycomp? or acceptable_bodycomp? or obese_bodycomp?
      if athlete_bodycomp?
        if male?
          0.06
        elsif female?
         0.14
        end
      elsif fitness_bodycomp?
        if male?
          0.13
        elsif female?
         0.20
        end
      elsif acceptable_bodycomp?
        if male?
          0.17
        elsif female?
          0.24
        end
      elsif obese_bodycomp?
        if male?
          0.25
        elsif female?
          0.31
        end
      end
    else
      return "N/A"
    end
  end
  
  def long_term_bodycomp_goal_percentage
    if fitness_bodycomp? or acceptable_bodycomp? or obese_bodycomp?
      if fitness_bodycomp?
        if male?
          0.06
        elsif female?
         0.14
        end
      elsif acceptable_bodycomp?
        if male?
          0.13
        elsif female?
         0.20
        end
      elsif obese_bodycomp?
        if male?
          0.17
        elsif female?
          0.24
        end
      end
    else
      nil
    end
  end
  
  def bodycomp_goal_fat_loss
    #############################################################
    # (fat mass / weight) = bodyfat%                            #
    # (fat mass / (fat mass + lean mass)) = bodyfat%            #
    # fat mass = (lean mass * body fat percent) / (1 - bodyfat%)#
    #############################################################
    if athlete_bodycomp? or fitness_bodycomp? or acceptable_bodycomp? or obese_bodycomp?
      goal_fat_mass = (lean_mass * bodycomp_goal_percentage) / (1 - bodycomp_goal_percentage)
      return (fat_mass - goal_fat_mass)
    else
      return 0
    end
  end
  
  def long_term_bodycomp_goal_fat_loss
    #############################################################
    # (fat mass / weight) = bodyfat%                            #
    # (fat mass / (fat mass + lean mass)) = bodyfat%            #
    # fat mass = (lean mass * body fat percent) / (1 - bodyfat%)#
    #############################################################
    if fitness_bodycomp? or acceptable_bodycomp? or obese_bodycomp?
      goal_fat_mass = (lean_mass * long_term_bodycomp_goal_percentage) / (1 - long_term_bodycomp_goal_percentage)
      return (fat_mass - goal_fat_mass)
    else
      return 0
    end
  end
  
  ### End Bodycomp Calculations ###
  
  ### Priority Values ###
  ### All numbers relative to triceps ###
  def pec_pvalue
    # Optimal is pec <=3mm for Male and Female
    (pec - tri)/tri * 100
  end

  def subscap_pvalue
    # Optimal is subscap <=10mm for Male and Female
    ((subscap - 5) - tri)/tri * 100
  end

  def midaxil_pvalue
    # Optimal is midaxil <=5mm for Male and Female
    (midaxil - tri)/tri * 100
  end

  def suprailiac_pvalue
    # Optimal is suprailiac <10mm for Male and Female
    ((suprailiac - 5) - tri)/tri * 100
  end

  def umbilical_pvalue
    # Optimal is umbilical <8mm for Male and umbilical <13mm for Female
    ((umbilical - 3) - tri)/tri * 100
  end
  
  def quad_pvalue
    # Optimal is quad <5mm for Male and quad <15mm for Female
    if male?
      (quad - tri)/tri * 100
    elsif female?
      ((quad - (0.5 * tri)) - tri)/tri * 100
    end
  end
  
  def high_triceps_skinfold?
    if male?
      tri > 10
    elsif female?
      tri > 15
    end
  end
  
  def priority_hash ## SORTED
    Hash["Chest", pec_pvalue, "Subscapular", subscap_pvalue, "Midaxillary", midaxil_pvalue, "Suprailiac", suprailiac_pvalue, "Abdominal", umbilical_pvalue, "Thigh", quad_pvalue].sort {|a,b| a[1]<=>b[1]}.reverse
  end

  def priority_list
    list = []
    priority_hash.first(3).each do |site|
      if site[1] > 0
        list << site[0]
      end
    end
    return list
  end
  ### End Priority Values ###
      
end
