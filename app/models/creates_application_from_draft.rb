class CreatesApplicationFromDraft
  STUDENT_FIELDS = ApplicationDraft::STUDENT0_REQUIRED_FIELDS + ApplicationDraft::STUDENT1_REQUIRED_FIELDS

  delegate :team, to: :application_draft

  attr_reader :application_draft

  def initialize(application_draft)
    @application_draft = application_draft
  end

  def save
    application.save
  end

  def application
    @application ||= Application.new(application_attributes)
  end

  def application_attributes
    {
      team: team,
      application_draft: application_draft,
      application_data: application_data,
      season: application_draft.season,
    }
  end

  private

  def application_data
    {
      voluntary: application_draft.voluntary?,
      voluntary_hours_per_week: application_draft.voluntary_hours_per_week
    }.merge(student_attributes).merge(coaches_attributes).merge(project_attributes)
  end

  def coaches_attributes
    %w(coaches_hours_per_week coaches_why_team_successful).each_with_object({}) do |attribute, hash|
      hash[attribute] = application_draft.send(attribute)
    end
  end

  def project_attributes
    %w(project_name project_url project_plan).each_with_object({}) do |attribute, hash|
      hash[attribute] = application_draft.send(attribute)
    end

  end

  def student_attributes
    STUDENT_FIELDS.each_with_object({}) do |attribute, hash|
      hash[attribute] = application_draft.send(attribute)
    end
  end
end
