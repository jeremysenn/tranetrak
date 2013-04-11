class Bodycomp < ActiveRecord::Base
  validates :height,  :presence => {:message => "Height cannot be blank"}
  validates :weight, :presence => {:message => "Weight cannot be blank"}
  validates :pec, :presence => {:message => "Chest cannot be blank"}
  validates :umbilical, :presence => {:message => "Abdominal cannot be blank"}
  validates :quad, :presence => {:message => "Thigh cannot be blank"}

  belongs_to :client

  def sum_of_3
    unless pec.blank? or umbilical.blank? or quad.blank?
      pec + umbilical + quad
    else
      nil
    end
  end

  def sum_of_5
   
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
  def bodydensity
    unless sum_of_7.nil?
      if sex == 'Male'
        1.11200000 - 0.00043499 * sum_of_7 + (0.00000055 * sum_of_7**2) - (0.00028826 * age)
      elsif sex == 'Female'
        1.097 - 0.00046971 * sum_of_7 + (0.00000056 * sum_of_7**2) - (0.00012828 * age)
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

  def bmi
    if height_units == "inches"
      h = (height * 0.0254)
    elsif height_units == "centimeters"
      h = (height * 0.01)
    end
    if weight_units == "pounds"
      w = (weight * 0.45359237)
    elsif weight_units == "kilograms"
      w = weight
    end
    (w/(h * h)).round(2)
  end

  def waist_hip_ratio
    unless waist.blank? or hip.blank?
      (waist/hip).round(2)
    else
      nil
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
end
