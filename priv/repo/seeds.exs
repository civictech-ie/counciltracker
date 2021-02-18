# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Counciltracker.Repo.insert!(%Counciltracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Counciltracker.Repo.delete_all(Counciltracker.Authorities.Authority)
Counciltracker.Repo.delete_all(Counciltracker.Events.Event)

Counciltracker.Repo.delete_all(Counciltracker.Councillors.Councillor)
Counciltracker.Repo.delete_all(Counciltracker.Terms.Term)

authority =
  Counciltracker.Repo.insert!(%Counciltracker.Authorities.Authority{
    name: "Dublin City Council"
  })

Counciltracker.Repo.insert!(%Counciltracker.Events.Event{
  authority_id: authority.id,
  occurred_on: ~D[2019-05-24],
  type: :election,
  parameters: %{
    councillors: [
      %{
        given_name: "Michael",
        surname: "Pidgeon",
        area: "South West Inner City",
        party: "Green Party"
      },
      %{
        given_name: "Tina",
        surname: "MacVeigh",
        area: "South West Inner City",
        party: "People Before Profit"
      },
      %{
        given_name: "Michael",
        surname: "Watters",
        area: "South West Inner City",
        party: "Fianna Fáil"
      }
    ]
  }
})

Counciltracker.Events.process!(authority)
