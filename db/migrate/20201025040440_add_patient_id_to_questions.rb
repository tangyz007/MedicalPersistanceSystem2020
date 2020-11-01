class AddPatientIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :patient_id, :integer
  end
end
