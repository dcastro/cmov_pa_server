CREATE TABLE "appointments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "patient_id" integer, "doctor_id" integer, "scheduled_date" datetime, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "doctors" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "sex" varchar(255), "photo" varchar(255) DEFAULT 'http://t1.stooorage.com/thumbs/1073/4386724_new_user.jpg', "created_at" datetime, "updated_at" datetime, "specialty_id" integer);
CREATE TABLE "patients" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "address" varchar(255), "sex" varchar(255), "created_at" datetime, "updated_at" datetime, "version" integer DEFAULT 1);
CREATE TABLE "schedule_plans" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "active" boolean, "start_date" date, "doctor_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "specialties" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "birthdate" date, "username" varchar(255), "hashed_password" varchar(255), "salt" varchar(255), "utilizador_id" integer, "utilizador_type" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "version_logs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "table" varchar(255), "version" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "workdays" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "weekday" integer, "start" integer, "end" integer, "schedule_plan_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20111004103759');

INSERT INTO schema_migrations (version) VALUES ('20111004125111');

INSERT INTO schema_migrations (version) VALUES ('20111004140828');

INSERT INTO schema_migrations (version) VALUES ('20111005140252');

INSERT INTO schema_migrations (version) VALUES ('20111005140346');

INSERT INTO schema_migrations (version) VALUES ('20111005141004');

INSERT INTO schema_migrations (version) VALUES ('20111006104754');

INSERT INTO schema_migrations (version) VALUES ('20111006122235');

INSERT INTO schema_migrations (version) VALUES ('20111007004555');

INSERT INTO schema_migrations (version) VALUES ('20111007005232');

INSERT INTO schema_migrations (version) VALUES ('20111007165938');

INSERT INTO schema_migrations (version) VALUES ('20111010104037');

INSERT INTO schema_migrations (version) VALUES ('20111010153934');