module BodycompsHelper

  def bodycomp_donut_data(bodycomp)
    [
      {label: "Lean Mass", value: bodycomp.lean_mass.round(1)},
      {label: "Fat Mass", value: bodycomp.fat_mass.round(1)},
    ]
  end

  def bodycomp_comparison_data(bodycomps)
    bodycomps.map do |bodycomp|
      {
        date: bodycomp.date,
        weight: bodycomp.weight,
        leanmass: bodycomp.lean_mass.round(1),
        fatmass: bodycomp.fat_mass.round(1)
      }
    end
  end

  def bodyfat_chart_data(bodycomps)
    bodycomps.map do |bodycomp|
      {
        date: bodycomp.date,
        bodyfat: bodycomp.bodyfat_percent.round(1)
      }
    end
  end

  def leanmass_chart_data(bodycomps)
    bodycomps.map do |bodycomp|
      {
        date: bodycomp.date,
        leanmass: bodycomp.lean_mass.round(1)
      }
    end
  end

  def fatmass_chart_data(bodycomps)
    bodycomps.map do |bodycomp|
      {
        date: bodycomp.date,
        fatmass: bodycomp.fat_mass.round(1)
      }
    end
  end

  def metabolic_rate_chart_data(bodycomps)
    bodycomps.map do |bodycomp|
      {
        date: bodycomp.date,
        metabolic_rate: bodycomp.bmr.round
      }
    end
  end

  def bmi_chart_data(bodycomps)
    bodycomps.map do |bodycomp|
      {
        date: bodycomp.date,
        bmi: bodycomp.bmi.round
      }
    end
  end

  def whr_chart_data(bodycomps)
    bodycomps.map do |bodycomp|
      {
        date: bodycomp.date,
        whr: bodycomp.waist_hip_ratio
      }
    end
  end

  

end
