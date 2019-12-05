class Event < ActiveRecord::Base
    belongs_to :artist
    belongs_to :venue

    def self.browse_all_events
        self.all
    end 

    def self.browse_events_by_venue(venue)
        v = Venue.find_by(name: venue)
        Event.where(venue_id: v.id)
    end 

    def self.browse_events_by_artist(artist)
        art = Artist.find_by(name: artist)
        Event.where(artist_id: art.id)
    end 

    def self.browse_events_by_date(date)
    end 

    def self.upcoming_events 
    end 


end 