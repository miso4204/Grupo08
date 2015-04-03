-- Table: vhs_special_offer

-- DROP TABLE vhs_special_offer;

CREATE TABLE vhs_special_offer
(
  id_special_offers integer NOT NULL DEFAULT nextval('vhs_special_offers_id_special_offers_seq'::regclass), -- Unique Id por special offers
  short_name text, -- Special offer short description
  description text, -- Whole description for the published offer
  price double precision, -- Price of the offer
  main_image_url text, -- URL of the main special offer photo
  offer_country integer, -- Country where the offer is located
  offer_city integer, -- City where the offered is located
  latitude double precision, -- offer latitude
  longitude double precision, -- Offer longitude
  offer_category integer, -- Category that offer belongs
  publish_date date, -- Date offer starts
  end_date date, -- End offer date
  CONSTRAINT pk_special_offer PRIMARY KEY (id_special_offers),
  CONSTRAINT fk_category FOREIGN KEY (offer_category)
      REFERENCES vhs_category (id_category) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE vhs_special_offer
  OWNER TO adminjlkmww9;
COMMENT ON TABLE vhs_special_offer
  IS 'Special offers that appears on the main page content.';
COMMENT ON COLUMN vhs_special_offer.id_special_offers IS 'Unique Id por special offers';
COMMENT ON COLUMN vhs_special_offer.short_name IS 'Special offer short description';
COMMENT ON COLUMN vhs_special_offer.description IS 'Whole description for the published offer';
COMMENT ON COLUMN vhs_special_offer.price IS 'Price of the offer';
COMMENT ON COLUMN vhs_special_offer.main_image_url IS 'URL of the main special offer photo';
COMMENT ON COLUMN vhs_special_offer.offer_country IS 'Country where the offer is located';
COMMENT ON COLUMN vhs_special_offer.offer_city IS 'City where the offered is located';
COMMENT ON COLUMN vhs_special_offer.latitude IS 'offer latitude';
COMMENT ON COLUMN vhs_special_offer.longitude IS 'Offer longitude';
COMMENT ON COLUMN vhs_special_offer.offer_category IS 'Category that offer belongs';
COMMENT ON COLUMN vhs_special_offer.publish_date IS 'Date offer starts';
COMMENT ON COLUMN vhs_special_offer.end_date IS 'End offer date';


-- Index: fki_category

-- DROP INDEX fki_category;

CREATE INDEX fki_category
  ON vhs_special_offer
  USING btree
  (offer_category);


