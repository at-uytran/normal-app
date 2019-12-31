class LocaleConstraint
  ACCEPT_LANGUAGES = %w(vi en)
  DEFAULT_LANGUAGE = ACCEPT_LANGUAGES.first

  class << self
    def matches? request
      request.params[:locale].in? ACCEPT_LANGUAGES
    end
  end
end
