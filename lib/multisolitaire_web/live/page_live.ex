defmodule MultisolitaireWeb.PageLive do
  use MultisolitaireWeb, :live_view

  import MultisolitaireWeb.CardComponent

  @ranks ["2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace"]
  @suits ["hearts", "diamonds", "clubs", "spades"]

  @cards for suit <- @suits, rank <- @ranks, do: {rank, suit}

  # Initialize the socket with cards and their flipped state
  @impl true
  def mount(_params, _session, socket) do
    # Each card starts with flipped: false
    cards_with_flip =
      Enum.map(@cards, fn {rank, suit} -> %{rank: rank, suit: suit, flipped: false} end)

    {:ok, assign(socket, cards: cards_with_flip)}
  end

  # Handle the flip card event
  @impl true
  def handle_event("flip_card", %{"rank" => rank, "suit" => suit}, socket) do
    # Update the flipped state of the clicked card
    updated_cards =
      Enum.map(socket.assigns.cards, fn card ->
        if card.rank == rank && card.suit == suit do
          # Toggle the flipped state
          %{card | flipped: !card.flipped}
        else
          card
        end
      end)

    {:noreply, assign(socket, cards: updated_cards)}
  end
end
