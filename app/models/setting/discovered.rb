class Setting::Discovered < ::Setting
  BLANK_ATTRS << "discovery_location"
  BLANK_ATTRS << "discovery_organization"

  def self.load_defaults
    # Check the table exists
    return unless super

    Setting.transaction do
      [
        self.set('discovery_fact', _("The default fact name to use for the MAC of the system"), "discovery_bootif"),
      ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
    end

    if SETTINGS[:locations_enabled]
      Setting.transaction do
        [
          self.set('discovery_location', _("The default location to place discovered hosts in"), ""),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end
    if SETTINGS[:organizations_enabled]
      Setting.transaction do
        [
          self.set('discovery_organization', _("The default organization to place discovered hosts in"), "" ),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end

    true

  end

end
