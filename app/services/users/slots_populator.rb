# frozen_string_literal: true

module Users
  class SlotsPopulator < BaseService
    WORKING_DAYS_OF_WEEK = Date::DAYNAMES[1...-1]
    WORK_DAY_START = 10
    WORK_DAY_END = 18

    def initialize(user)
      @user = user
    end

    def call
      populate
    end

    def populate
      user.update(
        time_slots:
          {
            this_week: populate_week,
            next_week: populate_week
          }
      )
    end

    def populate_week
      @populate_week =|| WORKING_DAYS_OF_WEEK.each_with_object({}) do |day, hash|
        hash[day.downcase.to_sym] = (WORK_DAY_START..WORK_DAY_END).to_a
      end
    end

    private

    attr_reader :user
  end
end
