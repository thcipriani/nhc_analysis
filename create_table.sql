CREATE TABLE recipes(
  id INTEGER PRIMARY KEY,
  recipe TEXT,
  year_id INTEGER,
  style_id INTEGER
);

CREATE TABLE styles(
  id INTEGER PRIMARY KEY,
  style TEXT
);

CREATE TABLE years(
  id INTEGER PRIMARY KEY,
  year INTEGER
);

CREATE TABLE malts(
  id INTEGER PRIMARY KEY,
  malt TEXT
);

CREATE TABLE hops(
  id INTEGER PRIMARY KEY,
  hop TEXT
);

CREATE TABLE yeasts(
  id INTEGER PRIMARY KEY,
  yeast TEXT
);

CREATE TABLE sugars(
  id INTEGER PRIMARY KEY,
  sugar TEXT
);

CREATE TABLE malts_recipes(
  id INTEGER PRIMARY KEY,
  malt_id INTEGER,
  recipe_id INTEGER,
  quantity REAL,
  unit REAL
);

CREATE TABLE hops_recipes(
  id INTEGER PRIMARY KEY,
  hop_id INTEGER,
  recipe_id INTEGER,
  quantity REAL,
  unit REAL
);

CREATE TABLE yeasts_recipes(
  id INTEGER PRIMARY KEY,
  yeast_id INTEGER,
  recipe_id INTEGER,
  quantity REAL,
  unit REAL,
  starter INTEGER
);

INSERT INTO styles VALUES
  (1, "BeerBOS"),
  (2, "MeadBOS"),
  (3, "CiderBOS"),
  (4, "LightLager"),
  (5, "Pilsner"),
  (6, "EuroLager"),
  (7, "DarkLager"),
  (8, "Bock"),
  (9, "LightHybrid"),
  (10, "AmberHybrid"),
  (11, "EPA"),
  (12, "Irish"),
  (13, "American"),
  (14, "EBA"),
  (15, "Porter"),
  (16, "Stout"),
  (17, "IPA"),
  (18, "Wheat"),
  (19, "French"),
  (20, "Sour"),
  (21, "Belgian"),
  (22, "Strong"),
  (23, "Old"),
  (24, "Fruit"),
  (25, "Spice"),
  (26, "Smoke"),
  (27, "Special"),
  (28, "Mead"),
  (29, "Mel"),
  (30, "OtherMead"),
  (31, "Cider");

INSERT INTO years VALUES
  (1, 2005),
  (2, 2006),
  (3, 2007),
  (4, 2008),
  (5, 2009),
  (6, 2010),
  (7, 2011),
  (8, 2012);
