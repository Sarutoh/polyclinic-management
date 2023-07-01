module Users
  class SlotsUpdater < BaseService
    def initialize(doctor:, patient:, fields: {})
      @doctor = doctor
      @patient = patient
      @fields = fields
    end

    def call
      ActiveRecord::Base.establish_connection.connection.execute(sql_query)
    end

    private

    attr_reader :doctor, :patient, :fields

    def sql_query
      week = 'this_week'
      day = 'monday'
      fields = [10, 11, 12, 15, 16, 17]

      User.where(id: [doctor.id, patient.id]).each do |user|
        user.time_slots.update(
          {
            "this_week": {
              "friday": fields
            }
          }
        )
      end

      # "UPDATE users SET time_slots = jsonb_set('this_week', \'{#{day}}\', '#{fields.to_json}') WHERE ID IN (#{doctor.id},#{patient.id});"
      # "UPDATE users SET time_slots = jsonb_set(this_week, \'{wednesday}\', '[10, 11, 12, 14, 15, 16, 17]') WHERE ID IN (#{doctor.id},#{patient.id});"
    end
  end
end