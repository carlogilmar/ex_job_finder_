# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RemoteJobs.Repo.insert!(%RemoteJobs.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
RemoteJobs.UserOperator.create_user("codigoambar", "ADMIN", "c0d1g04mb4r")
