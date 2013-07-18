module BodycompsHelper

  def bodycomp_donut_data(bodycomp)
    [
      {label: "Lean Mass", value: bodycomp.lean_mass.round(1)},
      {label: "Fat Mass", value: bodycomp.fat_mass.round(1)},
    ]
  end

  def bodycomp_percent_donut_data(bodycomp)
    [
      {label: "Body Fat %", value: bodycomp.bodyfat_percent.round(1)},
      {label: "Lean %", value: (100 - bodycomp.bodyfat_percent.round(1))},
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

  def bodyfat_and_bmi_chart_data(bodycomps)
    bodycomps.map do |bodycomp|
      {
        date: bodycomp.date,
        bodyfat: bodycomp.bodyfat_percent.round(1),
        bmi: bodycomp.bmi.round(1)
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

  def all_skinfolds_chart_data(bodycomps)
    bodycomps.map do |bodycomp|
      {
        date: bodycomp.date,
        pec: bodycomp.pec,
        tri: bodycomp.tri,
        subscap: bodycomp.subscap,
        suprailiac: bodycomp.suprailiac,
        midaxil: bodycomp.midaxil,
        umbilical: bodycomp.umbilical,
        quad: bodycomp.quad
      }
    end
  end

  def all_girths_chart_data(bodycomps)
    bodycomps.map do |bodycomp|
      {
        date: bodycomp.date,
        waist: bodycomp.waist,
        hip: bodycomp.hip,
        neck: bodycomp.neck,
        shoulder: bodycomp.shoulder,
        chest: bodycomp.chest,
        arm: bodycomp.arm,
        thigh: bodycomp.thigh,
        gastroc: bodycomp.gastroc
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
